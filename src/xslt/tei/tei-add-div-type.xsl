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
  
  <xsl:param name="divs" required="yes" />
  
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:mode on-no-match="shallow-copy" name="sp"/>
  
  <xsl:variable name="div-heads" select="$divs/head"/>
  
  <xsl:template match="tei:div[tei:head = $div-heads]">
    <xsl:variable name="head" select="tei:head" />
    <xsl:variable name="div" select="$divs[. = $head]" />
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="$div/@*" />
      <xsl:choose>
        <xsl:when test="$div/sp[@who]">
          <xsl:copy-of select="$head" />
          <sp>
            <xsl:copy-of select="$div/sp/@*" />
            <xsl:apply-templates mode="sp" />
          </sp>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
      
    </xsl:copy>

    
  </xsl:template>
  
  <xsl:template match="tei:head" mode="sp" />
  
</xsl:stylesheet>