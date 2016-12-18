SITE := docs
SOURCE := src
FILES := CNAME index.html style.css
SITE_FILES := $(FILES:%=$(SITE)/%)
SPEC_BUILDER_REPO := https://github.com/yaml/yaml-spec-builder-docker
SPEC_VERSION := 1.2
SPEC_BUILDER += yaml-spec-builder
SPEC := $(SITE)/spec/$(SPEC_VERSION)

all: site spec

site: $(SITE_FILES)

spec: $(SPEC)

clean:
	rm -fr $(SPEC_BUILDER)

#-----------------------------------------------------------------------------#
$(SITE)/%: $(SOURCE)/%
	cp $< $@

$(SITE)/spec/$(SPEC_VERSION): $(SPEC_BUILDER)
	make -C $< spec
	cp -r $(SPEC_BUILDER)/spec/* $@/

$(SPEC_BUILDER):
	git clone $(SPEC_BUILDER_REPO) $@
