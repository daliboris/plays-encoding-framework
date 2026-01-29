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
 
 <xsl:variable name="latin-number-regex">^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$</xsl:variable>
 
 <xsl:function name="tnf:get-valid-id" as="xs:string?">
  <xsl:param name="text" as="xs:string?" />
  <xsl:value-of select="fn:normalize-space($text) => translate(' &#xa0;,.:–', '__--') => replace('-+', '-') => replace('\P{L}$', '') => lower-case() => tnf:remove-diacritics()"/>
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
 
 <xsl:function name="tnf:roman-to-arabic" as="xs:integer">
  <xsl:param name="roman" as="xs:string"/>
  
  <xsl:variable name="s"
   select="replace(upper-case($roman), '\s+', '')"/>
  
  <xsl:variable name="map" as="map(xs:string, xs:integer)">
   <xsl:map>
    <xsl:map-entry key="'M'"   select="1000"/>
    <xsl:map-entry key="'CM'"  select="900"/>
    <xsl:map-entry key="'D'"   select="500"/>
    <xsl:map-entry key="'CD'"  select="400"/>
    <xsl:map-entry key="'C'"   select="100"/>
    <xsl:map-entry key="'XC'"  select="90"/>
    <xsl:map-entry key="'L'"   select="50"/>
    <xsl:map-entry key="'XL'"  select="40"/>
    <xsl:map-entry key="'X'"   select="10"/>
    <xsl:map-entry key="'IX'"  select="9"/>
    <xsl:map-entry key="'V'"   select="5"/>
    <xsl:map-entry key="'IV'"  select="4"/>
    <xsl:map-entry key="'I'"   select="1"/>
   </xsl:map>
  </xsl:variable>
  
  <xsl:sequence select="
   sum(
   for $m in analyze-string($s,
   '(CM|CD|XC|XL|IX|IV|M|D|C|L|X|V|I)')/fn:match
   return $map(string($m))
   )
   "/>
 </xsl:function>
 
</xsl:stylesheet>