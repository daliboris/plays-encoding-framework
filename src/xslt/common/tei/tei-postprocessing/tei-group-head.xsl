<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd" version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 12, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p />
  </xd:desc>
 </xd:doc>

 <xsl:output method="xml" indent="yes" exclude-result-prefixes="tei" />
 <xsl:mode on-no-match="shallow-copy" />

 <xsl:template match="tei:head[@n = 'name']">
  <xsl:choose>
   <xsl:when test="position() = 2">
    <tei:titlePart type="main">
     <xsl:apply-templates />
    </tei:titlePart>
   </xsl:when>
   <xsl:when test="position() = 4">
    <tei:titlePart type="sub">
     <xsl:apply-templates />
    </tei:titlePart>
   </xsl:when>
   <xsl:otherwise>
    <tei:titlePart type="seu">
     <xsl:apply-templates />
    </tei:titlePart>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="tei:head[not(@n)]" mode="group">
  <tei:div>
   <tei:head>
    <xsl:copy-of select="@*" />
    <xsl:copy-of select="node()" />
   </tei:head>
   <xsl:for-each-group select="current-group() except ." group-starting-with="tei:head[@n = '2']">
    <xsl:choose>
     <xsl:when test=".[self::tei:head]">
      <xsl:apply-templates select="." mode="group" />
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </tei:div>
 </xsl:template>

 <xsl:template match="tei:head[@n = '2']" mode="group">
  <tei:div>
   <tei:head>
    <xsl:copy-of select="node()" />
   </tei:head>
   <xsl:copy-of select="current-group() except ." />
  </tei:div>
 </xsl:template>

 <xsl:template match="tei:*" mode="group">
  <xsl:copy-of select="." />
 </xsl:template>

 <xsl:template match="tei:body">
  <xsl:copy>
   <xsl:for-each-group select="*" group-starting-with="tei:head[not(@n)]">
    <xsl:choose>
     <xsl:when test=".[self::tei:head]">
      <xsl:apply-templates select="." mode="group" />      
     </xsl:when>
     <xsl:otherwise>
      <tei:front>
       <tei:docTitle>
      <xsl:apply-templates select="current-group()" />
       </tei:docTitle>
      </tei:front>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
