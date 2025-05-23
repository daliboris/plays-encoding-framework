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
   <xd:p><xd:b>Created on:</xd:b> May 16, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:strip-space elements="*"/>
 <xsl:output method="xml" indent="yes" />
 
 <xsl:template match="tei:l[count(*) eq 1][tei:speaker]">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="tei:l[count(*) eq 2][tei:speaker and tei:space]">
  <xsl:apply-templates  select="tei:speaker"/>
 </xsl:template>
 
 <xsl:template match="tei:p[count(*) eq 1][tei:speaker]">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="tei:p[count(*) eq 2][tei:speaker and tei:space]">
  <xsl:apply-templates select="tei:speaker"/>
 </xsl:template>
 
</xsl:stylesheet>