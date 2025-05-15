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
   <xd:p><xd:b>Created on:</xd:b> Jun 11, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output method="xml" indent="yes" />
 
 
 <xsl:template match="tei:front/tei:div[tei:l][1]/tei:l" priority="2">
  <xsl:variable name="position" select="position()"/>
  <xsl:copy>
   <xsl:copy-of select="@* except @rend" />
   <xsl:if test="$position mod 2 = 0">
    <xsl:attribute name="rend" select="'indent'" />
   </xsl:if>
   <xsl:apply-templates select="node() except tei:space" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l/tei:space">
  <xsl:if test="count(preceding-sibling::tei:space) ge 1">
   <xsl:copy-of select="." />
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="tei:l[@rend][tei:space]">
  <xsl:variable name="tabs" select="count(tei:space) - 3"/>
  <xsl:copy>
   <xsl:copy-of select="@* except @rend" />
   <xsl:if test="$tabs gt 0">
    <xsl:attribute name="rend" select="if($tabs = 1) then 'indent' else 'indent' || $tabs" />
   </xsl:if>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:speaker/tei:space" />
 
 
</xsl:stylesheet>