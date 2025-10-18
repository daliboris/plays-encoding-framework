<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Sep 14, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="true" />
 
 <xsl:template match="tei:app/tei:note/tei:cit">
  <xsl:variable name="author-to-ref" select="map {
   'Frischlin' : '/frisc',
   'Plautus' : 'permalink=Plaut',
   'Caesar' : 'permalink=Caes'
   }"/>
  <xsl:variable name="refs" select="../tei:ref"/>
  <xsl:variable name="cits" select="../tei:cit"/>
  <xsl:variable name="author" select="tei:bibl/tei:author"/>
  <xsl:variable name="cit-refs" select="
    $refs[contains(., $author-to-ref($author))] 
     "/>
  <xsl:variable name="position">
   <xsl:number  />
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="count($refs) = count($cits)">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:apply-templates />
     <xsl:copy-of select="$refs[xs:integer($position)]" />
    </xsl:copy>
   </xsl:when>
   <xsl:when test="count($cits) = 1">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:apply-templates />
     <xsl:copy-of select="$refs" />
    </xsl:copy>
   </xsl:when>
   <xsl:when test="count($cits) lt count($refs) ">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:apply-templates />
     <xsl:copy-of select="$cit-refs" />
     <xsl:if test="count($cit-refs) eq 0">
      <xsl:comment> TODO: chybějící odkaz </xsl:comment>
     </xsl:if>
    </xsl:copy>
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="tei:app/tei:note">
  <xsl:variable name="refs" select="tei:ref"/>
  <xsl:variable name="cits" select="tei:cit"/>
  <xsl:choose>
   <xsl:when test="(count($refs) = count($cits)) or count($cits) = 1 ">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:apply-templates select="* except tei:ref" />
    </xsl:copy>
   </xsl:when>
   <xsl:when test="(count($cits) lt count($refs))">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:apply-templates select="* except tei:ref" />
    </xsl:copy>
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
</xsl:stylesheet>