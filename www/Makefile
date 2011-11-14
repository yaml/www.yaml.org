HTML=index.html todo.html refcard.html discuss.html download.html \
     faq.html start.html about.html tutorial.html link.html xml.html

all: ${HTML}

index.html: header.txt menu.txt index.txt footer.txt
	cat header.txt menu.txt index.txt footer.txt > $@
todo.html: header.txt menu.txt todo.txt footer.txt 
	cat header.txt menu.txt todo.txt footer.txt > $@
refcard.tmp: refcard.txt
	cat refcard.txt | sed 's/&/\&amp;/g' | sed 's/</\&lt;/g' > refcard.tmp 
refcard.html: header.txt menu.txt refbeg.txt refcard.tmp refend.txt footer.txt 
	cat header.txt menu.txt refbeg.txt refcard.tmp refend.txt footer.txt > $@
discuss.html: header.txt menu.txt discuss.txt footer.txt 
	cat header.txt menu.txt discuss.txt footer.txt > $@
download.html: header.txt menu.txt download.txt footer.txt 
	cat header.txt menu.txt download.txt footer.txt > $@
faq.html: header.txt menu.txt faq.txt footer.txt 
	cat header.txt menu.txt faq.txt footer.txt > $@
start.html: header.txt menu.txt start.txt footer.txt 
	cat header.txt menu.txt start.txt footer.txt > $@
about.html: header.txt menu.txt about.txt footer.txt 
	cat header.txt menu.txt about.txt footer.txt > $@
tutorial.html: header.txt menu.txt tutorial.txt footer.txt 
	cat header.txt menu.txt tutorial.txt footer.txt > $@
link.html: header.txt menu.txt link.txt footer.txt 
	cat header.txt menu.txt link.txt footer.txt > $@
xml.html: header.txt menu.txt xml.txt footer.txt 
	cat header.txt menu.txt xml.txt footer.txt > $@

clean:
	rm -f ${HTML} ~* *~
