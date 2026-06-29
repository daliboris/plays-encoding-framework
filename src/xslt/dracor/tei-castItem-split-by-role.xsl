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
      <xd:p><xd:b>Created on:</xd:b> Jan 31, 2026</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:strip-space elements="*"/>
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:output indent="yes" />
  
  <xsl:template match="tei:castItem">
    <xsl:variable name="root" select="."/>
    <xsl:for-each-group select="*" group-starting-with="tei:role">
      <castItem>
        <xsl:copy-of select="$root/@*" />
        <xsl:copy-of select="." />
        <xsl:if test="current-group()[self::tei:roleDesc]">
          <xsl:variable name="text" select="string-join(current-group()[self::tei:roleDesc] except ., ' ') => normalize-space()"/>
          <xsl:choose>
            <xsl:when test="matches($text, '^\p{P}$')">
              <pc>
                <xsl:value-of select="$text"/>
              </pc>              
            </xsl:when>
            <xsl:otherwise>
              <roleDesc>
                <xsl:value-of select="$text"/>
              </roleDesc>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </castItem>
    </xsl:for-each-group>
  </xsl:template>
  
</xsl:stylesheet>