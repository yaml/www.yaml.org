SITE := www.yaml.org
SITE_REPO := https://github.com/yaml/yaml-org-site
FILES := CNAME index.html style.css
SITE_FILES := $(FILES:%=$(SITE)/%)
SPEC_BUILDER_REPO := https://github.com/yaml/yaml-spec-builder-docker
SPEC_VERSION := 1.2
BUILDER += yaml-spec-builder

html: 
	./yaml2html.pl index.yml > index.html 

site: $(SITE) $(SITE_FILES) $(SITE)/spec/$(SPEC_VERSION)

publish: site
	( \
	    cd $(SITE); \
	    git add -A .; \
	    git commit -m 'yaml.org site changes'; \
	    git push origin gh-pages \
	)

clean:
	rm -fr $(BUILDER) $(SITE)

#-----------------------------------------------------------------------------#
$(SITE):
	git clone -b gh-pages $(SITE_REPO) $@

$(SITE)/%: %
	cp $< $@

$(SITE)/spec/$(SPEC_VERSION): $(BUILDER)
	(cd $<; make spec)
	mkdir -p $(SITE)/spec
	mv $(BUILDER)/spec $@

$(BUILDER):
	git clone $(SPEC_BUILDER_REPO) $@
