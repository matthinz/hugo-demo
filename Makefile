DART_SASS_EMBEDDED_DIR = node_modules/sass-embedded/dist/lib/src/vendor/dart-sass-embedded

# Hugo can only use dart-sass-embedded if the binary is present on $PATH.
# Expand $PATH for Hugo's benefit so it can use the version installed in node_modules
HUGO = PATH=$(DART_SASS_EMBEDDED_DIR):${PATH} bin/hugo

.PHONY: build dev

build: bin/hugo node_modules
	$(HUGO)

dev: bin/hugo node_modules
	$(HUGO) serve

bin/hugo:
	mkdir -p $(shell dirname $@)
	curl -L https://github.com/gohugoio/hugo/releases/download/v0.101.0/hugo_0.101.0_Linux-64bit.tar.gz > $@.tar.gz
	cd $(shell dirname $@) && tar xzf $(shell basename $@).tar.gz

node_modules: package.json package-lock.json
	npm install && touch $@
