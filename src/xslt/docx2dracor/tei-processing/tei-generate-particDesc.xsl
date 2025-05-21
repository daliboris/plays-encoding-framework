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
   <xd:p><xd:b>Created on:</xd:b> May 20, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="yes" />
 
 <xsl:key name="speeches" match="tei:sp" use="@who" />
 
 <xsl:template match="tei:profileDesc">
  <xsl:variable name="text" select="/tei:TEI/tei:text"/>
  <xsl:variable name="ids" select="distinct-values($text//@who)"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <particDesc>
    <listPerson>
     <xsl:for-each select="$ids">
      <xsl:sort select="." />
      <xsl:variable name="id" select="."/>
      <xsl:variable name="speaker" select="key('speeches', $id, $text)[1]/tei:speaker"/>
      <person xml:id="{substring-after($id, '#')}" sex="" role="">
       <persName><xsl:value-of select="$speaker"/></persName>
      </person>
     </xsl:for-each>
    </listPerson>
   </particDesc>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>