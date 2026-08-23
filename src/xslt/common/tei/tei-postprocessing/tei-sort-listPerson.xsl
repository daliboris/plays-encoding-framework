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
   <xd:p><xd:b>Created on:</xd:b> 2026-07-29</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="yes" />
 
 
 
 <xsl:template match="tei:listPerson">
  <xsl:variable name="lang" select="ancestor-or-self::*/@xml:lang[1]"/>
  
  <xsl:variable name="sorting-collation" select="'http://saxon.sf.net/collation?lang=' || $lang || ';ignore-modifiers=yes'"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="tei:head" />
   <xsl:apply-templates select="* except tei:head">
    <xsl:sort select="(tei:persName | tei:name)[1]" collation="{$sorting-collation}" />
   </xsl:apply-templates>
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>