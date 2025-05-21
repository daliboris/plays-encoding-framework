<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
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
 
 <xsl:template match="tei:l[not(*)]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:value-of select="normalize-space()"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:castItem/tei:role" priority="2">
  <xsl:copy-of select="." />
 </xsl:template>
 
 <xsl:template match="text()[last()][normalize-space() != ''][ends-with(., ' ')]">
  <xsl:value-of select="replace(., '\s$', '')"/>
 </xsl:template>
 
</xsl:stylesheet>