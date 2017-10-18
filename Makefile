NODE_MODULES_BIN = $(realpath ./node_modules/.bin)
ELM_FILES = $(shell find src -name '*.elm' -type f)

help: ## Prints a help guide
	@echo "Available tasks:"
	@grep -E '^[\%a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


all: documentation.json test analyse ## Test and build everything


install: ## Install build dependencies
	@echo "> Installing build dependencies..."
	@npm install


elm-stuff:
	@$(NODE_MODULES_BIN)/elm-package install --yes


test: tests/Doc tests/elm-stuff ## Run tests with human readable output
	@echo "> Running tests..."
	@$(NODE_MODULES_BIN)/elm-test --compiler $(NODE_MODULES_BIN)/elm-make


tests/Doc: $(ELM_FILES)
	@echo "> Preparing example tests..."
	@$(NODE_MODULES_BIN)/elm-verify-examples


tests/elm-stuff: tests/elm-package.json
	@cd tests && $(NODE_MODULES_BIN)/elm-package install --yes


documentation.json: elm-stuff $(ELM_FILES) ## Generate Elm documentation file
	@echo "> Generating Elm documentation file..."
	@$(NODE_MODULES_BIN)/elm-make --yes --warn --docs=$@


analyse: ## Analyse source files
	@echo "> Analysing .elm files..."
	@mkdir -p $(REPORTS_DIR)/
	@$(NODE_MODULES_BIN)/elm-analyse --elm-format-path $(NODE_MODULES_BIN)/elm-format


format: ## Format source files
	@echo "> Formatting source files..."
	@$(NODE_MODULES_BIN)/elm-format src/ --yes
	@$(NODE_MODULES_BIN)/elm-format tests/ --yes


clean: ## Clean build artefacts and caches
	@echo "> Cleaning build artefacts and caches..."
	@rm -rf elm-stuff/ tests/elm-stuff/ tests/Doc/


clean-deps: ## Clean dependencies
	@echo "> Cleaning dependencies..."
	@rm -rf node_modules/*


clean-all: clean clean-deps ## Clean everything
