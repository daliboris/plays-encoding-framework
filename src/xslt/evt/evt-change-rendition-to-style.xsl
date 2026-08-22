<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="#all"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jul 13, 2026</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:hi[@rendition]">
  <xsl:variable name="style" as="xs:string">
   <xsl:choose>
    <xsl:when test="@rendition = 'italic'">font-style: italic;</xsl:when>
    <xsl:when test="@rendition = 'italic strike'">font-style: italic; text-decoration: line-through;</xsl:when>
    <xsl:when test="@rendition = 'bold'">font-weight: bold;</xsl:when>
    <xsl:when test="@rendition = 'bold italic'">font-weight: bold; font-style: italic;</xsl:when>
    <xsl:when test="@rendition = 'normal'">font-weight: normal; font-style: normal;</xsl:when>
   </xsl:choose>    
  </xsl:variable>
  <xsl:variable name="attribute" as="attribute()">
   <xsl:choose>
    <xsl:when test="$style = ''">
     <xsl:copy-of select="@rendition" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:attribute name="style" select="$style" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  
  <xsl:copy>
   <xsl:copy-of select="@* except @rendition" />
   <xsl:copy-of select="$attribute" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>