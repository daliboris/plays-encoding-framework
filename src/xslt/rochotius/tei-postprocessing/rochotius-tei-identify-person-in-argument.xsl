<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 exclude-result-prefixes="xs math xd tei map"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Oct 7, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="persons"  as="map(xs:string, xs:string)">
  <xsl:map>
   <xsl:for-each select="//tei:listPerson/tei:person">
    <xsl:map-entry key="tei:persName[@type='main'][1]/string()" select="@xml:id/string()" />
   </xsl:for-each>
  </xsl:map>
 </xsl:variable>
 
 <xsl:variable name="person-names-regex" select="string-join(map:keys($persons), '|')"/>
 
 <xsl:template match="tei:argument/tei:p/tei:text[not(*)] | tei:argument/tei:p/tei:hi[not(*)]">
  <xsl:variable name="element" select="."/>
  <xsl:analyze-string select="." regex="{$person-names-regex}">
   <xsl:matching-substring>
    <tei:ref type="person" target="#{$persons?(.)}">
     <xsl:copy-of select="$element/@rendition" />
     <xsl:value-of select="."/>
    </tei:ref>
   </xsl:matching-substring>
   <xsl:non-matching-substring>
    <xsl:element name="{$element/name()}">
     <xsl:copy-of select="$element/@*" />
     <xsl:copy-of select="." />
    </xsl:element>
   </xsl:non-matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 
 
</xsl:stylesheet>