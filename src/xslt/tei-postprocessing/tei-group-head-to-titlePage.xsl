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
   <xd:p><xd:b>Created on:</xd:b> Jul 21, 2026</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="max-head-items" as="xs:integer" required="yes" />
 <xsl:strip-space elements="*"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="yes" />
 
 <xsl:template match="tei:head[
  (
  preceding-sibling::*[1][self::tei:p[count(*) eq 1][tei:pb]]
  and
  following-sibling::*[1][self::tei:head]
  )
  or
  (
  preceding-sibling::*[1][self::tei:head] 
  and
  following-sibling::*[1][self::tei:head]
  )
  or 
  (preceding-sibling::*[1][self::tei:head] 
  and
  following-sibling::*[1][self::tei:p[count(*) eq 1][tei:pb]]
  )
  ][count(preceding-sibling::*) lt $max-head-items][1] 
  ">
  <tei:div type="titlePage">
   <xsl:copy-of select="." />
   <xsl:copy-of select="following::*[self::tei:head[
    (
    preceding-sibling::*[1][self::tei:p[count(*) eq 1][tei:pb]]
    and
    following-sibling::*[1][self::tei:head]
    )
    or
    (
    preceding-sibling::*[1][self::tei:head] 
    and
    following-sibling::*[1][self::tei:head]
    )
    or 
    (preceding-sibling::*[1][self::tei:head] 
    and
    following-sibling::*[1][self::tei:p[count(*) eq 1][tei:pb]]
    )
    ][count(preceding-sibling::*) lt $max-head-items]]" />
  </tei:div>
 </xsl:template>
 
 <xsl:template match="tei:head[
  (
  preceding-sibling::*[1][self::tei:p[count(*) eq 1][tei:pb]]
  and
  following-sibling::*[1][self::tei:head]
  )
  or
  (
  preceding-sibling::*[1][self::tei:head] 
  and
  following-sibling::*[1][self::tei:head]
  )
  or 
  (preceding-sibling::*[1][self::tei:head] 
  and
  following-sibling::*[1][self::tei:p[count(*) eq 1][tei:pb]]
  )
  ][count(preceding-sibling::*) lt $max-head-items][position() gt 1] 
  ">
 </xsl:template>
 
</xsl:stylesheet>