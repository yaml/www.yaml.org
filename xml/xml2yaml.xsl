<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
      description: >
        This simple stylesheet converts a very tiny subset of XML
        into YAML.  In short, sequences are represented as a series
        of "_" elements, mappings are represented via elements, and
        text nodes become scalar values.   For more information, 
        see http://yaml.org/xml/

      warning: This is experimental stuff and subject to change.
      source: http://yaml.org/xml/xml2yaml.xsl
      todo: 
      - improve scalar handling
      - handle _key and _value
      - better commenting
      - more efficient list of element generation
      - make a formal schema
      - get community buy-in
-->
<xsl:stylesheet xmlns:yaml="tag:yaml.org,2002" version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="tab" select="'   '" />
  <xsl:param name="nl"  select="'&#010;'" />
  <xsl:output method="text" encoding="UTF-8" media-type="text/yaml"/> 

  <xsl:variable name="seq">
     <!-- inefficiently generate a list of elements used as sequences -->
     <xsl:variable name="explicit-seq"
                   select="/*/@*[namespace-uri(.) = 'tag:yaml.org,2002' 
                                 and local-name(.) = 'seq' ]" />
     <xsl:text>|</xsl:text>
     <xsl:for-each select="//*[./*]/*[1]">
       <xsl:variable name="name" select="name()" />
       <xsl:if test="contains($explicit-seq, $name) or 
                     following-sibling::*[name() = $name and
                     not(namespace-uri(.) = 'tag:yaml.org,2002'
                         and (local-name(.) = '_key' or
                              local-name(.) = '_value'))]">
         <xsl:value-of select="$name" />
         <xsl:text>|</xsl:text>
       </xsl:if>
     </xsl:for-each>
  </xsl:variable>

  <xsl:template match="/*" name="root">
    <xsl:text># created by http://yaml.org/xml/xml2yaml.xsl</xsl:text>
    <xsl:value-of select="$nl" />
    <xsl:text>--- %YAML:1.0</xsl:text>
    <xsl:if test="namespace-uri(.) != 'tag:yaml.org,2002'" >
      <xsl:text> !!</xsl:text>
      <xsl:value-of select="name()" />
    </xsl:if>
    <xsl:call-template name="dispatch">
      <xsl:with-param name="indent" select="''" />
    </xsl:call-template>
    <xsl:value-of select="$nl" />
    <xsl:text>...</xsl:text>
    <xsl:value-of select="$nl" />
  </xsl:template>

  <xsl:template name="write-scalar" >
    <!-- emit an indented scalar value -->
    <xsl:param name="indent"/>
    <xsl:variable name="text" select="." />
    <xsl:variable name="quote">'</xsl:variable>
    <xsl:variable name="strip">
       <!-- whitespace and indicators -->
       <xsl:text>-:[]{}.?*!|>'"#%@`</xsl:text>
       <xsl:text>&#x20;&#x9;i&#xA;&#xD;&#85;&amp;</xsl:text>
    </xsl:variable>
    <xsl:choose>
      <!-- if the node is free of non-plain stuff, it is plain -->
      <xsl:when test="$text = translate($text,$strip,'')">
         <xsl:value-of select="$text" />
      </xsl:when>
      <xsl:when test="not (contains($text,$quote) or contains($text,$nl))" >
         <xsl:value-of select="concat($quote,$text,$quote)" />
      </xsl:when>
      <!-- else, it is literal -->
      <xsl:otherwise>
        <xsl:variable name="by" select="concat($nl,$indent)" />
        <xsl:value-of select="concat('|',$by)" />
        <xsl:call-template name="replace">
          <xsl:with-param name="text" select="$text" />
          <xsl:with-param name="target" select="$nl" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:otherwise>
      <!-- note: all YAML characters that require double quoting 
           not legal in XML, so this case need not be worried about -->
    </xsl:choose>
  </xsl:template>

  <xsl:template name="dispatch">
    <!-- the main node handler -->
    <xsl:param name="indent" select="$tab"/>
    <xsl:variable name="attribute" 
      select="@*[namespace-uri(.) != 'tag:yaml.org,2002']" />
    <!-- handle adornments -->
    <xsl:for-each select="@*[namespace-uri(.) = 'tag:yaml.org,2002']" >
      <xsl:choose>
        <xsl:when test="local-name() = 'anchor'">
          <xsl:value-of select="concat('&amp;',.,' ')" />
        </xsl:when>
        <xsl:when test="local-name() = 'alias'">
          <xsl:value-of select="concat('*',.,' ')" />
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <!-- take a peek to see if we have an element sequence -->
    <xsl:variable name="child" select="name(*[1])" />
    <xsl:variable name="isseq" 
                  select="$child and contains($seq,concat('|',$child,'|'))" />
    <xsl:choose>
      <!-- if we have attributes, make it a mapping -->
      <xsl:when test="$attribute">
        <xsl:for-each select="$attribute">
          <xsl:value-of select="concat($nl,$indent,name(),': ')" />
          <xsl:call-template name="write-scalar" >
            <xsl:with-param name="indent" select="concat($tab,$indent)" />
          </xsl:call-template>
        </xsl:for-each>
        <xsl:choose>
          <xsl:when test="$isseq">
            <xsl:value-of select="concat($nl,$indent,$child,': ')" />
            <xsl:call-template name="dispatch-content" >
              <xsl:with-param name="indent" select="concat($tab,$indent)" />
              <xsl:with-param name="seqnam" select="$child" />
            </xsl:call-template>
          </xsl:when>
          <!-- merge the sub-elements as a mapping -->
          <xsl:when test="*">
            <xsl:call-template name="dispatch-content" >
              <xsl:with-param name="indent" select="$indent" />
            </xsl:call-template>
          </xsl:when>
          <!-- indent scalar values -->
          <xsl:when test="text()">
            <xsl:value-of select="concat($nl,$indent,'=: ')" />
            <xsl:call-template name="dispatch-content" >
              <xsl:with-param name="indent" select="concat($tab,$indent)" />
            </xsl:call-template>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <!-- if we are an element sequence -->
      <xsl:when test="$isseq">
        <xsl:call-template name="dispatch-content" >
          <xsl:with-param name="indent" select="$indent" />
          <xsl:with-param name="seqnam" select="$child" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> 
        <xsl:call-template name="dispatch-content" >
          <xsl:with-param name="indent" select="$indent" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="dispatch-content">
    <xsl:param name="indent" select="$tab"/>
    <xsl:param name="seqnam"/>
    <xsl:choose>
      <!-- sequence using the yaml:_ node name -->
      <xsl:when test="yaml:_"> 
        <xsl:if test="*[namespace-uri(.) != 'tag:yaml.org,2002']">
          <xsl:message terminate="yes">
            <xsl:text>Element w/o 'tag:yaml.org,2002' namespace</xsl:text>
            <xsl:text> was found within a sequence.</xsl:text>
          </xsl:message>
        </xsl:if>
        <xsl:if test="*[local-name(.) != '_']">
          <xsl:message terminate="yes">
            <xsl:text>Element which is not an underscore found</xsl:text>
            <xsl:text> within a sequence.</xsl:text>
          </xsl:message>
        </xsl:if>
        <xsl:for-each select="*">
           <xsl:value-of select="concat($nl,$indent,'- ')" />
           <xsl:call-template name="dispatch" >
             <xsl:with-param name="indent" select="concat($tab,$indent)" />
           </xsl:call-template>   
        </xsl:for-each>
      </xsl:when>
      <!-- previously detected sequence -->
      <xsl:when test="$seqnam">
        <xsl:for-each select="*">
          <xsl:if test="name() != $seqnam">
            <xsl:message terminate="yes">
              <xsl:text>Expected a sequence to only contain '</xsl:text>
              <xsl:value-of select="$seqnam" />
              <xsl:text>' element names.</xsl:text>
            </xsl:message>
          </xsl:if>          
          <xsl:value-of select="concat($nl,$indent,'- ')" />
          <xsl:call-template name="dispatch" >
            <xsl:with-param name="indent" select="concat($tab,$indent)" />
          </xsl:call-template>   
        </xsl:for-each>
      </xsl:when>
      <!-- mapping -->
      <xsl:when test="*" >
        <xsl:for-each select="*">
          <xsl:variable name="name" select="name()" />
          <xsl:if test="following-sibling::*[name() = $name]">
           <xsl:message terminate="yes">
             <xsl:text>Duplicate element name '</xsl:text>
             <xsl:value-of select='$name' />
             <xsl:text>' found within a mapping.</xsl:text>
           </xsl:message>
          </xsl:if>
          <xsl:value-of select="concat($nl,$indent,name(),': ')" />
          <xsl:call-template name="dispatch" >
            <xsl:with-param name="indent" select="concat($tab,$indent)" />
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <!-- scalar -->
      <xsl:otherwise>
        <xsl:call-template name="write-scalar" >
          <xsl:with-param name="indent" select="$indent" />
        </xsl:call-template>
      </xsl:otherwise> 
    </xsl:choose>
  </xsl:template>

  <xsl:template name="replace">
    <!-- replaces all instances of `target` with `by` in `text` -->
    <xsl:param name="text" />
    <xsl:param name="target" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text,$target)">
        <xsl:value-of select="substring-before($text,$target)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="replace">
          <xsl:with-param name="text"
                          select="substring-after($text,$target)" />
          <xsl:with-param name="target" select="$target" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
