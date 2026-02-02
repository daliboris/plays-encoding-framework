<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="xs math xd"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Jan 29, 2026</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:strip-space elements="*"/>
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:output indent="yes" />
  
  <xsl:template match="tei:l[preceding-sibling::tei:l][*[1][self::tei:pb]]">
    <xsl:copy-of select="*[1][self::tei:pb]" />
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:l[preceding-sibling::tei:l]/*[1][self::tei:pb]" />
  
  <xsl:template match="tei:div[*[1][self::tei:opener][*[1][self::tei:salute][*[1][self::tei:pb]]]]">
    <xsl:copy-of select="*[1][self::tei:opener]/*[1][self::tei:salute]/*[1][self::tei:pb]" />
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:div/*[1][self::tei:opener]/*[1][self::tei:salute]/*[1][self::tei:pb]" />
  
  <xsl:template match="tei:div[*[1][self::tei:head][*[1][self::tei:pb]]]">
    <xsl:copy-of select="*[1][self::tei:head]/*[1][self::tei:pb]" />
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:div/*[1][self::tei:head]/*[1][self::tei:pb]" />

  <xsl:template match="tei:div[*[1][self::tei:l][*[1][self::tei:pb]]]" priority="2">
    <xsl:copy-of select="*[1][self::tei:l]/*[1][self::tei:pb]" />
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:div/*[1][self::tei:l]/*[1][self::tei:pb]" priority="2" />
  
  <xsl:template match="tei:div[*[1][self::tei:p][*[1][self::tei:pb]]]">
    <xsl:copy-of select="*[1][self::tei:p]/*[1][self::tei:pb]" />
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:div/*[1][self::tei:p]/*[1][self::tei:pb]" />
  
  <!--
    <sp who="#gedeon">
     <speaker><pb n="D3r" />Gedeon</speaker>
    </sp>
  -->
  <xsl:template match="tei:sp[*[1][self::tei:speaker][*[1][self::tei:pb]]]">
    <xsl:copy-of select="*[1][self::tei:speaker]/*[1][self::tei:pb]" />
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:sp/*[1][self::tei:speaker]/*[1][self::tei:pb]" />
  
</xsl:stylesheet>