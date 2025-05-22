<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xd2dc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 
 
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-skip"/>
 <xsl:strip-space elements="*"/>
 
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 15, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 

 <xsl:template match="/body">
  <text>
    <xsl:apply-templates select="table[1]/following-sibling::node()" />
  </text>
 </xsl:template>
 
 <xsl:template match="div[@type=('front', 'back')]">
  <xsl:element name="{@type}" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="@xd2dc:form" />
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="div[@type=('main')]">
  <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="@xd2dc:form" />
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="div[@type=('titlePage','argument')]">
  <xsl:element name="{@type}" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="div[@type='title']">
  <xsl:element name="docTitle"  namespace="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="@* except @type" />
   <xsl:element name="titlePart">
    <xsl:apply-imports />    
   </xsl:element>
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="div[@type='imprint']">
  <xsl:element name="docImprint"  namespace="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="@*" />
   <xsl:apply-imports />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="div[@type=('act', 'scene', 'preface',  'prologue', 'epilogue', 'dedication', 'appendix', 'epistle')]">
  <xsl:element name="{name()}" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="div[@type=('chorus')]">
  <xsl:element name="{name()}" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="@*" />
   <xsl:attribute name="n" select="@type" />
   <xsl:attribute name="type" select="'scene'" />
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="div[@type=('dramatisPersonae')]">
  <xsl:element name="{name()}" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:copy-of select="@* except @type" />
   <xsl:attribute name="type" select="'Dramatis_Personae'" />
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="DraCor-character-name">
  <xsl:element name="role" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="DraCor-role-description">
  <xsl:element name="roleDesc" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="DraCor-stage-directions-etc.">
  <xsl:element name="stage" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="DraCor-speaker-attribution">
  <xsl:element name="speaker" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="DraCor-foreign-language">
  <xsl:element name="foreign" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates />
  </xsl:element>
 </xsl:template>


 <!-- TODO: convert to <l @n> -->
 <xsl:template match="DraCor-line-number">
  <xsl:variable name="value" select="normalize-space()"/>
  <xsl:element name="lb" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="n" select="$value" />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="DraCor-page-beginning">
  <xsl:variable name="value" select="normalize-space()"/>
  <xsl:element name="pb" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="n" select="$value" />
  </xsl:element>
 </xsl:template>
 

 <xsl:template match="DraCor-head">
  <head><xsl:apply-templates /></head>
 </xsl:template>
 
 <xsl:template match="DraCor-standard | Normální">
  <xsl:variable name="form" select="ancestor-or-self::*[@xd2dc:form][1]/@xd2dc:form"/>
  <xsl:variable name="element" select="if($form = 'verse') then 'l' else 'p'"/>
  <xsl:element name="{$element}" xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates /></xsl:element>
 </xsl:template>
 
 <xsl:template match="*[not(*)]/text() | *[tab and text()]/text()">
  <xsl:value-of select="."/>
 </xsl:template>
 
 <xsl:template match="*[tab and text()]" priority="2">
  <xsl:apply-templates select="node()" />
 </xsl:template>
 
 <xsl:template match="tab">
  <xsl:element name="space" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="unit" select="'tab'" />
   <xsl:attribute name="quantity" select="1" />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="DraCor-mark-verse-part">
  <xsl:element name="milestone" namespace="http://www.tei-c.org/ns/1.0">
   <xsl:attribute name="unit" select="'speech'" />
  </xsl:element>
 </xsl:template>
 
</xsl:stylesheet>