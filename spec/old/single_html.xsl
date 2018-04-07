<?xml version="1.0"?> 

<!--
 - Customize the generation of HTML from the DocBook sources for the YAML spec.
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"> 

  <!-- Invoke the DocBook -> HTML conversion stylesheet -->
  <xsl:import href="file:///usr/local/share/xsl/docbook/xhtml/docbook.xsl" /> 


  <xsl:output method="xml" encoding="ISO-8859-1" indent="yes"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

  <!--
   - Tweak the generation of a table of contents:
  -->

  <!-- Use a CSS stylesheet to customize the HTML file. -->
  <xsl:param name="html.stylesheet" select="'single_html.css'"></xsl:param>

  <!-- Supress including all abstracts in the META tag. -->
  <xsl:param name="generate.meta.abstract" select="0"></xsl:param>

  <!-- Generate "more valid" HTML. -->
  <xsl:param name="make.valid.html" select="0"></xsl:param>

  <!-- Disable EBNF table border (leave it to the CSS). -->
  <xsl:param name="ebnf.table.border" select="0"></xsl:param>

  <!-- Disable EBNF table color (leave it to the CSS). -->
  <xsl:param name="ebnf.table.bgcolor" select="''"></xsl:param>

  <!-- Auto-number sections. The default doesn't. -->
  <xsl:param name="section.autolabel" select="1" />

  <!-- Include chapter number in section number (1.2 instead of 2). -->
  <xsl:param name="section.label.includes.component.label" select="1" />

  <!-- Include sect3 elements in TOC (the default is just sect2) -->
  <xsl:param name="toc.section.depth">3</xsl:param>

  <!-- Supress everything except a single top-level table of contents. -->
  <xsl:param name="generate.toc">
    set       toc,title
    book      toc,title,index
    article   title
    part      nop
    chapter   nop
    preface   nop
    qandadiv  nop
    qandaset  nop
    reference nop
    sect1     nop
    sect2     nop
    sect3     nop
    sect4     nop
    sect5     nop
    section   nop
    appendix  nop
  </xsl:param>
</xsl:stylesheet>  
