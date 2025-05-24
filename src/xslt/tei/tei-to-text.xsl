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
   <xd:p><xd:b>Created on:</xd:b> May 5, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:variable name="new-line" select="'&#xa;'"/>
 <xsl:strip-space elements="*"/>
 <xsl:output method="text" indent="yes" />
 
 <xsl:mode on-no-match="shallow-skip"/>
 
 <xsl:template match="/">
  <xsl:apply-templates select="//tei:text" />
 </xsl:template>

 
 <xsl:template match="tei:div | tei:l | tei:p | tei:head | tei:speaker | tei:stage | tei:castItem | tei:titlePart | tei:docImprint">
  <xsl:apply-templates />
  <xsl:value-of select="$new-line"/>
 </xsl:template>
 
 <xsl:template match="tei:l/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:p/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:head/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:hi/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:lem/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:stage/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:castItem/*/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:speaker/tei:persName/text()"><xsl:value-of select="."/><xsl:text>:</xsl:text></xsl:template>
 <xsl:template match="tei:speaker[not(tei:persName)]/text()"><xsl:value-of select="."/><xsl:text></xsl:text></xsl:template>
 <xsl:template match="tei:p/tei:persName/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:foreign/text()"><xsl:value-of select="."/></xsl:template>
 
 <xsl:template match="tei:titlePart/text()"><xsl:value-of select="."/></xsl:template>
 <xsl:template match="tei:docImprint/text()"><xsl:value-of select="."/></xsl:template>
 
 <xsl:template match="tei:pb">
  <xsl:choose>
   <xsl:when test="empty(following-sibling::text()[1][normalize-space() != ''])">
    <xsl:text>[</xsl:text><xsl:value-of select="@n"/><xsl:text>]</xsl:text>  
   </xsl:when>
   <xsl:otherwise>
    <xsl:text>[</xsl:text><xsl:value-of select="@n"/><xsl:text>] </xsl:text>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="tei:space[@unit='tab']">
  <xsl:value-of select="'&#x9;'"/>
 </xsl:template>

 <xsl:template match="tei:rgd" />
 <xsl:template match="tei:note" />
</xsl:stylesheet>