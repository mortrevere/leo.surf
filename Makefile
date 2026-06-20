DOCKER ?= docker
BROWSER ?= firefox

help: ## show this message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '(^[a-zA-Z0-9_%-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
	@echo ""
	@echo "Env:"
	@grep -E '^[a-zA-Z0-9_-]+\s*[?:]?=.*$$' $(MAKEFILE_LIST) | grep -Eo '^[a-zA-Z0-9_-]+' | xargs -I {} make -s print-{}
.PHONY: help

print-%:
	@echo -e '\033[32m$*\033[0m = $($*)'
.PHONY: print-%

lint: ## lint project
	@true
.PHONY: lint

clean: ## delete any build
	rm -rf build
.PHONY: clean

build: ## build project
	$(DOCKER) run --rm -u $$(id -u):$$(id -g) -v $$(pwd):/jinjapocalypse jinjapocalypse
.PHONY: build

open: build ## open project on your browser
	$(BROWSER) build/index.html
.PHONY: open
