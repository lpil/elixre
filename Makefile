NBIN=./node_modules/.bin


help: ## Prints help for targets with comments
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


install: ## Install deps
	mix deps.get
	yarn install
	$(NBIN)/elm-package install


start: ## Start the server in dev mode
	iex -S mix


start-production:
	MIX_ENV=production mix app.start


frontend-server:
	NODE_ENV=development $(NBIN)/webpack-dev-server --hot --inline --content-base src/, --no-info --colors


build: ## Compile the frontend
	rm -rf dist
	NODE_ENV=production $(NBIN)/webpack -p


.PHONY: \
	start-production \
	frontend-server \
	install \
	start \
	build \
	help
