<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Mar 29, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" exclude-result-prefixes="tei" />
 <xsl:mode on-no-match="shallow-skip"/>
 
 <xsl:template match="tei:teiCorpus">
  <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude">
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-adjacent="if (self::tei:TEI) then 1 else 0">
    <xsl:choose>
     <xsl:when test="current-grouping-key() = 1" >
      <facsimile>
       <xsl:copy-of select="//tei:facsimile/*" /> 
      </facsimile>
      <text>
       <group>
        <xsl:apply-templates select="current-group()" mode="group"/>
       </group>
      </text>
     </xsl:when>
     <xsl:otherwise>
      <xsl:copy-of select="current-group()" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
   <xsl:apply-templates />
  </TEI>
 </xsl:template>
 
 <xsl:template match="tei:TEI[tei:text[@xml:id]]" mode="group">
  <xsl:variable name="id" select="tei:text[@xml:id]/@xml:id"/>
  <xsl:element name="xi:include" namespace="http://www.w3.org/2001/XInclude">
   <xsl:attribute name="href" select="concat($id, '.xml')" />
   <xsl:attribute name="xpointer" select="$id" />
  </xsl:element>
 </xsl:template>
 
 <xsl:template match="tei:TEI[tei:text[@xml:id]]" />
 
</xsl:stylesheet>