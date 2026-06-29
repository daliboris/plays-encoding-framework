<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
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
  <xsl:import href="../common/_tei-common-functions.xsl"/>
  
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="tei:div/@n[matches(upper-case(.), $latin-number-regex)]">
    <xsl:attribute name="{name()}">
      <xsl:value-of select="tnf:roman-to-arabic(.)"/>
    </xsl:attribute>
  </xsl:template>
</xsl:stylesheet>