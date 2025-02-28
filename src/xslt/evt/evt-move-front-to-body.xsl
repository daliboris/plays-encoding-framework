<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Apr 14, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:body">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates select="../tei:front" mode="body" />
   <xsl:copy-of select="node()" />
  </xsl:copy>
  
 </xsl:template>
 
 <xsl:template match="tei:front" mode="body">
  <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="type" select="'title'" />
   <xsl:attribute name="n" select="'&#160;'" />
   <xsl:attribute name="resp" select="'#Boris'" />
   <xsl:apply-templates select=".//tei:pb[1]" mode="copy" />
   <xsl:choose>
    <xsl:when test="count(tei:performance) lt 2">
     <xsl:apply-templates mode="#current" />
    </xsl:when>
    <xsl:otherwise>
     <xsl:for-each-group select="*" group-ending-with="tei:performance">
      <xsl:variable name="type" select="if(position() = 1) then 'latin' else 'czech'"/>
      <xsl:variable name="lang" select="if(position() = 1) then 'la' else 'cs'"/>
      <xsl:if test="position() lt 3">
       <tei:div type="{$type}" n="&#160;" xml:lang="{$lang}">
        <xsl:apply-templates select="current-group()" mode="#current" />
       </tei:div>       
      </xsl:if>
     </xsl:for-each-group>     
    </xsl:otherwise>
   </xsl:choose>
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="tei:docTitle" mode="body">
  <xsl:apply-templates mode="#current" />
 </xsl:template>
 
 <xsl:template match="tei:titlePart" mode="body">
  <tei:head>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates mode="#current" />
  </tei:head>
 </xsl:template>
 
 <xsl:template match="tei:performance" mode="body">
  <tei:div n="performace">
   <xsl:apply-templates />
  </tei:div>
 </xsl:template>
 
 <xsl:template match="tei:pb" mode="body" />
 
 <xsl:template match="tei:div[@type='editorial']" mode="body" />
 
 <xsl:template match="tei:pb" mode="copy">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="id" namespace="http://www.w3.org/XML/1998/namespace" select="concat(@xml:id, '-copy')" />
   <xsl:attribute name="copyOf" select="concat('#', @xml:id)" />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>