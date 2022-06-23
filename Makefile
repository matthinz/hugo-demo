DART_SASS_EMBEDDED_DIR = node_modules/sass-embedded/dist/lib/src/vendor/dart-sass-embedded

HUGO_BIN = .bin/hugo

# Hugo can only use dart-sass-embedded if the binary is present on $PATH.
# Expand $PATH for Hugo's benefit so it can use the version installed in node_modules
HUGO = PATH=$(DART_SASS_EMBEDDED_DIR):${PATH} $(HUGO_BIN)

HUGO_BIND ?= 127.0.0.1

HUGO_VERSION := $(shell cat .nvmrc)

NODE_VERSION := $(shell cat .nvmrc)

.PHONY: build clean dev docker

build: $(HUGO_BIN) node_modules
	$(HUGO)

clean:
	-rm -rf _site node_modules public .docker-image .bin

dev: $(HUGO_BIN) node_modules
	$(HUGO) serve --bind ${HUGO_BIND} --buildDrafts --noHTTPCache

docker: .docker-image
	docker run \
		-it \
		--init \
		--env HUGO_BIND=0.0.0.0 \
		--publish 1313:1313 \
		--workdir /usr/src/app \
		--volume $(shell pwd):/usr/src/app \
		$(shell cat $<) \
		make dev

federalist: $(HUGO_BIN) node_modules
	$(HUGO) --baseURL ${BASEURL}

.docker-image: Makefile Dockerfile .hugo-version .nvmrc
	docker build --build-arg NODE_VERSION=$(NODE_VERSION) --iidfile $@ .

$(HUGO_BIN):
	mkdir -p $(shell dirname $@)
	curl -L $(shell bin/hugo-url) > $@.tar.gz
	cd $(shell dirname $@) && tar xzf $(shell basename $@).tar.gz hugo && rm $(shell basename $@).tar.gz

node_modules: package.json package-lock.json
	npm install && touch $@
