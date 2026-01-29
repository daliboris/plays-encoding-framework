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
      <xd:p><xd:b>Created on:</xd:b> Jan 28, 2026</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="tei:div[@type='list-of-persons']">
    <castList><xsl:apply-templates /></castList>
  </xsl:template>
  
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p">
    <castItem><xsl:apply-templates /></castItem>
  </xsl:template>
  
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p/tei:persName">
    <role><xsl:apply-templates /></role>
  </xsl:template>
  
  <xsl:template match="tei:div[@type='list-of-persons']/tei:p/text()[normalize-space(.) != '']">
    <roleDesc><xsl:apply-templates /></roleDesc>
  </xsl:template>
  
</xsl:stylesheet>