SHELL := bash

SITE := gh-pages
SPEC_REPO_DIR := /tmp/yaml-spec
SPEC_REPO := https://github.com/yaml/yaml-spec
# XXX
# SPEC_BRANCH ?= main
SPEC_BRANCH ?= spec-dirs-refactor
HTML := $(SPEC_REPO_DIR)/www/html

# XXX
# CNAME ?= yaml.org
CNAME ?= org.yaml.io
COMMON := /tmp/yaml-common
COMMON_REPO := https://github.com/yaml/yaml-common

SPEC := spec
SPEC_FILES := \
    1.2.0/index.html \
    1.2.0/errata/index.html \
    1.2.0/single_html.css \
    1.2.0/model2.png \
    1.2.0/overview2.png \
    1.2.0/present2.png \
    1.2.0/represent2.png \
    1.2.0/serialize2.png \
    1.2.0/styles2.png \
    1.2.0/term.png \
    1.2.0/validity2.png \
    \
    1.2.1/index.html \
    1.2.1/errata/index.html \
    1.2.1/single_html.css \
    1.2.1/model2.png \
    1.2.1/overview2.png \
    1.2.1/present2.png \
    1.2.1/represent2.png \
    1.2.1/serialize2.png \
    1.2.1/styles2.png \
    1.2.1/term.png \
    1.2.1/validity2.png \
    \
    1.2.2/index.html \
    1.2.2/community/index.html \
    1.2.2/core-team/index.html \
    1.2.2/implementer-refs/index.html \
    1.2.2/spec-authors/index.html \
    1.2.2/spec-changes/index.html \
    1.2.2/spec-errata/index.html \
    1.2.2/user-refs/index.html \
    1.2.2/spec.css \
    1.2.2/img/ \


SPEC_FILES := $(SPEC_FILES:%=$(SPEC)/%)

FAVICON := favicon.svg

default:

serve: build
	(cd $(SITE) && python3 -m http.server 8000)

publish: build
	git -C $(SITE) add -A .
	git -C $(SITE) commit --allow-empty -m 'Publish yaml.org -- $(shell date)'
	# XXX git -C $(SITE) push origin $(SITE)
	git -C $(SITE) push -f git@github.com:ingydotnet/www.yaml.org $(SITE)

build: $(SITE) files
	rm -fr $</*
	cp -r *.html favicon.svg css img spec type $</
	echo $(CNAME) > $</CNAME

files: $(FAVICON) $(SPEC_REPO_DIR) $(SPEC_FILES)

force:
	rm -fr $(SITE) $(SPEC)/1.2.*

clean: force
	rm -fr $(FAVICON) $(COMMON) $(SPEC_REPO_DIR)

$(SITE):
	@git branch --track $@ origin/$@ 2>/dev/null || true
	git worktree add -f $@ $@

$(COMMON):
	git clone $(COMMON_REPO) $@

$(FAVICON): $(COMMON)
	cp $</image/yaml-logo.svg $@

$(SPEC_REPO_DIR):
	git clone --branch $(SPEC_BRANCH) $(SPEC_REPO) $@
	make -C $@ html

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

$(SPEC)/%/: $(HTML)/%
	@mkdir -p $(shell dirname $@)
	cp -r $< $(shell dirname $@)

define render
cp template/$V.html $@
sed -e '/%%%TITLE%%%/ {' -e 'r $T' -e 'd' -e '}' -i $@
sed -e '/%%%BODY%%%/ {' -e 'r $<' -e 'd' -e '}' -i $@
endef
