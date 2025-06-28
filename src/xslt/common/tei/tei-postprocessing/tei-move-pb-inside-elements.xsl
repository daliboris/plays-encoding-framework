<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2025-06-27</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:*[tei:pb][count(text()[normalize-space() != '' ]) eq 0]" />
  
 <xsl:template match="tei:*[preceding-sibling::*[1][self::tei:*[tei:pb][count(text()[normalize-space() != '' ]) eq 0]]]">
  <xsl:variable name="pb" select="preceding-sibling::*[1]/*[self::tei:pb]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="$pb"/>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:div[preceding::*[1][parent::*[self:: tei:*[tei:pb][count(text()[normalize-space() != '' ]) eq 0]]]]/*[1]">
  <xsl:variable name="pb" select="preceding::*[1][self::tei:pb]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="$pb" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:sp[preceding::*[1][parent::*[self:: tei:*[tei:pb][count(text()[normalize-space() != '' ]) eq 0]]]]" priority="2">
  <xsl:variable name="pb" select="preceding::*[1][self::tei:pb]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="$pb" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>