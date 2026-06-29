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
   <xd:p><xd:b>Created on:</xd:b> 2026-06-28</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="speaker-name-regex" select="'\p{Lu}[\p{Ll}\[\]]+((\.|\s+\d|\p{Lu}[\p{Ll}\[\]]+))?:'"/>
 <xsl:variable name="speaker-regex" select="'^' || $speaker-name-regex || '$'"/>
 <xsl:variable name="speaker-supplied-regex" select="'^\[' || $speaker-name-regex || '?\]:?$'"/>
 
 <xsl:template match="tei:l[tei:space[1][following-sibling::text()[1][matches(., $speaker-regex)]]]">
  <tei:speaker>
   <xsl:copy-of select="tei:space[1]" />
   <xsl:copy-of select="tei:space[1]/following-sibling::text()[1]" />
  </tei:speaker>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l/text()[matches(., $speaker-regex)][preceding-sibling::*[1][self::tei:space]]">
  
 </xsl:template>
 
 
</xsl:stylesheet>