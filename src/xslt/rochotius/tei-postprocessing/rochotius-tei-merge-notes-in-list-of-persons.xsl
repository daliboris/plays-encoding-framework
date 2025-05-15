<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 exclude-result-prefixes="xs math xd tnf"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jul 14, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="yes" />
 
 <xsl:key name="person" match="tei:person" use="@xml:id" />
 <xsl:key name="person" match="tei:person" use="tei:persName" />
 <xsl:key name="note" match="tei:note" use="tei:p/tei:hi[@rendition='bold']" />
 
 <xsl:template match="tei:listPerson/tei:person">
  <xsl:variable name="text" select="tei:persName[@xml:lang='la'][1]"/>
  <xsl:variable name="note" select="key('note', $text)"/>
  <xsl:choose>
   <xsl:when test="exists($note)">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:copy-of select="* except (tei:note[@type='bio'], tei:occupation)" />
     <tei:note type='bio'>
      <xsl:apply-templates select="tei:note[@type='bio']/node()" />
      <tei:p xml:lang="cs">
       <xsl:copy-of select="$note/tei:p/tei:hi[@rendition='bold']/following-sibling::node()" />
      </tei:p>
     </tei:note>
     <xsl:copy-of select="tei:occupation" />
    </xsl:copy>
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="tei:div[@type='list-of-persons']/tei:p/tei:note[tei:p/tei:hi[@rendition='bold']]">
  <xsl:variable name="text" select="tei:p/tei:hi[@rendition='bold'][1]"/>
  <xsl:variable name="xml-id" select="tnf:get-valid-xml-id($text, 'per')"/>
  <xsl:variable name="person" select="key('person', $xml-id)"/>
  
  <xsl:if test="empty($person)">
   <xsl:copy-of select="." />
  </xsl:if>
  
 </xsl:template>
 
</xsl:stylesheet>