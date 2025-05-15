<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs math xd" version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 6, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="text[@bold='true'][@smallCaps='true'][tab][count(*) eq 1]">
  <text>
   <xsl:apply-templates /> 
  </text>
 </xsl:template>
 
 <xsl:template match="footnote/*[name() != 'footnote-text']">
  <footnote-text>
   <xsl:apply-templates/>
  </footnote-text>
 </xsl:template>
 
 <xsl:template match="comment/*[name() != 'annotation-text']">
  <annotation-text>
   <xsl:apply-templates/>
  </annotation-text>
 </xsl:template>
</xsl:stylesheet>
