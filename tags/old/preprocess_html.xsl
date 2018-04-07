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
  <xsl:template match="firstterm">
    <indexterm>
      <primary>
        <xsl:copy>
          <xsl:apply-templates select='node()|@*'/>
        </xsl:copy>
      </primary>
    </indexterm>
    <xsl:copy>
      <xsl:apply-templates select='node()|@*'/>
    </xsl:copy>
  </xsl:template>

  <!-- Convert screen -->
  <xsl:template match="screen">
    <screen><database><xsl:apply-templates
                        select='*|text()'/></database></screen>
  </xsl:template>

  <!-- Convert programlisting -->
  <xsl:template match="programlisting">
    <programlisting><database><xsl:apply-templates
                                select='*|text()'/></database></programlisting>
  </xsl:template>

  <!-- Convert hl1 -->
  <xsl:template match="hl1">
    <filename>
      <xsl:apply-templates select='*|text()'/>
    </filename>
  </xsl:template>

  <!-- Convert hl2 -->
  <xsl:template match="hl2">
    <literal>
      <xsl:apply-templates select='*|text()'/>
    </literal>
  </xsl:template>

  <!-- Convert hl3 -->
  <xsl:template match="hl3">
    <property>
      <xsl:apply-templates select='*|text()'/>
    </property>
  </xsl:template>

  <!-- Convert hl4 -->
  <xsl:template match="hl4">
    <constant>
      <xsl:apply-templates select='*|text()'/>
    </constant>
  </xsl:template>

  <!-- Convert HL -->
  <xsl:template match="HL">
    <honorific>
      <xsl:apply-templates select='*|text()'/>
    </honorific>
  </xsl:template>

  <!-- Copy everything else unchanged. -->
  <xsl:template match='*|@*'>
    <xsl:copy>
      <xsl:apply-templates select='node()|@*'/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>  
