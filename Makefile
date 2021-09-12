SHELL := bash

SITE := gh-pages
SPEC_REPO_DIR := /tmp/yaml-spec
SPEC_REPO := https://github.com/yaml/yaml-spec
SPEC_BRANCH ?= main
HTML := $(SPEC_REPO_DIR)/www/html

CNAME ?= yaml.org
COMMON := /tmp/yaml-common
COMMON_REPO := https://github.com/yaml/yaml-common

SPEC := spec
SPEC_HTML_DIR := $(SPEC_REPO_DIR)/www/html
SPEC_FILES_CMD := \
    find $(SPEC_HTML_DIR) -type f | sort | grep -v title
SPEC_FILES := $(shell $(SPEC_FILES_CMD))
SPEC_FILES := $(SPEC_FILES:$(SPEC_HTML_DIR)/%=spec/%)
SPEC_FILES := $(SPEC_FILES:%.html=%/index.html)
SPEC_FILES := $(SPEC_FILES:%/spec/index.html=%/index.html)

FAVICON := favicon.svg

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
	echo $(CNAME) > $</CNAME

files: $(FAVICON) $(SPEC_REPO_DIR)
	$(MAKE) spec-files

spec-files: $(SPEC_FILES)

force:
	rm -fr $(SITE) $(SPEC)/1.2.*

clean: force
	rm -fr $(FAVICON) $(COMMON) $(SPEC_REPO_DIR) $(SPEC)/1.2.*

$(SITE):
	@git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

$(COMMON):
	git clone $(COMMON_REPO) $@

$(FAVICON): $(COMMON)
	cp $</image/yaml-logo.svg $@

$(SPEC_REPO_DIR):
	git clone --branch $(SPEC_BRANCH) $(SPEC_REPO) $@
	$(MAKE) -C $@ html

$(SPEC)/%/index.html: $(HTML)/%/spec.html
	@mkdir -p $(dir $@)
	$(eval override V := $(@:$(SPEC)/%/index.html=%))
	$(eval override T := $(HTML)/$V/title.html)
	$(call render)
	perl -pi -e 's{/main/}{/spec/$V/}g' $@

$(SPEC)/%/index.html: $(HTML)/%.html
	@mkdir -p $(dir $@)
	$(eval override V := $(@:$(SPEC)/%/index.html=%))
	$(eval override V := $(firstword $(subst /, ,$V)))
	$(eval override T := $(HTML)/$V/title.html)
	$(call render)

$(SPEC)/%: $(HTML)/%
	@mkdir -p $(dir $@)
	cp $< $@

define render
cp template/$V.html $@
sed -e '/%%%TITLE%%%/ {' -e 'r $T' -e 'd' -e '}' -i $@
sed -e '/%%%BODY%%%/ {' -e 'r $<' -e 'd' -e '}' -i $@
endef
