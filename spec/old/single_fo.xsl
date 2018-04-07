<?xml version="1.0"?> 

<!--
 - Customize the generation of FO from the DocBook sources for the YAML spec.
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.0"> 

  <!-- Invoke the DocBook -> HTML conversion stylesheet -->
  <xsl:import href="file:///usr/local/share/xsl/docbook/fo/docbook.xsl" /> 

  <!-- Force index to be in two columns -->
  <xsl:param name="column.count.index" select="2" />

  <!-- Output control. No need to worry about document type. -->
  <xsl:output method="xml" encoding="ISO-8859-1" indent="yes" />

  <!-- Border for examples -->
  <xsl:template match="database"
    ><fo:block
        border-style="solid" border-color="black" border-width="thin"
        ><xsl:apply-templates mode="highlight" select='*|text()'
    /></fo:block
  ></xsl:template>

  <!-- Convert HL -->
  <xsl:template match="HL"
    ><xsl:apply-templates mode="highlight" select='*|text()'
  /></xsl:template>

  <!-- Convert normal hl1 -->
  <xsl:template match="hl1"
    ><fo:inline
      border-style="solid" border-color="black" border-width="thin"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

  <!-- Convert HL/hl1 -->
  <xsl:template mode="highlight" match="hl1"
    ><fo:inline
      line-height="150%" padding="4px"
      border-style="solid" border-color="black" border-width="thin"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

  <!-- Convert normal hl2 -->
  <xsl:template match="hl2"
    ><fo:inline
      border-style="dotted" border-color="black" border-width="thin"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

  <!-- Convert HL/hl2 -->
  <xsl:template mode="highlight" match="hl2"
    ><fo:inline
      line-height="150%" padding="4px"
      border-style="dotted" border-color="black" border-width="thin"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

  <!-- Convert normal hl3 -->
  <xsl:template match="hl3"
    ><fo:inline
      border-style="dashed" border-color="black" border-width="thin"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

  <!-- Convert HL/hl3 -->
  <xsl:template mode="highlight" match="hl3"
    ><fo:inline
      line-height="150%" padding="4px"
      border-style="dashed" border-color="black" border-width="thin"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

  <!-- Convert normal hl4 -->
  <xsl:template match="hl4"
    ><fo:inline
      border-style="dotted" border-color="black" border-width="0.499pt"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

  <!-- Convert HL/hl4 -->
  <xsl:template mode="highlight" match="hl4"
    ><fo:inline
      line-height="150%" padding="4px"
      border-style="dotted" border-color="black" border-width="0.499pt"
      ><xsl:apply-templates select='*|text()'
    /></fo:inline
  ></xsl:template>

</xsl:stylesheet>  
