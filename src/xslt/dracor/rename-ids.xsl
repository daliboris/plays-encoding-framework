<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:dcf="https://www.daliboris.cz/ns/dracor/xslt"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 5, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:param name="id-regex">^(#?\w+\W)(\w+)(.*)?$</xsl:param>
 
 <xsl:template match="tei:person/@xml:id[matches(., $id-regex)]">
  <xsl:attribute name="id" select="dcf:clean-id(.)" namespace="http://www.w3.org/XML/1998/namespace" />
 </xsl:template>
 
 <xsl:template match="@who[matches(., $id-regex)] | @ref[matches(., $id-regex)]">
  <xsl:attribute name="{local-name()}" select="dcf:clean-id(.)" />
 </xsl:template>
 
 <xsl:function name="dcf:clean-id" as="xs:string">
  <xsl:param name="text" as="xs:string" />
  <xsl:value-of select="replace($text, $id-regex, '$2')"/>
 </xsl:function>
 
</xsl:stylesheet>