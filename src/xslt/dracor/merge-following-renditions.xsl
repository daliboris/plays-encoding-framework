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
   <xd:p><xd:b>Created on:</xd:b> 2026-08-21</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:emph[
  let $rend := @rend return let $name := name()  
  return following-sibling::node()
  [normalize-space()!='' or self::*[not(node())]]
  [1][self::tei:*[@rend = $rend and name() = $name]]
  ]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:apply-templates select="following-sibling::node()
    [normalize-space()!='' or self::*[not(node())]]
    [1]" mode="content" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:*" mode="content">
  <xsl:apply-templates />
  <xsl:apply-templates select="let $rend := @rend return let $name := name()  
   return following-sibling::node()
   [normalize-space()!='' or self::*[not(node())]]
   [1][self::tei:*[@rend = $rend and name() = $name]]
   " mode="#current" />
 </xsl:template>
 
 <xsl:template match="tei:emph[
  let $rend := @rend return let $name := name()  
  return preceding-sibling::node()
  [normalize-space()!='' or self::*[not(node())]]
  [1][self::tei:*[@rend = $rend and name() = $name]]
  ]" />
</xsl:stylesheet>