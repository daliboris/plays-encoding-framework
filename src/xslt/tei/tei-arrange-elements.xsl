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
   <xd:p><xd:b>Created on:</xd:b> Sep 22, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:body[tei:docTitle]">
  <tei:front>
   <xsl:copy-of select="* except tei:div[@type]" />
  </tei:front>
  <tei:body>
   <xsl:apply-templates select="tei:div[@type]" />
  </tei:body>
 </xsl:template>

 <xsl:template match="tei:div[@type='contents']">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-starting-with="tei:head">
    <tei:div>
     <xsl:copy-of select="current-group()" />
    </tei:div>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="tei:div[@type='body']">
   <xsl:for-each-group select="*" group-starting-with="tei:head">
    <tei:div>
     <xsl:copy-of select="current-group()" />
    </tei:div>
   </xsl:for-each-group>
 </xsl:template>
 

</xsl:stylesheet>