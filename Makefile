SHELL := bash

SPEC_DIR := /tmp/yaml-spec
SPEC_REPO := https://github.com/yaml/yaml-spec
SPEC_BRANCH := spec.yaml.io

default:

publish: build
	git -C gh-pages add -A .
	git -C gh-pages commit --allow-empty -m 'Publish yaml.org -- $(shell date)'
	git -C gh-pages push origin gh-pages
	rm -fr gh-pages

build: gh-pages spec/1.2.1/index.html
	rm -fr $</*
	cp -r *.html *.svg css img spec type gh-pages/
	echo yaml.org > $</CNAME

clean:
	rm -fr gh-pages $(SPEC_DIR)

gh-pages:
	@git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

spec/1.2.1/index.html: $(SPEC_DIR)/www/html/spec.html
	@mkdir -p $$(dirname $@)
	make -C $(SPEC_DIR) html
	cat template/head.html \
	    $< \
	    template/foot.html \
	    > $@

$(SPEC_DIR)/www/html/spec.html: $(SPEC_DIR)
	make -C $< html

$(SPEC_DIR):
	git clone --branch $(SPEC_BRANCH) $(SPEC_REPO) $@
