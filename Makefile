.SUFFIXES: .dbk .html .pdf .eps .dia .png

XEP = /bin/sh /usr/local/XEP/xep.sh \
    -DTMPDIR=/tmp -quiet

HTML = \
  spec.html changes.html type.html \
  bool.html binary.html float.html int.html merge.html null.html \
  timestamp.html value.html yaml.html omap.html pairs.html set.html

HTML_IMAGES = \
  model2.png overview2.png present2.png represent2.png \
  serialize2.png styles2.png validity2.png

PDF = \
  spec.pdf changes.pdf type.pdf \
  bool.pdf binary.pdf float.pdf int.pdf merge.pdf null.pdf \
  timestamp.pdf value.pdf yaml.pdf omap.pdf pairs.pdf set.pdf

PDF_IMAGES = \
  model2.eps overview2.eps present2.eps represent2.eps \
  serialize2.eps styles2.eps validity2.eps

all: YamlSpec.tgz
html: $(HTML)
eps: $(PDF_IMAGES)
png: $(HTML_IMAGES)
pdf: $(PDF)

clean:
	rm -f $(HTML) $(PDF) productionsrecap.dbk *.ps \
	$(HTML_IMAGES) $(PDF_IMAGES) *~ *.tgz

YamlSpec.tgz: $(HTML) $(PDF)
	mkdir -p yamldocs
	cp *.html *.pdf *.png *.css yamldocs
	tar czf YamlSpec.tgz yamldocs
	rm -rf yamldocs

$(PDF): single_fo.xsl preprocess_fo.xsl
$(HTML): single_html.xsl preprocess_html.xsl

.dia.eps: 
	dia --size 640 --export $*.eps $*.dia
.dia.png: 
	dia --size 640 --export $*.png $*.dia

.dbk.html: single_html.xsl
	xsltproc single_html.xsl $*.dbk > $*.html

.dbk.pdf: single_fo.xsl
	xsltproc --param generate.toc "''" single_fo.xsl $*.dbk > tmp.xml
	$(XEP) tmp.xml -ps $*.ps
	ps2pdf $*.ps
	rm tmp.xml $*.ps

changes.pdf: changes.dbk
	xsltproc single_fo.xsl changes.dbk > tmp1.xml
	sed 's/Chapter.//g' < tmp1.xml > tmp2.xml
	$(XEP) tmp2.xml -ps changes.ps
	ps2pdf changes.ps
	rm tmp1.xml tmp2.xml changes.ps

type.pdf: type.dbk
	xsltproc single_fo.xsl type.dbk > tmp1.xml
	sed 's/11em/24em/g' < tmp1.xml > tmp2.xml
	$(XEP) tmp2.xml -ps type.ps
	ps2pdf type.ps
	rm tmp1.xml tmp2.xml type.ps

spec.pdf: spec.dbk productionsrecap.dbk \
          preprocess_fo.sed preprocess_ps.sed \
          $(PDF_IMAGES)
	xsltproc preprocess_fo.xsl spec.dbk > tmp1.xml
	xsltproc single_fo.xsl tmp1.xml > tmp2.xml
	sed -f preprocess_fo.sed tmp2.xml > tmp3.xml
	@echo "XEP: Expect a [warning]; remove -quiet if you want to hunt it."
	$(XEP) tmp3.xml -ps tmp3.ps
	sed -f preprocess_ps.sed tmp3.ps > spec.ps
	ps2pdf spec.ps
	rm tmp1.xml tmp2.xml tmp3.xml tmp3.ps

spec.html: spec.dbk preprocess_png.sed preprocess_html.sed \
           productionsrecap.dbk $(HTML_IMAGES)
	sed -f preprocess_png.sed spec.dbk > tmp1.xml
	xsltproc preprocess_html.xsl tmp1.xml > tmp2.xml
	xsltproc single_html.xsl tmp2.xml > tmp3.xml
	sed -f preprocess_html.sed tmp3.xml > spec.html
	rm tmp1.xml tmp2.xml tmp3.xml

productionsrecap.dbk: spec.dbk productionsrecap.xsl
	xsltproc productionsrecap.xsl spec.dbk \
        | grep -v '<?xml version' > productionsrecap.dbk

