<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 xmlns="http://www.tei-c.org/ns/1.0" 
 xmlns:fn="http://www.w3.org/2005/xpath-functions"
 exclude-result-prefixes="xs math xd tei fn"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 6, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>

 <xsl:param name="text-id"  required="yes" />
 <xsl:param name="teiHeader" required="yes" as="element(tei:teiHeader)" />

 <xsl:param name="comment-prefix" select="'app'"/>
 <xsl:param name="note-prefix" select="'note'"/>
 <xsl:param name="text-filename" select="concat($text-id, '.text.xml')"/>
 <xsl:param name="id-format" select="'000000'"/>
 <xsl:param name="sigla-regex" select="'\[([A-Z]+[a-z]*\d+[rv])\]'"/>
 <xsl:param name="scena-regex" select="'Actus ([IVX]+)\.\s+Scena ([IVX]+)'"/>
 <!-- <xsl:variable name="speaker-regex" select="'^\p{Lu}[\p{Ll}\[\]]+(\s+\p{Lu}[\p{Ll}\[\]]+)?:$'"/>-->
 <xsl:param name="speaker-regex" select="'^\[?\p{Lu}[\p{Ll}\[\]]+(\s+\p{Lu}[\p{Ll}\[\]]+)?:\]?$'"/>
 
 <xsl:key name="comment" match="comment" use="@id" />
 <xsl:key name="footnote" match="footnote" use="@id" />

 
 
 <xsl:strip-space elements="*"/>
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 
 <xsl:template match="/">
 <TEI xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" xml:lang="la">
  <xsl:copy-of select="$teiHeader"/>
  <text xml:id="{$text-id}.text"><xsl:apply-templates /></text>
 </TEI> 
 </xsl:template>
 
 
 
 <xsl:template match="body">
  <tei:body>
   <xsl:apply-templates />
  </tei:body>
 </xsl:template>
 
 <xsl:template match="/*/*[text[@smlallCaps='true']]">
  <tei:head>
   <xsl:apply-templates />
  </tei:head>
 </xsl:template>
 
 <xsl:template match="Normální[not(node())]" priority="3" />

 <xsl:template match="Normální[.//text()[normalize-space() != ''][1][matches(fn:normalize-space(), $speaker-regex)]]" priority="3">
  <tei:speaker>
   <xsl:apply-templates />
  </tei:speaker>
 </xsl:template>

 <xsl:template match="Normální[@jc-val='center']" priority="2">
  <tei:head>
   <xsl:if test="fn:matches(fn:normalize-space(.), $scena-regex)">
    <xsl:variable name="analysis" select="analyze-string(., $scena-regex)/*/fn:group"/>
    <xsl:attribute name="type" select="$analysis[1] => replace('IIII', 'IV') " />
    <xsl:attribute name="subtype" select="$analysis[2]" />
   </xsl:if>
   <xsl:apply-templates />
  </tei:head>  
 </xsl:template>
 
 <xsl:template match="Normální[text[@italic]]" priority="2">
  <tei:argument>
   <tei:p><xsl:apply-templates /></tei:p>
  </tei:argument>
 </xsl:template>
 

 <xsl:template match="Normální[not(.//tab)]">
  <tei:p>
   <xsl:apply-templates />
  </tei:p>
 </xsl:template>
 
 <xsl:template match="Normální[text/tab]">
  <tei:l>
   <xsl:call-template name="get-indentation"/>
   <xsl:apply-templates />
  </tei:l>
 </xsl:template>
 
 <xsl:template name="get-indentation">
  <xsl:variable name="root" select="text[not(@* except @xml:*)][1]/text()[matches(., '^\p{L}+')][1]"/>
  <xsl:variable name="tabs-only" select="text[not(@* except @xml:*)][1][tab and not(normalize-space() != '')]"/>
  <xsl:variable name="tabs" select="if(exists($root)) then $root/count(preceding-sibling::tab) else $tabs-only/count(tab)"/>
  <xsl:variable name="indent" select="
    if ($tabs = 0) then
     ()
    else
     if ($tabs = 1) then
      'indent'
     else
      concat('indent-', $tabs)"/>
  <xsl:if test="$indent">
   <xsl:attribute name="rend" select="$indent"/>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="Normální[@jc-val='right']" priority="2">
  <xsl:variable name="tabs" select="count(text[1]/tab)"/>
  <tei:p rend="right">
   <xsl:apply-templates />
  </tei:p>
 </xsl:template>
 
 <xsl:template match="Normální[text[1]/node()[1][self::text()][matches(normalize-space(.), '^\d+$')]]" priority="3">
  <xsl:variable name="number" select="text[1]/node()[1][self::text()][matches(normalize-space(.), '^\d+$')]"/>
  <tei:l n="{$number}">
   <xsl:apply-templates />
  </tei:l>
 </xsl:template>
 
 <xsl:template match="Normální/text[1]/node()[1][self::text()][matches(normalize-space(.), '^\d+$')]" />
 
 <xsl:template match="footnote-reference">
  <xsl:variable name="id" select="*/@id"/>
  <xsl:variable name="note" select="key('footnote', $id)"/>
  <xsl:apply-templates select="$note" mode="realization" />
 </xsl:template>
 
 <xsl:template match="footnote" />
 <xsl:template match="footnote" mode="realization">
  <tei:note xml:id="{$text-id}.{$note-prefix}.{format-number(@id, $id-format)}" n="{@id}">
   <xsl:apply-templates />
  </tei:note>
 </xsl:template>
 <xsl:template match="footnote/footnote-reference" />
 <xsl:template match="footnote-text">
  <tei:p>
   <xsl:apply-templates />
  </tei:p>
 </xsl:template>
 
 <xsl:template match="footnote[@tei-data='app']" mode="realization">
  <tei:app>
    <xsl:apply-templates mode="#current" />
   <xsl:apply-templates select="footnote-text/text[@tei-data='note']" mode="app-note" />
  </tei:app>
  
 </xsl:template>
 
 <xsl:template match="text[@tei-data='lem']" mode="realization">
  <xsl:variable name="witness" select="following-sibling::*[1][self::text[@tei-data = 'wit']]"/>
  <tei:lem><xsl:if test="$witness"><xsl:attribute name="wit" select="'#' || $witness" /></xsl:if>
   <xsl:value-of select="fn:normalize-space()" /></tei:lem>
 </xsl:template>
 
 <xsl:template match="text[@tei-data='rdg']" mode="realization">
  <xsl:variable name="witness" select="following-sibling::*[1][self::text[@tei-data = 'wit']]"/>
  <tei:rdg><xsl:if test="$witness"><xsl:attribute name="wit" select="'#' || $witness" /></xsl:if>
   <xsl:value-of select="fn:normalize-space()" /></tei:rdg>
 </xsl:template>
 
 <xsl:template match="text[@tei-data=('note','pc', 'wit')]" mode="realization" />
 
 <xsl:template match="text[@tei-data='note']" mode="app-note">
  <tei:note><xsl:apply-templates /></tei:note>
 </xsl:template>
 
 

 <xsl:template match="footnote[contains(., ']')][not(contains(., '['))]" mode="realization" use-when="false()">
  <xsl:variable name="text" select="footnote-text/text[contains(., ']')][not(contains(., '['))][1] 
   => normalize-space() => tokenize('\]')"/>
  <xsl:variable name="lemma" select="normalize-space($text[1])"/>
  <xsl:variable name="reading" select="normalize-space($text[2])"/>
  <xsl:variable name="note" select="footnote-text/text[@italic]/following-sibling::* => normalize-space()"  />
  <xsl:variable name="witness" select="footnote-text/text[@italic] => normalize-space() => translate('.', '')" />
  <xsl:variable name="id" select="@id"/>
  <tei:app>
   <tei:lem><xsl:value-of select="$lemma"/></tei:lem>
   <tei:rdg wit="#{$witness}"><xsl:value-of select="$reading"/></tei:rdg>
  </tei:app>
  <xsl:choose>
   <xsl:when test="$note = ('', '.')">
   </xsl:when>
   <xsl:when test="starts-with($note, '. ')">
    <tei:note xml:id="{$text-id}.{$note-prefix}.{format-number($id, $id-format)}"><xsl:value-of select="substring-after($note, '. ')"/></tei:note>
   </xsl:when>
   <xsl:otherwise>
    <tei:note xml:id="{$text-id}.{$note-prefix}.{format-number($id, $id-format)}"><xsl:value-of select="$note"/></tei:note>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="text[@bold][matches(normalize-space(), $sigla-regex)]" priority="2">
  <tei:pb n="{analyze-string(normalize-space(), $sigla-regex)/fn:match/fn:group[1]}" />
 </xsl:template>
 
  <xsl:template match="tab">
   <tei:space unit="tab" />
  </xsl:template>
 
  <xsl:template match="text">
   <xsl:apply-templates />
  </xsl:template>
 
 <xsl:template match="text[@bold|@italic|@underline|@strike][@xml:space][fn:normalize-space() = '']" priority="2">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="text[@bold|@italic|@underline|@strike]">
  <tei:hi rendition="{for $i in (@bold|@italic|@underline|@strike) return name($i)}">
   <xsl:apply-templates />
  </tei:hi>
 </xsl:template>
 
 <xsl:template match="comment-range[@type='start']">
  <tei:anchor xml:id="{$text-id}.{$comment-prefix}.{format-number(@id, $id-format)}.start" type="delimiter" subtype="quote-start" n="{@id}" />
 </xsl:template>
 
 <xsl:template match="comment-range[@type='end']">
  <xsl:apply-templates select="key('comment', @id)" mode="realization" />
 </xsl:template>
 
 <xsl:template match="comment" />
 
 <xsl:template match="comment" mode="realization">
  <tei:app xml:id="{$text-id}.{$comment-prefix}.{format-number(@id, $id-format)}" from="#{$text-id}.{$comment-prefix}.{format-number(@id, $id-format)}.start" n="{@id}">
   <tei:note><xsl:apply-templates /></tei:note>
  </tei:app>
 </xsl:template>
 
 <xsl:template match="annotation-text[1]">
  <tei:p><xsl:apply-templates /></tei:p>
 </xsl:template>
 <xsl:template match="annotation-text[2]">
  <tei:p><xsl:apply-templates /></tei:p>
 </xsl:template>
 <xsl:template match="annotation-text[position() gt 2][starts-with(normalize-space(.), 'http')]">
  <xsl:variable name="text" select="fn:normalize-space()"/>
  <xsl:variable name="html" select="if(ends-with($text, '.')) then fn:substring($text, 1, fn:string-length($text) - 1) else $text"/>
  <tei:p><tei:ref target="{$html}"><xsl:value-of select="$html"/></tei:ref></tei:p>
 </xsl:template>
 
 <xsl:template match="annotation-text[position() gt 2][not(starts-with(normalize-space(.), 'http'))]" priority="2">
  <tei:p><xsl:apply-templates /></tei:p>
 </xsl:template>
 
 <xsl:template match="annotation-reference" />
 
 <xsl:template match="hyperlink | Hyperlink">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="foreign">
  <tei:foreign><xsl:copy-of select="@xml:space" /><xsl:apply-templates /></tei:foreign>
 </xsl:template>
 
</xsl:stylesheet>