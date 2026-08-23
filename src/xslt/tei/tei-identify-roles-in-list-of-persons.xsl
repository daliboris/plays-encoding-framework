<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-08-22</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>

 
 <xsl:param name="roles" as="element()*" required="yes" />
 
 <xsl:variable name="roles-map" as="map(*)">
  <xsl:map>
   <xsl:for-each select="$roles">
    <xsl:variable name="role" select="."/>
    <xsl:variable name="names" select="tokenize($role, ',\s')[.]"/>
    <xsl:for-each select="$names">
     <xsl:variable name="name" select="."/>
     <xsl:map-entry key="$name" select="$role/@id" />
    </xsl:for-each>
   </xsl:for-each>
  </xsl:map>
 </xsl:variable>
 
 <xsl:variable name="roles-names" select="map:keys($roles-map)"/>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:person[tei:persName = $roles-names] | tei:personGrp[tei:name = $roles-names]">
  <xsl:variable name="name" select="*[. = $roles-names][1]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="role" select="map:get($roles-map, $name)" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>