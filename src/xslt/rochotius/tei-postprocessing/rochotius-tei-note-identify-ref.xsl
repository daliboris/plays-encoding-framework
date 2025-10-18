<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:fn="http://www.w3.org/2005/xpath-functions"
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 exclude-result-prefixes="xs math xd tei fn tnf"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 20, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:output indent="true" />
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:variable name="birth-death-regex" select="'\((\d+)[–-](\d+)\)[\.,]?(.*)'"/>
 <xsl:variable name="quoted-text-regex" select="'\[(.[^\]]*)\]'"/>
 <xsl:variable name="types" select="map {
  'bold' : 'per', 'strike' : 'place', 'underline' : 'gloss', 'italic' : 'gloss',
  'person' : 'bold', 'place' : 'strike', 'gloss' : 'underline'
  }"/>
 
 <xsl:variable name="ref-types" select="map {
  'bold' : 'person', 'strike' : 'place', 'underline' : 'gloss'
  }"/>
 
 <xsl:template match="text()[following-sibling::*[1][self::tei:note/tei:p[tei:hi[@rendition]][starts-with(normalize-space(), '[')]]]" use-when="false()">
  <xsl:variable name="note" select="following-sibling::*[1]"/>
  <xsl:variable name="hi" select="$note/tei:p/tei:hi[@rendition][1]"/>
  <xsl:variable name="xml-id" select="tnf:get-valid-xml-id($hi, $types($hi/@rendition/data()))"/>
  <xsl:variable name="rendition" select="$note/tei:p/tei:hi[1]/@rendition"/>
  <xsl:variable name="type" select="$types($rendition)"/>
  <xsl:variable name="quoted-text" select="tnf:get-quoted-text($note)"/>
  <xsl:analyze-string select="." regex="{$quoted-text}">
   <xsl:matching-substring>
    <tei:ref target="#{$xml-id}" type="{$type}"><xsl:value-of select="."/></tei:ref>
   </xsl:matching-substring>
   <xsl:non-matching-substring>
    <xsl:value-of select="."/>
   </xsl:non-matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 
 <xsl:template match="tei:note/tei:p[tei:hi[@rendition]]/text()[starts-with(normalize-space(), '[')]" use-when="false()">
  <xsl:variable name="quoted-text" select="tnf:get-quoted-text(.)"/>
  <xsl:analyze-string select="." regex="{concat('\[', $quoted-text, '\]')}">
   <xsl:matching-substring>
    <tei:ref><xsl:value-of select="."/></tei:ref>
   </xsl:matching-substring>
   <xsl:non-matching-substring>
    <xsl:value-of select="."/>
   </xsl:non-matching-substring>
  </xsl:analyze-string>
 </xsl:template>
 
 <xsl:template match="tei:note/tei:p[contains(., '–')][matches(text()[1], '\[.*\]')][tei:hi[@rendition]]/text()" use-when="true()"  />
 <xsl:template match="tei:note/tei:p[contains(., '–')][matches(text()[1], '\[.*\]')][tei:hi[@rendition]]/tei:hi[@rendition='italic']" use-when="true()" />
 
 <xsl:template match="tei:text//text()[normalize-space() != ''][following-sibling::node()[1][self::tei:note[tei:p[contains(., ' – ')][tei:hi]]]]">
  <xsl:variable name="type" select="$types?(following-sibling::tei:note[1]/tei:p/tei:hi[1]/@rendition/string())"/>
  <xsl:variable name="ref-type" select="$ref-types?(following-sibling::tei:note[1]/tei:p/tei:hi[1]/@rendition/string())"/>
  <xsl:variable name="ref-element" select="following-sibling::tei:note[1]/tei:p/tei:hi[1]/preceding-sibling::text()[1]/normalize-space() !  translate(., '[]', '')"/>
  <xsl:variable name="entity" select="following-sibling::tei:note[1]/tei:p/tei:hi[1]/normalize-space()"/>
  <xsl:variable name="xml-id" select="tnf:get-valid-xml-id($entity, $type)"/>
  <xsl:variable name="last-word" select="analyze-string(., '\w+')/fn:match[last()]/string()"/>
  <!-- [Carolo a Zierotina, libero Baroni in Drzevohosticz, Rossicz et Przerovii] -->
  <!-- Karel starší ze Žerotína -->
  
  <xsl:choose>
   <xsl:when test="$ref-element != ''">
    <xsl:analyze-string select="." regex="{$ref-element}">
     <xsl:matching-substring>
      <tei:ref target="#{$xml-id}" type="{$ref-type}"><xsl:value-of select="."/></tei:ref>
     </xsl:matching-substring>
     <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
    </xsl:analyze-string>
   </xsl:when>
   <xsl:otherwise>
    <xsl:analyze-string select="." regex="{$last-word}">
     <xsl:matching-substring>
      <xsl:if test="string-length(.) gt 0">
       <tei:ref target="#{$xml-id}" type="{$ref-type}"><xsl:value-of select="."/></tei:ref> 
      </xsl:if>
     </xsl:matching-substring>
     <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
    </xsl:analyze-string>
   </xsl:otherwise>
  </xsl:choose>
  
 </xsl:template>
 
 <xsl:template match="tei:text//tei:note/tei:p[contains(., ' – ')][tei:hi[@rendition]]">
  <xsl:variable name="type" select="$types?(tei:hi[1]/@rendition/string())"/>
  <xsl:variable name="ref-type" select="$ref-types?(tei:hi[1]/@rendition/string())"/>
  <xsl:variable name="entity" select="tei:hi[1]/normalize-space()"/>
  <xsl:variable name="xml-id" select="tnf:get-valid-xml-id($entity, $type)"/>
  <xsl:variable name="note" select="tnf:get-note(tei:hi[1]/following-sibling::node())"/>
  <xsl:variable name="text" select="$entity"/>
  
  <xsl:choose>
   <xsl:when test="$ref-type = 'person'">
    <tei:person xml:id="{$xml-id}" sex="UNKNOWN">
     <tei:persName xml:lang="cs" type="main"><xsl:value-of select="$text"/></tei:persName>
     <xsl:choose>
      <xsl:when test="count($note) = 1 and matches($note/string(), $birth-death-regex)">
       <xsl:variable name="birth" select="replace($note, $birth-death-regex, '$1')"/>
       <xsl:variable name="death" select="replace($note, $birth-death-regex, '$2')"/>
<!--       <tei:idno type="GND" />-->
       <tei:note type="bio"><xsl:value-of select="replace($note, $birth-death-regex, '$3')"/></tei:note>
       <tei:birth>
        <tei:date when="{$birth}" />
        <tei:placeName />
       </tei:birth>
       <tei:death>
        <tei:date when="{$death}" />
        <tei:placeName />
       </tei:death>
      </xsl:when>
      <xsl:otherwise>
<!--       <tei:idno type="GND" />-->
       <tei:note type="bio"><xsl:copy-of select="$note"/></tei:note>
      </xsl:otherwise>
     </xsl:choose>
     
    </tei:person>
   </xsl:when>
   <xsl:when test="$ref-type = 'place'">
    <tei:place xml:id="{$xml-id}">
     <tei:placeName type="main" xml:lang="cs"><xsl:value-of select="$text"/></tei:placeName>
<!--     <tei:idno type="GND" />-->
     <tei:note><xsl:copy-of select="$note"/></tei:note>
    </tei:place>
   </xsl:when>
   <xsl:when test="$ref-type = 'gloss'">
    <xsl:variable name="xml-id" select="tnf:get-valid-xml-id($text,$type)" />;
    <tei:item xml:id="{$xml-id}">
     <tei:label type="main"><xsl:value-of select="$text"/></tei:label>
     <tei:gloss xml:lang="cs"><xsl:copy-of select="$note"/></tei:gloss>
     <tei:gloss xml:lang="en" />
<!--     <tei:idno type="GND" />-->
     <tei:note />
    </tei:item>
   </xsl:when>
  </xsl:choose>
 </xsl:template>
 
 <xsl:function name="tnf:get-note" as="node()*">
  <xsl:param name="text" as="node()*" />
  <xsl:for-each select="$text">
   <xsl:choose>
    <xsl:when test=".[self::text()][fn:starts-with(fn:normalize-space(.), '– ')]">
     <xsl:value-of select="fn:substring-after(., '– ')"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:copy-of select="." />
    </xsl:otherwise>
   </xsl:choose>
  </xsl:for-each>
 </xsl:function>
 
 <xsl:function name="tnf:get-quoted-text" as="xs:string">
  <xsl:param name="text" as="xs:string" />
  <xsl:value-of select="analyze-string($text, $quoted-text-regex)/*/fn:group[1]"/>
 </xsl:function>


 
 
</xsl:stylesheet>