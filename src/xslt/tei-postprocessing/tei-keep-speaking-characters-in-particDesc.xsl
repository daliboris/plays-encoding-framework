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
   <xd:p><xd:b>Created on:</xd:b> 2026-07-31</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="all-speakers" select="/tei:TEI/tei:text//@who ! substring-after(., '#') =>  distinct-values()"/>
 
 <xsl:template match="tei:particDesc/tei:listPerson/tei:person[not(@xml:id = $all-speakers)]" />
 <xsl:template match="tei:particDesc/tei:listPerson/tei:personGrp[not(@xml:id = $all-speakers)]" />
 
 
 
</xsl:stylesheet>