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
   <xd:p><xd:b>Created on:</xd:b> 2026-07-11</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:closer">
  <div>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="type" select="local-name()" />
   <xsl:choose>
    <xsl:when test="not(*)">
     <head><xsl:apply-templates /></head>
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates />
    </xsl:otherwise>
   </xsl:choose>
  </div>
 </xsl:template>
 
 <xsl:template match="tei:*[tei:lb]" priority="2">
  <div>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="type" select="local-name()" />
   <xsl:for-each-group select="node()" group-starting-with="tei:lb">
    <xsl:if test="normalize-space(string-join(current-group())) != ''">
     <p><xsl:copy-of select="current-group() except ." /></p> 
    </xsl:if>
   </xsl:for-each-group>
  </div>
 </xsl:template>
 
 
</xsl:stylesheet>