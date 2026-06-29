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
      <xd:p><xd:b>Created on:</xd:b> Jan 29, 2026</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*"/>
  <xsl:mode on-no-match="shallow-copy" />
  
  <xsl:template match="tei:div/tei:argument">
    <stage><xsl:apply-templates /></stage>
  </xsl:template>
  
  <xsl:template match="tei:div/tei:argument/tei:p">
    <xsl:apply-templates />
  </xsl:template>
  
</xsl:stylesheet>