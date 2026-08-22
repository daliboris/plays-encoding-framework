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
   <xd:p><xd:b>Created on:</xd:b> 2026-08-22</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="move-epiloque"/>
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 
 <xsl:template match="tei:body/tei:div[@type='act'][last()][tei:div[last()][self::tei:div[@type='epilogue']]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates mode="move-epiloque" />
  </xsl:copy>
  <xsl:copy-of select="tei:div[last()][self::tei:div[@type='epilogue']]" />
 </xsl:template>
 
 <xsl:template match="tei:body/tei:div[@type='act'][last()]/tei:div[last()][self::tei:div[@type='epilogue']]" mode="move-epiloque" />
 
</xsl:stylesheet>