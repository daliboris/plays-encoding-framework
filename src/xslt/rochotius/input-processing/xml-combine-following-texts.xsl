<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="#all"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-30</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="text[tab and footnote-reference][following-sibling::*[1][self::text[tab]]]" priority="2">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:copy-of select="following-sibling::*[1][self::text[tab]]/node()" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[tab][preceding-sibling::*[1][self::text[tab and footnote-reference]]]"  priority="2" />
 
 <xsl:template match="text[not(@* except @xml:space)]
  [not(preceding-sibling::*[1][self::text[not(@* except @xml:space)]])]
  [following-sibling::*[1][self::text[not(@* except @xml:space)]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:apply-templates select="following-sibling::*[1][self::text[not(@* except @xml:space)]]" mode="next-text" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[not(@* except @xml:space)]
  [preceding-sibling::*[1][self::text[not(@* except @xml:space)]]]
  " />
 
 <xsl:template match="text[not(@* except @xml:space)]
  [preceding-sibling::*[1][self::text[not(@* except @xml:space)]]]"
  mode="next-text">
  <xsl:apply-templates />
  <xsl:apply-templates select="following-sibling::*[1][self::text[not(@* except @xml:space)]]" mode="#current" />
 </xsl:template>
 
 
</xsl:stylesheet>