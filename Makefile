SHELL := bash

SPEC_DIR := /tmp/yaml-spec
SPEC_REPO := https://github.com/yaml/yaml-spec
SPEC_BRANCH := spec.yaml.io

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
	@printf '%s\n' $(SPEC_121_FILES)

serve: build
	python3 -m http.server 8000

publish: gh-pages build
	rm -fr $</*
	cp -r *.html favicon.svg css img spec type $</
	echo yaml.org > $</CNAME
	git -C $< add -A .
	git -C $< commit --allow-empty -m 'Publish yaml.org -- $(shell date)'
	git -C $< push origin $<

build: $(SPEC_121_FILES)

clean:
	rm -fr gh-pages $(SPEC_DIR) $(SPEC_121_DIR)

gh-pages:
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
