<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xd2dc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 19, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="prose"/>
 <xsl:mode on-no-match="shallow-copy" name="verse"/>
 
 <xsl:template match="tei:div[@type=('dedication', 'preface', 'epistle')] | tei:titlePart  | tei:docImprint">
  <xsl:variable name="form" select="ancestor::*[@xd2dc:form][1]/@xd2dc:form"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:choose>
    <xsl:when test="$form = 'prose'">
     <xsl:choose>
      <xsl:when test="self::tei:div">
       <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:apply-templates mode="prose" />   
       </xsl:element>
      </xsl:when>
      <xsl:otherwise>
       <xsl:apply-templates mode="prose" />
      </xsl:otherwise>
     </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates mode="verse" />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:titlePage/tei:p">
  <xsl:variable name="form" select="ancestor::*[@xd2dc:form][1]/@xd2dc:form"/>
  <xsl:choose>
   <xsl:when test="$form = 'prose'">
    <xsl:apply-templates select="." mode="prose" />
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates select="." mode="verse" />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="tei:p" mode="prose">
  <xsl:element name="lb" namespace="http://www.tei-c.org/ns/1.0" />
  <xsl:apply-templates />
  <xsl:value-of select="'&#xa;'"/>
 </xsl:template>
 
 <xsl:template match="tei:l" mode="verse">
  <xsl:element name="l" namespace="http://www.tei-c.org/ns/1.0" />
  <xsl:apply-templates />
 </xsl:template>
 
</xsl:stylesheet>