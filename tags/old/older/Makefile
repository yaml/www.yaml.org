.SUFFIXES: .dbk .html

HTML = \
  spec.html changes.html type.html \
  bool.html binary.html float.html int.html merge.html null.html \
  timestamp.html value.html yaml.html omap.html pairs.html set.html

all: $(HTML)

clean:
	rm -f $(HTML)

tgz: all
	tar czf DocBookYaml.tgz Makefile *.dbk *.html *.xsl *.css

$(HTML): single_html.xsl preprocess.xsl

spec.html: spec.dbk
	xsltproc preprocess.xsl $*.dbk > p1.xml
	xsltproc single_html.xsl p1.xml > p2.xml
	sed '\
	s/width="3%"/class="productioncounter"/g;\
	s/width="10%"/class="productionlhs"/g;\
	s/width="5%"/class="productionseperator"/g;\
	s/width="52%"/class="productionrhs"/g;\
	s/width="30%"/class="productioncomment"/g;' \
	p2.xml > $*.html
	rm p1.xml p2.xml

.dbk.html:
	xsltproc single_html.xsl $*.dbk > $*.html
