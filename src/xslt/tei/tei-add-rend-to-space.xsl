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
      <xd:p><xd:b>Created on:</xd:b> Oct 23, 2023</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:output method="xml" indent="yes" />
  <xsl:mode on-no-match="shallow-copy" />
  
  <xsl:template match="tei:l[tei:space]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="rend">
        <xsl:value-of select="if(tei:space/@quantity = 1) then 'indent' else concat('indent', tei:space/@quantity)"/>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:l/tei:space" />
  
  <xsl:template match="tei:note/tei:space">
    <xsl:text> </xsl:text>
  </xsl:template>
</xsl:stylesheet>