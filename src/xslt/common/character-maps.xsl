<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 5, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:character-map name="whitespaces">
  <xsl:output-character character="&#xa0;" string=" "/>
 </xsl:character-map>
 
 <xsl:character-map name="normalization" use-character-maps="whitespaces" />
 
 <xsl:output use-character-maps="normalization"/>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
</xsl:stylesheet>