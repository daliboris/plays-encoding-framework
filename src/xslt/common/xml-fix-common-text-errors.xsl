<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 xmlns:xf="https://www.daliboris.cz/ns/xslt/functions"
 exclude-result-prefixes="xs math xd map"
 version="3.0">
 
 <xsl:import href="_common-text-errors.xsl"/>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="yes" method="xml" />
 
 <xsl:template match="text()[matches(., $replacement-regex)]">
  <xsl:value-of select="xf:replace-items(., $replacements)"/>
 </xsl:template>
 
 
 <xsl:function name="xf:replace-items">
  <xsl:param name="text" as="xs:string"/>
  <xsl:param name="replacements" as="map(xs:string, xs:string)"/>
  <xsl:value-of select="fold-left(map:keys($replacements), $text, function($text, $next) {
   replace($text, $next, $replacements($next))
   })"/>
 </xsl:function>
</xsl:stylesheet>