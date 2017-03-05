NBIN=$(shell pwd)/node_modules/.bin
ELM_TEST=$(NBIN)/elm-test --compiler $(NBIN)/elm-make


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: install
install: ## Install deps
	mix deps.get
	yarn install
	$(NBIN)/elm-package install


.PHONY: start
start: ## Start the server in dev mode
	iex -S mix


.PHONY: start-production
start-production:
	MIX_ENV=production mix app.start


.PHONY: frontend-server
frontend-server:
	NODE_ENV=development $(NBIN)/webpack-dev-server --hot --inline --content-base src/, --no-info --colors


.PHONY: build
build: ## Compile the frontend
	rm -rf dist
	NODE_ENV=production $(NBIN)/webpack -p


.PHONY: elm-test
elm-test: ## Run the front end tests
	$(ELM_TEST)


.PHONY: elm-test-watch
elm-test-watch: ## Run the front end test watcher
	$(ELM_TEST) --watch
