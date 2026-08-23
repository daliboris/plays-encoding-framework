<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="#all"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-07-25</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:argument
  [preceding-sibling::*[1][self::tei:head]]
  [following-sibling::*[1][self::tei:head[text() = ('Argumentum', 'Anagramma')]]]
  [following-sibling::*[2][self::tei:argument]]">
  <stage>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="type" select="'characters'" />
   <xsl:apply-templates />
  </stage>
 </xsl:template>
 
 <xsl:template match="tei:argument
  [preceding-sibling::*[3][self::tei:head]]
  [preceding-sibling::*[2][self::tei:argument]]
  [preceding-sibling::*[1][self::tei:head[text() = ('Argumentum', 'Anagramma')]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
<!--   <xsl:apply-templates select="preceding-sibling::*[1][self::tei:head]" mode="argument" />-->
   <xsl:copy-of select="preceding-sibling::*[1][self::tei:head]" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:head[text() = ('Argumentum', 'Anagramma')]
  [preceding-sibling::*[2][self::tei:head]]
  [preceding-sibling::*[1][self::tei:argument]]
  [following-sibling::*[1][self::tei:argument]]
  " />
 
 <xsl:template match="tei:head" mode="argument">
  <tei:p rend="center"><xsl:apply-templates /></tei:p>
 </xsl:template>
 
</xsl:stylesheet>