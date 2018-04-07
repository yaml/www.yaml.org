<?xml version="1.0"?> 

<!--
 - Pre-process the spec before handing it over to standard DocBook. This allows
 - using convenient shorthands that DocBook does not provide. Currently these
 - shorthands are:
 -
 - <firstterm>term</firstterm> is converted to an <indexterm>, using "term" as
 - the primary. This is used to create a short index of "important terms" as an
 - appendix.
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"> 

  <!-- Generate the DOCBOOk DTD decleration. Can't copy it! -->
  <xsl:output
    method="xml" doctype-public="-//OASIS//DTD DocBook V4.2//EN"
    doctype-system="file:///usr/local/share/xml/docbook/4.2/docbookx.dtd" />

  <!-- Convert firstterm to index entry definition. -->
  <xsl:template match="firstterm"
    ><indexterm
      ><primary
        ><xsl:copy
          ><xsl:apply-templates select='node()|@*'
        /></xsl:copy
      ></primary
    ></indexterm
    ><xsl:copy
      ><xsl:apply-templates select='node()|@*'
    /></xsl:copy
  ></xsl:template>

  <!-- Convert screen -->
  <xsl:template match="screen"
    ><screen
      ><database
        ><xsl:apply-templates select='*|text()'
      /></database
    ></screen
  ></xsl:template>

  <!-- Convert programlisting -->
  <xsl:template match="programlisting"
    ><programlisting
      ><database
        ><xsl:apply-templates select='*|text()'
      /></database
    ></programlisting
  ></xsl:template>

  <!-- Copy everything else unchanged. -->
  <xsl:template match='*|@*'
    ><xsl:copy
      ><xsl:apply-templates select='node()|@*'
    /></xsl:copy
  ></xsl:template>

</xsl:stylesheet>  
