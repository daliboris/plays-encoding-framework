<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
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
 
 <xsl:template match="Normální [preceding-sibling::*[1][self::Normální[ends-with(normalize-space(.), ':')][./*[last()][self::comment-range[@type='start']]]]]/text">
  <xsl:variable name="comment-range" select="../preceding-sibling::*[1][self::Normální[ends-with(normalize-space(.), ':')]/*[last()]/self::comment-range[@type='start']]/*[last()]"/>
   <xsl:for-each-group select="*" group-adjacent="if(self::tab) then 0 else position()">
    <xsl:choose>
     <xsl:when test="current-grouping-key() = 0">
      <text>
       <xsl:copy-of select="current-group()" />
      </text>
      <xsl:copy-of select="$comment-range" />
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy>
       <text/>
       <xsl:copy-of select="current-group()" />
      </xsl:copy>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
   <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="Normální[ends-with(normalize-space(.), ':')]/*[last()][self::comment-range[@type='start']]" />
 
 
</xsl:stylesheet>