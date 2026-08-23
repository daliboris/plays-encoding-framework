<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 exclude-result-prefixes="xs math xd tei map tnf"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Oct 7, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="persons"  as="map(xs:string, xs:string)">
  <xsl:map>
   <xsl:for-each select="//tei:listPerson/tei:person/tei:persName"> <!-- [@type='main'] -->
    <xsl:variable name="key" select="string()"/>
    <xsl:variable name="tokens" select="tokenize($key)"/>

    <xsl:map-entry key="$key" select="../@xml:id/string()" />
    
    <xsl:if test="count($tokens) eq 2">
     <xsl:map-entry key="$tokens[2] || ' ' || $tokens[1]" select="../@xml:id/string()" />
    </xsl:if>
   </xsl:for-each>
  </xsl:map>
 </xsl:variable>
 
 <xsl:variable name="person-names-regex" select="'(' || string-join(tnf:sort-items-by-string-length(map:keys($persons)), '\b|') ! tnf:transform-for-regex(.) ! replace(., '\.\\b', '.') || ')'  "/>
 
 <xsl:template match="/" use-when="false()">
  <xsl:comment> <xsl:value-of select="$person-names-regex"/> </xsl:comment>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:argument/tei:p/tei:text[not(*)] | tei:argument/tei:p/tei:hi[not(*)]">
  <xsl:variable name="element" select="."/>
  <xsl:analyze-string select="." regex="{$person-names-regex}" flags=";j">
   <xsl:matching-substring>
    <tei:ref type="person" target="#{$persons?(.)}">
     <xsl:copy-of select="$element/@rendition" />
     <xsl:value-of select="."/>
    </tei:ref>
   </xsl:matching-substring>
   <xsl:non-matching-substring>
    <xsl:element name="{$element/name()}">
     <xsl:copy-of select="$element/@*" />
     <xsl:choose>
      <!-- <xsl:when test="starts-with(., ' ') or ends-with(., ' ')"> -->
      <xsl:when test=". = ' '">
       <xsl:attribute name="xml:space" select="'preserve'" />
      </xsl:when>
     </xsl:choose>
     <xsl:copy-of select="." />
    </xsl:element>
   </xsl:non-matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 
 
</xsl:stylesheet>