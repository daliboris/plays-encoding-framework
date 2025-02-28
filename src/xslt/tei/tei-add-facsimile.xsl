<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Apr 11, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
<!-- <xsl:variable name="path" select="'/data/images/single/'"/>-->
 <xsl:param name="path" select="'data/images/single/'"/>
 <xsl:param name="extension" select="'jpg'"/>
 
 <xsl:template match="tei:TEI/tei:teiHeader">
  <xsl:copy-of select="." />
  <tei:facsimile xml:id="{ancestor::tei:TEI/@xml:id}.facs">
   <xsl:for-each select="/tei:TEI/tei:text//tei:pb">
     <xsl:variable name="n" select="@xml:id"/>
    <tei:surface xml:id="{$n}.surf" corresp="#{$n}">
     <tei:graphic url="{$n}.{$extension}" />
    </tei:surface>
   </xsl:for-each>
  </tei:facsimile>
 </xsl:template>
 
 <xsl:template match="tei:pb">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="facs" select="concat($path, @xml:id, '.', $extension)" />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>