<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:d="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt/data" 
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 
 <xsl:variable name="nonbreak-space" select="'&#xa0;'"/>
 
 <xsl:template match="tei:body//tei:div[not(tei:head)][not(@n)]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="n" select="$nonbreak-space" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>