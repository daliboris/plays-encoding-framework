<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-02</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="fixes" as="element(fix)*" required="yes" />
 <xsl:param name="match" as="xs:string?" select="()" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="fix-map" select="map:merge(for $fix in $fixes return map {$fix/from/string() : $fix/to/string()})" as="map(*)"/>
 <xsl:variable name="find" select="map:keys($fix-map)"/>

 <xsl:template match="text()[. = $find]">
  <xsl:variable name="ancestors" select="string-join(parent::*/ancestor-or-self::*/local-name(), '/')"/>
  <xsl:variable name="key" select="string(.)"/>
  
  <xsl:choose>
   <xsl:when test="empty($ancestors)">
    <xsl:value-of select="$fix-map($key)"/>  
   </xsl:when>
   <xsl:when test="ends-with($ancestors, $match)">
    <xsl:value-of select="$fix-map($key)"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
  
    
 </xsl:template>
 
</xsl:stylesheet>