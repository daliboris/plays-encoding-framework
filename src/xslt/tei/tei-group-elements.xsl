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
   <xd:p><xd:b>Created on:</xd:b> Sep 22, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Zpracování úvodního textu, seskupení pasáží v případě, že sekce neobsahuje veršovaný text.</xd:p>
   <xd:p>Jde o "informační leták" o hře.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:body[tei:titlePart][not(tei:l)]">
  <xsl:copy>
   <xsl:for-each-group select="*" group-adjacent="
   if(self::tei:p[tei:pb][following-sibling::*[1][self::tei:titlePart]]) then -5
   else if(self::tei:titlePart) then -5 
   else if(self::tei:performance) then -4 
   else if(self::tei:head[following-sibling::*[1][self::tei:p]]) then -3
   else if(self::tei:p[preceding-sibling::*[1][self::tei:head]]) then -3
   else if(self::tei:p[tei:pb][following-sibling::*[1][self::tei:head]]) then -3
   else
   position()">
   <xsl:choose>
    <xsl:when test="current-grouping-key() = -5">
     <tei:docTitle>
      <xsl:copy-of select="current-group()" />
     </tei:docTitle>
    </xsl:when>
    <xsl:when test="current-grouping-key() = -4">
     <tei:performance>
      <xsl:apply-templates select="current-group()/*" />
     </tei:performance>
    </xsl:when>
    <xsl:when test="current-grouping-key() = -3">
     <tei:div type="contents">
      <xsl:apply-templates select="current-group()" />
     </tei:div>
    </xsl:when>
    <xsl:otherwise>
     <xsl:copy-of select="current-group()" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Oddíl, který obsahuje divadelní hru. Ta sestává z názvu, informace o představení a veršovaného textu.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:body[tei:titlePart][tei:l]">
  <xsl:copy>
   <xsl:for-each-group select="*" group-adjacent="
    if(self::tei:p[tei:pb][following-sibling::*[1][self::tei:titlePart]]) then -5
    else if(self::tei:titlePart) then -5 
    
    else if(self::tei:performance) then -4
    
    else -3">
    <xsl:choose>
     <xsl:when test="current-grouping-key() = -5">
      <tei:docTitle>
       <xsl:copy-of select="current-group()" />
      </tei:docTitle>
     </xsl:when>
     <xsl:when test="current-grouping-key() = -4">
      <tei:performance>
       <xsl:apply-templates select="current-group()/*" />
      </tei:performance>
     </xsl:when>
     <xsl:when test="current-grouping-key() = -3">
      <tei:div type="body">
       <xsl:apply-templates select="current-group()" />
      </tei:div>
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>