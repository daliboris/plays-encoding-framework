<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs math xd"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Nov 6, 2023</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:mode on-no-match="shallow-skip"/>
  
  <xsl:output method="xml" indent="yes" />
  
  <xsl:template match="body">
    <data><xsl:apply-templates /></data>
  </xsl:template>
  
  <xsl:template match="row[@n > 1]">
    <note>
       <xsl:apply-templates />
    </note>
  </xsl:template>
  
  
  
  <xsl:template match="cell[@n='1']">
    <xsl:attribute name="n" select="normalize-space(.)" />
  </xsl:template>
  
</xsl:stylesheet>