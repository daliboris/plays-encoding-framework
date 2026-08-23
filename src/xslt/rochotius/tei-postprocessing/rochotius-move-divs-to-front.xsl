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
 
 <xsl:param name="body-start" required="yes" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="div-head" select="$body-start/*[1]"/>
 
 <xsl:template match="tei:front">
  <xsl:variable name="div" select="../tei:body/tei:div[*[1]/normalize-space(string-join(text(), ' ')) = $div-head]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:copy-of select="$div/preceding-sibling::*" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:body">
  <xsl:variable name="div" select="../tei:body/tei:div[*[1]/normalize-space(string-join(text(), ' ')) = $div-head]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:choose>
    <xsl:when test="exists($div)">
     <xsl:copy-of select="$div, $div/following-sibling::*" />  
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:copy>
 </xsl:template>
  
</xsl:stylesheet>