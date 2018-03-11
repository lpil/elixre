Elixre
======

[![Build Status](https://travis-ci.org/lpil/elixre.svg?branch=v2/master)](https://travis-ci.org/lpil/elixre)

An Elixir regular expression editor & tester.

A massive rip off of Michael Lovitt's [Rubular](http://rubular.com/).


## Usage

```sh
# Print dev usage
make
# Start the app in dev mode
make start

# Run backend tests
mix test
# Run frontend tests
make elm-test-watch
```


## Setup

Install Elixir and Node.

```sh
cd path/to/elixre

# Install the deps
npm i -g yarn
make install
```

## Deployment

```sh
cd path/to/elixre

heroku login
heroku git:remote -a $HEROKU_PROJECT_NAME
heroku buildpacks:set https://github.com/HashNuke/heroku-buildpack-elixir.git
heroku buildpacks:add --index 1 heroku/nodejs
git push heroku v2/master:master
```



## LICENCE

```
Elixre - An Elixir regular expression editor & tester
Copyright © 2015 - Present Louis Pilfold

This program  is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
```
