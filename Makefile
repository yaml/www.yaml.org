SITE := docs
SOURCE := src
SOURCE_FILES := $(shell cd $(SOURCE); find . -type f | cut -d/ -f2-)
SITE_FILES := $(SOURCE_FILES:%=$(SITE)/%)
SPEC_BUILDER += yaml-spec-builder
SPEC_BUILDER_REPO := https://github.com/yaml/$(SPEC_BUILDER)
SPEC_VERSION := 1.2
SPEC := $(SITE)/spec/$(SPEC_VERSION)

all: site spec

site: $(SITE_FILES)

spec: $(SPEC)

clean:
	rm -fr $(SPEC_BUILDER)

#-----------------------------------------------------------------------------#
$(SITE)/%: $(SOURCE)/%
	cp $< $@

$(SPEC): $(SPEC_BUILDER) force
	make -C $< spec
	rm -fr $@
	mv $(SPEC_BUILDER)/spec $@

force:

$(SPEC_BUILDER):
	git clone $(SPEC_BUILDER_REPO) $@
