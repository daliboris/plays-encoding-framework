<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 19, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:l[1][not(preceding-sibling::*[1][self::tei:speaker])]">
  <xsl:call-template name="insert-speaker-uknown"/>
  <xsl:copy-of select="." />
 </xsl:template>
 
 
 <xsl:template match="tei:div/tei:p[1][not(preceding-sibling::*[1][self::tei:speaker])]">
  <xsl:call-template name="insert-speaker-uknown"/>
  <xsl:copy-of select="." />
 </xsl:template>
 
 <xsl:template match="tei:stage[preceding-sibling::*[1][self::tei:l[node()]]][following-sibling::*[1][self::tei:l[node()]]]">
  <xsl:copy-of select="." />
  <xsl:call-template name="insert-speaker-uknown"/>
 </xsl:template>

 <xsl:template match="tei:stage[preceding-sibling::*[1][self::tei:p[node()]]][following-sibling::*[1][self::tei:p[node()]]]">
  <xsl:copy-of select="." />
  <xsl:call-template name="insert-speaker-uknown"/>
 </xsl:template>
 

 <xsl:template name="insert-speaker-uknown">
  <speaker resp="#pef-dracor">Unknown</speaker>
 </xsl:template>
 

</xsl:stylesheet>