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
   <xd:p><xd:b>Created on:</xd:b> Jun 10, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output method="xml" indent="yes" />
 
 <xsl:template match="tei:body">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-adjacent="if(self::tei:div[tei:head/@type]) then self::tei:div/tei:head/@type else 0">
    <xsl:choose>
     <xsl:when test=".[self::tei:div[tei:head[@type]]]">
      <tei:div type="act" n="{current-grouping-key()}">
       <xsl:apply-templates select="current-group()" mode="scene" />
      </tei:div>
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:div[tei:head/@type]" mode="scene">
  <xsl:copy>
   <xsl:attribute name="type" select="'scene'" />
   <xsl:attribute name="n" select="tei:head/@subtype" />
   <xsl:apply-templates />
  </xsl:copy>
</xsl:template>
 
 <xsl:template match="tei:head">
  <xsl:copy>
   <xsl:copy-of select="@* except (@type, @subtype)" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>