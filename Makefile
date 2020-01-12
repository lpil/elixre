NBIN=$(shell pwd)/node_modules/.bin
ELM_TEST=$(NBIN)/elm-test --compiler $(NBIN)/elm-make

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Start the server in dev mode
	iex -S mix

.PHONY: frontend-server
frontend-watch:
	watchexec -e elm "echo; $(NBIN)/elm-make src/Main.elm --output priv/public/main.js; echo"

.PHONY: elm-test
elm-test: ## Run the front end tests
	$(ELM_TEST)

.PHONY: elm-test-watch
elm-test-watch: ## Run the front end test watcher
	$(ELM_TEST) --watch
