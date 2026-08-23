<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-08-20</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <!--
  <replace from="per.angelus-tj-tnl" to="per.angelus_1-tj-tnl per.angelus_2-tj-tnl per.angelus_3-tj-tnl" />
 -->
 <xsl:param name="replace-ids" as="element(replace)*" required="yes" />
 <xsl:variable name="replacements" as="map(*)">
  <xsl:map>
   <xsl:for-each select="$replace-ids">
    <xsl:variable name="replace" select="."/>
    <xsl:variable name="key" select="'#' || string($replace/@from)"/>
    <xsl:variable name="items" select="for $item in tokenize($replace/@to) return '#' || $item"/>
    <xsl:variable name="values" select="string-join($items, ' ')"/>
    <xsl:map-entry key="$key" select="$values"/>
   </xsl:for-each>   
  </xsl:map>
 </xsl:variable>
 
 <xsl:variable name="ids" select="map:keys($replacements)"/>
 
 <xsl:template match="@*[.= $ids]">
  <xsl:variable name="key" select="string(.)"/>
  <xsl:attribute name="{name()}" select="map:get($replacements, $key)" />
 </xsl:template>
 
 
</xsl:stylesheet>