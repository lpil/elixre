# The version of Alpine to use for the final image
# This should match the version of Alpine that the release-builder image uses
# https://github.com/bitwalker/alpine-erlang/blob/master/Dockerfile
ARG ALPINE_VERSION=3.10

########################################################################

FROM node:slim as frontend-builder

ENV MIX_ENV=prod \
  REPLACE_OS_VARS=true \
  HOME=/app/
WORKDIR $HOME

RUN apt-get update && apt-get install --yes libgmp-dev netbase ca-certificates

COPY elm-package.json package.json package-lock.json ./
COPY priv ./priv

RUN npm install \
  && mkdir src \
  && printf 'module Main exposing (..)\nimport Html\nmain = Html.div [] []' > src/Main.elm \
  && ./node_modules/.bin/elm-make src/Main.elm --output priv/public/main.js --yes \
  && rm src/Main.elm \
  && rm priv/public/main.js

COPY src/* ./src/

RUN ./node_modules/.bin/elm-make src/Main.elm --output priv/public/main.js --yes

########################################################################

FROM bitwalker/alpine-elixir-phoenix:1.9.2 as release-builder

ENV MIX_ENV=prod \
  REPLACE_OS_VARS=true \
  HOME=/app/
WORKDIR $HOME

RUN apk add --update alpine-sdk coreutils

COPY --from=frontend-builder /app/priv /app/priv

# Compile deps
COPY mix.exs mix.lock ./
COPY config ./config
RUN mix do local.hex --force, local.rebar --force \
  && mix do deps.get --only $MIX_ENV, deps.compile

COPY lib ./lib

# Compile app
RUN mix do compile, release


########################################################################

FROM alpine:${ALPINE_VERSION}
LABEL maintainer="Louis Pilfold <louis@lpil.uk>"

EXPOSE 3000
ENV PORT=3000 \
  MIX_ENV=prod \
  REPLACE_OS_VARS=true \
  SHELL=/bin/bash \
  LANG=en_US.UTF-8 \
  HOME=/app/ \
  TERM=xterm \
  APP_VERSION=1.0.0 \
  APP_GIT_SHA=$SOURCE_VERSION
WORKDIR $HOME

COPY --from=release-builder /app/_build/prod/rel/elixre /app

RUN apk add --no-cache openssl-dev bash libgcc \
  && adduser -S www-elixre \
  && mkdir -p /app \
  && chown --recursive www-elixre /app
USER www-elixre

ENTRYPOINT ["/app/bin/elixre"]
CMD ["start"]
