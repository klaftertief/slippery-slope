NODE_MODULES_BIN = ./node_modules/.bin
ELM_FILES = $(shell find src -name '*.elm' -type f)

help: ## Prints a help guide
	@echo "Available tasks:"
	@grep -E '^[\%a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


all: test analyse ## Test and build everything


install: ## Install build dependencies
	@echo "> Installing build dependencies..."
	@npm install


test: prepare-elm-verify-examples ## Run tests with human readable output
	@echo "> Running tests..."
	@$(NODE_MODULES_BIN)/elm-test --compiler $(NODE_MODULES_BIN)/elm-make


prepare-elm-verify-examples:
	@echo "> Preparing example tests..."
	@$(NODE_MODULES_BIN)/elm-verify-examples


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
	@rm -rf elm-stuff/
	@rm -rf tests/Doc/


clean-deps: ## Clean dependencies
	@echo "> Cleaning dependencies..."
	@rm -rf node_modules/*


clean-all: clean clean-deps ## Clean everything
