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
   <xd:p><xd:b>Created on:</xd:b> 2026-07-30</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="marge-argument"/>
 <xsl:output indent="yes" />
 
 <!--
  <stage type="characters">
   <tei:p>
     <tei:hi rendition="italic">Raphael, Tobias Junior</tei:hi>
    </tei:p>
  </stage>
  <tei:argument>
     <tei:head>Argumentum</tei:p>
     <tei:p>
        <tei:hi rendition="italic">Emensi magnum diei iter et ingressuri hospitium, Raphael et Tobias divino Numini gratiam habent.</tei:hi>
     </tei:p>
  </tei:argument>
 -->
 
 <xsl:template match="tei:stage[following-sibling::*[1][self::tei:argument][tei:head]] |
  tei:stage[following-sibling::*[1][self::tei:argument][tei:p[@rend='center']]]">
  <argument>
   <xsl:copy-of select="@* except @type" />
   <xsl:apply-templates />
   <xsl:apply-templates select="following-sibling::*[1]" mode="marge-argument" />
  </argument>
 </xsl:template>
 
 <xsl:template match="tei:argument[tei:head][preceding-sibling::*[1][self::tei:stage]] |
  tei:argument[tei:p[@rend='center']][preceding-sibling::*[1][self::tei:stage]]" />
 
 <xsl:template match="tei:argument[tei:head][preceding-sibling::*[1][self::tei:stage]] |
  tei:argument[tei:p[@rend='center']][preceding-sibling::*[1][self::tei:stage]] " mode="marge-argument">
  <xsl:apply-templates mode="#current" />
 </xsl:template>
 
 <xsl:template match="tei:p[@rend='center']" mode="marge-argument">
  <xsl:copy-of select="." />
 </xsl:template>
 
 <xsl:template match="tei:head" mode="marge-argument">
  <p rend="center"><xsl:apply-templates /></p>
 </xsl:template>
 
 
</xsl:stylesheet>