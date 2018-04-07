s/{.monospace.font.family}/monospace/g;
s/fo:table id/fo:table space-before.minimum="0.8em" space-before.optimum="1em" space-before.maximum="2em" id/;
s/"monospace"/"monospace,Symbol,ZapfDingbats"/g;
s/-4pc/-1pc/g;
/internal-destination/s/>Index</>C. YAML Terms</;
/fo:block /s/>Index</>Appendix C.<\/fo:block><fo:block>YAML Terms</;
s/>Index</>Appendix C. YAML Terms</;
s/column-gap="12pt"/column-gap="1in"/g;
/column-number="1"/s/3%/5%/;
/column-number="2"/s/15%/37%/;
/column-number="3"/s/5%/5%/;
/column-number="4"/s/52%/53%/;
/column-number="5"/s/25%/0%/;
/fo:block text-align="start">\[/,/::/s/fo:block text-align="end"/fo:block text-align="end" font-family="monospace,Symbol,ZapfDingbats"/
/::=/,/fo:block text-align="start"/s/\/\* \(.*\) \*\//\/\* <fo:inline font-family="serif,Symbol,ZapfDingbats">\1<\/fo:inline> \*\//g
/::=/,/fo:block text-align="start"/s/<fo:block>/<fo:block font-family="monospace,Symbol,ZapfDingbats">/
/fo:block.*white-space-collapse="false"/,/fo:block>/s/^ / /g;
t again
: again
s/  /  /g;
t again
