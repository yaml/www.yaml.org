SHELL := bash

SITE := gh-pages
SPEC_DIR := /tmp/yaml-spec
SPEC_REPO := https://github.com/yaml/yaml-spec
SPEC_BRANCH := main

SPEC_121_DIR := spec/1.2.1
SPEC_121_FILES := \
    index.html \
    spec.css \
    img \
    user-refs/index.html \
    implementer-refs/index.html \
    spec-errata/index.html \
    spec-authors/index.html \
    spec-changes/index.html \
    core-team/index.html \

SPEC_121_FILES := $(SPEC_121_FILES:%=$(SPEC_121_DIR)/%)

default:

serve: build
	(cd $(SITE) && python3 -m http.server 8000)

publish: build
	git -C $(SITE) add -A .
	git -C $(SITE) commit --allow-empty -m 'Publish yaml.org -- $(shell date)'
	git -C $(SITE) push origin $(SITE)

build: $(SITE) files
	rm -fr $</*
	cp -r *.html favicon.svg css img spec type $</
	echo yaml.org > $</CNAME

files: $(SPEC_121_FILES)

force:
	rm -fr $(SITE)a$(SPEC_121_DIR)

clean:
	rm -fr $(SITE) $(SPEC_DIR) $(SPEC_121_DIR)

$(SITE):
	@git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

$(SPEC_121_DIR)/index.html: $(SPEC_DIR)/www/html/spec.html template/*
	$(call render-html,$<,$@)
	perl -pi -e 's{XXXHTMLXXX}{$(SPEC_121_DIR)}g' $@

$(SPEC_121_DIR)/%/index.html: $(SPEC_DIR)/www/html/%.html template/*
	$(call render-html,$<,$@)

$(SPEC_121_DIR)/%: $(SPEC_DIR)/www/html/%
	cp -r $< $@

$(SPEC_DIR)/www/html/%: $(SPEC_DIR)/www/html

$(SPEC_DIR)/www/html/%: $(SPEC_DIR)
	make -C $< html

$(SPEC_DIR):
	git clone --branch $(SPEC_BRANCH) $(SPEC_REPO) $@

define render-html
@mkdir -p $$(dirname $2)
cat \
    template/head.html \
    $1 \
    template/foot.html \
    > $2
endef
