<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 5, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="text" indent="no" />
 
 <xsl:mode on-no-match="shallow-skip"/>
 
 <xsl:template match="w:p[w:r]">
  <xsl:apply-templates />
  <xsl:value-of select="'&#xa;'" />
 </xsl:template>
 
 <xsl:template match="w:r/w:t">
  <xsl:value-of select="." />
 </xsl:template>
 <xsl:template match="w:r/w:tab">
  <xsl:value-of select="'&#x9;'"/>
 </xsl:template>
 
 
</xsl:stylesheet>