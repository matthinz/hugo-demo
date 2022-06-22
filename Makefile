SASS_EMBEDDED_VERSION = 1.53.0
SASS_EMBEDDED_URL := $(shell bin/sass_embedded_url $(SASS_EMBEDDED_VERSION))

# Hugo can only use dart-sass-embedded if the binary is present on $PATH.
# Expand $PATH for Hugo's benefit so it can use our local version of the binary.
HUGO = PATH=bin/sass_embedded:${PATH} hugo

.PHONY: build dev

build: node_modules bin/sass_embedded
	$(HUGO)

dev: node_modules bin/sass_embedded
	$(HUGO) serve

bin:
	mkdir $@

bin/sass_embedded:
	cd $(shell dirname $@) && curl -L $(SASS_EMBEDDED_URL) > .sass_embedded.tar.gz && tar xzf .sass_embedded.tar.gz

node_modules: package.json package-lock.json
	npm install && touch $@
