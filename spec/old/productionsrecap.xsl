<?xml version="1.0"?> 

<!--
 - Generate a list of productionrecap elements, one per production, for
 - use in generating the productions refernce appendix.
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"> 

  <!-- Copy everything else unchanged. -->
  <xsl:template match='production'>
    <productionrecap linkend="{./@id}" />
  </xsl:template>

  <!-- Process everything else, but do not copy . -->
  <xsl:template match='*|@*|text()'>
    <xsl:apply-templates select='node()|@*|text()'/>
  </xsl:template>

</xsl:stylesheet>  
