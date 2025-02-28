<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 exclude-result-prefixes="xs math xd tei"
 version="3.0"
 xmlns:oxy="http://www.oxygenxml.com/oxy">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jan 28, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:character-map name="space">
  <xsl:output-character character="&#xa0;" string=" "/>
 </xsl:character-map>
 
 <xsl:output method="xml" indent="yes" use-character-maps="space" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:function name="oxy:get-text-language">
  <xsl:param name="p" as="xs:integer"/>
  <xsl:choose>
   <xsl:when test="$p = 1">la</xsl:when>
   <xsl:when test="$p = 2">la</xsl:when>
   <xsl:when test="$p = 3">cs</xsl:when>
   <xsl:when test="$p = 4">cs</xsl:when>
   <xsl:when test="$p = 5">la</xsl:when>
   <xsl:when test="$p = 6">cs</xsl:when>
   <xsl:when test="$p = 7">cs</xsl:when>
   <xsl:when test="$p = 8">la</xsl:when>
   <xsl:when test="$p = 9">la</xsl:when>
   <xsl:when test="$p = 10">cs</xsl:when>
   <xsl:when test="$p = 11">cs</xsl:when>
  </xsl:choose>
 </xsl:function>
 
 <xsl:function name="oxy:get-text-name">
  <xsl:param name="p" as="xs:integer"/>
  <xsl:choose>
   <xsl:when test="$p = 1">Synopse</xsl:when>
   <xsl:when test="$p = 2">Text edice</xsl:when>
   <xsl:when test="$p = 3">Překlad</xsl:when>
   <xsl:when test="$p = 4">Ediční komentář</xsl:when>
   <xsl:when test="$p = 5">Text edice</xsl:when>
   <xsl:when test="$p = 6">Překlad</xsl:when>
   <xsl:when test="$p = 7">Ediční komentář</xsl:when>
   <xsl:when test="$p = 8">Synopse</xsl:when>
   <xsl:when test="$p = 9">Text edice</xsl:when>
   <xsl:when test="$p = 10">Překlad</xsl:when>
   <xsl:when test="$p = 11">Ediční komentář</xsl:when>
  </xsl:choose>
 </xsl:function>
 
 <xsl:function name="oxy:get-text-id">
  <xsl:param name="p" as="xs:integer"/>
  
  <xsl:value-of select="concat('angelus.', oxy:get-text-name($p)) => replace('edice', '') => normalize-space() => translate('ř', 'r') => lower-case()"/>
 </xsl:function>
 
 
 <xsl:template match="tei:TEI">
  <xsl:variable name="p" select="count(preceding::tei:TEI) + 1"/>
  <xsl:variable name="lang" select="oxy:get-text-language($p)"/>
  <xsl:variable name="text-id" select="oxy:get-text-id($p)"/>
  
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="lang" namespace="http://www.w3.org/XML/1998/namespace">
    <xsl:copy-of select="oxy:get-text-language($p)"/>
   </xsl:attribute>
   <xsl:attribute name="id" namespace="http://www.w3.org/XML/1998/namespace">
    <xsl:copy-of select="concat($text-id, '.', $lang)"/>
   </xsl:attribute>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:TEI/tei:text">
  <xsl:variable name="p" select="count(preceding::tei:TEI) + 1"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="id" namespace="http://www.w3.org/XML/1998/namespace">
    <xsl:copy-of select="oxy:get-text-id($p)"/>
   </xsl:attribute>
   <xsl:attribute name="n">
    <xsl:copy-of select="oxy:get-text-name($p)"/>
   </xsl:attribute>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>