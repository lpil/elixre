help: ## Prints help for targets with comments
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install deps
	npm install
	./node_modules/elm/binwrappers/elm-package install

start: ## Start dev server
	./node_modules/webpack-dev-server/bin/webpack-dev-server.js --hot --inline --content-base src/,

build: ## Compile the app
	rm -rf dist
	./node_modules/webpack/bin/webpack.js

.PHONY: \
	install \
	start \
	build \
	help
