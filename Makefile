DART_SASS_EMBEDDED_DIR = node_modules/sass-embedded/dist/lib/src/vendor/dart-sass-embedded

# Hugo can only use dart-sass-embedded if the binary is present on $PATH.
# Expand $PATH for Hugo's benefit so it can use the version installed in node_modules
HUGO = PATH=$(DART_SASS_EMBEDDED_DIR):${PATH} hugo

.PHONY: build dev

build: node_modules
	$(HUGO)

dev: node_modules
	$(HUGO) serve

node_modules: package.json package-lock.json
	npm install && touch $@
