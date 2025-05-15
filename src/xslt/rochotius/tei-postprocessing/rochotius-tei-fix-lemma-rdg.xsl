<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 4, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="editor-id" select="'mj'" />
 <xsl:variable name="all-withnesses" select="//tei:listWit/tei:witness/@xml:id"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:app/tei:lem[not(@wit)]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="resp" select="$editor-id" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:app/tei:rdg">
  <xsl:variable name="witnesses" select="parent::tei:app/*/tokenize(translate(@wit, '#', ''))"/>
  <xsl:variable name="new" select="$all-withnesses[not(. = $witnesses)]"/>
  <xsl:choose>
   <xsl:when test="empty($new)">
    <xsl:copy-of select="." />
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy>
     <xsl:copy-of select="@* except @wit" />
     <xsl:attribute name="wit" select="string-join((@wit, $new), ' #')" />
     <xsl:apply-templates />
    </xsl:copy>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
</xsl:stylesheet>