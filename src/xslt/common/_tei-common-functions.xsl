<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:fn="http://www.w3.org/2005/xpath-functions"
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 exclude-result-prefixes="xs math xd tei fn tnf"
 version="3.0">
 <xsl:function name="tnf:get-valid-id" as="xs:string?">
  <xsl:param name="text" as="xs:string?" />
  <xsl:value-of select="fn:normalize-space($text) => translate(' &#xa0;,.:–', '----') => replace('-+', '-') => replace('\P{L}$', '') => lower-case() => tnf:remove-diacritics()"/>
 </xsl:function>
 
 <xsl:function name="tnf:remove-diacritics" as="xs:string?">
  <xsl:param name="text" as="xs:string?" />
  <xsl:value-of select="normalize-unicode($text, 'NFD') => replace('\p{M}', '')"/>
 </xsl:function>
 
 <xsl:function name="tnf:get-valid-xml-id" as="xs:string?">
  <xsl:param name="text" as="xs:string?" />
  <xsl:param name="type" as="xs:string" />
  <xsl:value-of select="$type || '.' || tnf:get-valid-id($text)"/>
 </xsl:function>
</xsl:stylesheet>