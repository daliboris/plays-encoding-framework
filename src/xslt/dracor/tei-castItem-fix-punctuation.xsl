<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Feb 1, 2026</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:param name="punctuation-regex">^(\p{P}\s?)(.*)$</xsl:param>
  
  <xsl:strip-space elements="*"/>
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:output indent="yes" />
  
  <xsl:template match="tei:castItem/tei:role[following-sibling::*[1][self::tei:roleDesc[matches(., $punctuation-regex)]]]">
    <xsl:variable name="role-desc-analysis" select="following-sibling::*[1][self::tei:roleDesc]/analyze-string(., $punctuation-regex)"/>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:value-of select="$role-desc-analysis/fn:match[1]/fn:group[1] ! normalize-space(.)"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:roleDesc[matches(., $punctuation-regex)]">
    <xsl:variable name="role-desc-analysis" select="analyze-string(., $punctuation-regex)"/>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:value-of select="$role-desc-analysis/fn:match[1]/fn:group[2] ! normalize-space(.)"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>