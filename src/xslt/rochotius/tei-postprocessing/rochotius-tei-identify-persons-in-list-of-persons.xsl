<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 xmlns:fn="http://www.w3.org/2005/xpath-functions"
 exclude-result-prefixes="xs math xd fn tnf"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jul 13, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="../../common/_tei-play-variables.xsl"/>
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
 <xsl:mode on-no-match="shallow-copy"/>


 <xsl:param name="project-suffix" select="'tnl'"/>
<!-- <xsl:variable name="name-suffix" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]/translate(., '[]', '') ! tokenize(normalize-space()) ! substring(., 1, 1) ! lower-case(.) => string-join()"/>-->
 <xsl:variable name="full-suffix" select="concat('-',  $name-suffix, '-', $project-suffix)"/>

 <xsl:key name="person" match="tei:person" use="@xml:id" />
 <xsl:variable name="person-regex" select="'^(\p{Lu}\w+)[,\.]|(Artemona)|(Rosina)|(Thamar)'"/>
 
 <xsl:template match="tei:div[@type='list-of-persons']/tei:p/text()[matches(., $person-regex)]">
  <xsl:variable name="text" select="analyze-string(., $person-regex)/fn:match/fn:group[1]"/>
  <xsl:variable name="text-after" select="substring-after(., $text)"/>
  <xsl:variable name="xml-id" select="tnf:get-valid-xml-id($text, 'per') || $full-suffix"/>
  <xsl:variable name="person" select="key('person', $xml-id)"/>
  <xsl:choose>
   <xsl:when test="$person[tei:persName[@xml:lang='la'] = $text]">
    <tei:persName ref="#{$xml-id}"><xsl:value-of select="$text"/></tei:persName><xsl:value-of select="$text-after"/>
   </xsl:when>
   <xsl:when test="$person">
    <xsl:comment> TODO: odlišné jméno osoby v textu a v seznamu &lt;listPerson&gt; </xsl:comment>
    <tei:persName ref="#{$xml-id}"><xsl:value-of select="$text"/></tei:persName><xsl:value-of select="$text-after"/>
   </xsl:when>
   <xsl:otherwise>
    <tei:ref target="#{$xml-id}" type="person"><xsl:value-of select="$text"/></tei:ref>
    <tei:note>
     <tei:person xml:id="{$xml-id}" sex="UNKNOWN">
      <tei:persName xml:lang="cs" type="main"><xsl:value-of select="$text"/></tei:persName>
      <tei:note type="bio" />
     </tei:person>
    </tei:note>
    <xsl:value-of select="$text-after"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 
</xsl:stylesheet>