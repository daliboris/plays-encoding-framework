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
   <xd:p><xd:b>Created on:</xd:b> 2026-08-22</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="group"/>
 <xsl:output indent="yes" />
 
 <xsl:template match="tei:div[not(@type)][not(@subtype)]" mode="group">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="preceding-sibling::*[1][self::tei:div[@type][not(@subtype)]]/@type" />
   <xsl:attribute name="subtype" select="'0'" />
   <xsl:apply-templates mode="#current" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:head[not(@type)]" mode="group">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="preceding::tei:div[@type][1]/@type" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:body[tei:div[@type][not(@subtype)][following-sibling::*[1][self::tei:div[not(@type)]]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-starting-with="tei:div[@type][not(@subtype)][following-sibling::*[1][self::tei:div[not(@type)]]]">
    <xsl:choose>
     <xsl:when test=".[self::tei:div[@type][not(@subtype)]]">
      <xsl:copy>
       <xsl:copy-of select="@*" />
       <xsl:apply-templates />
       <xsl:apply-templates select="current-group() except ." mode="group" />
      </xsl:copy>
     </xsl:when>
     <xsl:otherwise>
       <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>