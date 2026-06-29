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
  
  <xsl:param name="finis-text" as="xs:string*" select="('FINIS.')" />
  <xsl:output indent="yes" />
  <xsl:strip-space elements="*"/>
  <xsl:mode on-no-match="shallow-copy" />
  <xsl:mode name="closer" on-no-match="shallow-copy" />
  <xsl:mode name="stage" on-no-match="shallow-copy" />
  
  <xsl:template match="tei:body/tei:div/tei:div[last()][../following-sibling::*[1][self::tei:div[tei:head = $finis-text]]]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
      <xsl:apply-templates select="../following-sibling::*[1][self::tei:div[tei:head = $finis-text]]" mode="stage" />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:body/tei:div[tei:head = $finis-text]" />
  
  <xsl:template match="tei:body/tei:div[tei:head = $finis-text]" mode="stage">
    <stage><xsl:apply-templates mode="#current" /></stage>
  </xsl:template>
  
  <xsl:template match="tei:body/tei:div[preceding-sibling::tei:div[tei:head = $finis-text]]">
    <closer><xsl:apply-templates  mode="closer"/></closer>
  </xsl:template>
  
  <xsl:template match="tei:head" mode="closer stage">
    <xsl:apply-templates />
  </xsl:template>
  
</xsl:stylesheet>