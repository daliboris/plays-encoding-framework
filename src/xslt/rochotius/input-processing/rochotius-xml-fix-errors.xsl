<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 xmlns:xf="https://www.daliboris.cz/ns/xslt/functions"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd xf map"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 10, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:character-map name="normalization">
  <xsl:output-character character="&#xa0;" string=" "/>
 </xsl:character-map>
 
 <xsl:output use-character-maps="normalization"/>
 
 <xsl:mode on-no-match="shallow-copy"/>
<!-- <xsl:variable name="text-errors-regex" select="'[˂]'"/> <!-\- │ -\->
 <xsl:variable name="dot-v-digit-regex" select="'\.(\s[vp]\.\s\d)'"/>
 <xsl:variable name="dot-v-digit-replace" select="',$1'"/>
 <xsl:variable name="s-instead-of-p-regex" select="'\d,\s+s\.\s\d'"/>
 <xsl:variable name="s-instead-of-p-replace" select="', p. ' "/>
 <xsl:variable name="s-without-dot-regex" select="'(\d,\s)(s)(\s\d)'"/>
 <xsl:variable name="s-without-dot-replace" select="'$1p.$3'"/>
 <xsl:variable name="comma-without-space-regex" select="'(\p{Ll})(,)(\p{Ll})'"/>
 <xsl:variable name="comma-without-space-replace" select="'$1$2 $3'"/>
 <xsl:variable name="v-without-space-regex" select="'(v)(\.)(\d)'"/>
 <xsl:variable name="v-without-space-replace" select="'$1$2 $3'"/>
 <xsl:variable name="pv-with-dash-regex" select="'([pv])(-)(\s\d)'"/>
 <xsl:variable name="pv-with-dash-replace" select="'$1.$3'"/>
 <xsl:variable name="ps-dash" select="'\s[ps]-'"/>
 <xsl:variable name="signatura-without-dot" select="'B3r'"/>-->
 
 <!--<xsl:variable name="replacements" select="map {
  'Hilegardis' : 'Hildegardis',
  'Namaan' : 'Naaman',
  'Adelphoi' : 'Adelphoe',
  'Heauton timorumenos' : 'Heautontimorumenos',
  'Frischlin Hildegardis' : 'Frischlin, Hildegardis',
  'Frischiln' : 'Frischlin'
  }"/>-->
 <xsl:variable name="replacements" select="map {
  '│' : '|',
  '˂' : '&lt;',
  '˃' : '&gt;',
  ':\.' : ':',
  '\s+:' : ':',
  '(\d)\s(\.)' : '$1$2 ',
  'https:\s//' : 'https://', 
  '\[\.\.\.?\]' : '[…]',
  (:'(\d),(\s+s\.)(\s\d)' : '$1, p.$3',:)
  '\s\s+' : ' ',
  '(\d)\.\.' : '$1.',
  '\.(\s[vp]\.\s\d)' : ',$1',
  '\sv,\s' : ' v. ',
  '(\d,)(\s+s\.?\s+)(\d)' : '$1 p. $3',
  '(\p{Ll})(,)(\p{Ll})' : '$1$2 $3',
  '(v)(\.)(\d)' : '$1$2 $3',
  '([pv])(-)(\s\d)' : '$1.$3',
  'Hilegardis' : 'Hildegardis',
  'Namaan' : 'Naaman',
  'Adelphoi' : 'Adelphoe',
  'Heauton timorumenos' : 'Heautontimorumenos',
  'Frischlin Hildegardis' : 'Frischlin, Hildegardis',
  'Frischiln' : 'Frischlin',
  'Frischlin,\sHildegardis,\sv\.\s548,\sp\.\s86' : 'Frischlin, Hildegardis, v. 548, p. 86.',
  'Frischlin,\sHildegardis,\sv\.\s329,\sp\.\s58' : 'Frischlin, Hildegardis, v. 329, p. 58.',
  'Buchanan,\sBaptistes,\sv\.\s757–9,\sp\.\s168' : 'Buchanan, Baptistes, v. 757–9, p. 168.',
  '(Baptistes)(\.)(\sv\.)' : '$1,$3',
  '(,\s)(873–5)' : '$1v. $2',
  '\s[ps]-' : ' p.',
  'Hildegardis,\sB3r' : 'Hildegardis, B3r.',
  '\s-\s' : ' – '
  }"/>
 <xsl:variable name="replacement-regex" select="string-join(map:keys($replacements), '|')"/> 
 
 <!-- Frischiln, Susanna, v. 425. s- 174. >> v. 425, p. 174. -->
 <!-- Frischlin, Hildegardis, B3r >> B3r. -->
 
 <xsl:template match="Strong">
   <text bold="true"><xsl:apply-templates /></text>
 </xsl:template>
 
<!-- <xsl:template match="text()[. = 'https: //mateo.uni-mannheim.de/camena/frisc6/jpg/s147.html']">
  <xsl:value-of select="translate(., ' ', '')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="text()[contains(.,$text-errors-regex)]">
  <xsl:value-of select="translate(., '│˂', '|&lt;')"/>
 </xsl:template>-->
 
 <!--<xsl:template match="text()[contains(., '[...]')]" priority="2">
  <xsl:value-of select="replace(., '\[\.\.\.\]', '[…]')"/>
 </xsl:template>

 <xsl:template match="text()[contains(., '[..]')]" priority="2">
  <xsl:value-of select="replace(., '\[\.\.\.\]', '[…]')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="text()[matches(., '\d\.\.')]" priority="3">
  <xsl:value-of select="replace(., '\.\.', '.')  => replace($dot-v-digit-regex, $dot-v-digit-replace)"/>
 </xsl:template>-->
 
<!-- <xsl:template match="text()[matches(., '\sv,\s')]" priority="3">
  <xsl:value-of select="replace(., '\sv,\s', ' v. ')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[contains(., '  ')]" priority="3">
  <xsl:value-of select="replace(., '\s+', ' ')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[matches(., $dot-v-digit-regex)]">
  <xsl:value-of select="replace(., $dot-v-digit-regex, $dot-v-digit-replace)"/>
 </xsl:template>
 
 <xsl:template match="*[not(*)]/text()[matches(., $s-without-dot-regex)]">
  <xsl:value-of select="replace(., $s-without-dot-regex, $s-without-dot-replace)"/>
 </xsl:template>
 
 <xsl:template match="*[not(*)]/text()[matches(., $comma-without-space-regex)]">
  <xsl:value-of select="replace(., $comma-without-space-regex, $comma-without-space-replace)"/>
 </xsl:template>
 
 <xsl:template match="*[not(*)]/text()[matches(., $v-without-space-regex)]">
  <xsl:value-of select="replace(., $v-without-space-regex, $v-without-space-replace)"/>
 </xsl:template>
 
 <xsl:template match="*[not(*)]/text()[matches(., $pv-with-dash-regex)]">
  <xsl:value-of select="replace(., $pv-with-dash-regex, $pv-with-dash-replace)"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[. = ('Frischlin, Hildegardis, v. 548, p. 86', 
                                            'Frischlin, Hildegardis, v. 329, p. 58',
                                            'Buchanan, Baptistes, v. 757–9, p. 168') ]">
  <xsl:value-of select="concat(., '.')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[matches(., 'Baptistes\.\sv\.')]">
  <xsl:value-of select="replace(., '(Baptistes)(\.)(\sv\.)', '$1,$3')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[matches(., ', 873–5')]">
  <xsl:value-of select="replace(., '(,\s)(873–5)', '$1v. $2')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[matches(., 'Frischlin Hildegardis')]">
  <xsl:value-of select="replace(., 'Frischlin Hildegardis', 'Frischlin, Hildegardis')"/>
 </xsl:template>
 
 <xsl:template match="*[not(*)]/text()[matches(., 'Frischiln')]">
  <xsl:value-of select="replace(., 'Frischiln', 'Frischlin')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[matches(., $s-instead-of-p-regex)]" priority="4">
  <xsl:value-of select="replace(., ',\s+s\.\s', $s-instead-of-p-replace)"/>
 </xsl:template>-->
<!--
 <xsl:template match="*[not(*)]/text()[contains(., $ps-dash)]">
  <xsl:value-of select="replace(., $ps-dash, ' p.')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[ends-with(., $signatura-without-dot)]">
  <xsl:value-of select="replace(., $signatura-without-dot, $signatura-without-dot || '.')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[contains(., ' - ')]">
  <xsl:value-of select="replace(., ' - ', ' – ')"/>
 </xsl:template>-->
 
<!-- <xsl:template match="*[not(*)]/text()[for-each(map:keys($replacements), contains(.,?))]">
  <xsl:value-of select="xf:replace-items(., $replacements)"/>
 </xsl:template>-->

 <!--<xsl:template match="*[not(*)][matches(., $replacement-regex)]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:value-of select="xf:replace-items(., $replacements)"/>
  </xsl:copy>
 </xsl:template>-->
 <xsl:template match="text()[matches(., $replacement-regex)]">
  <xsl:value-of select="xf:replace-items(., $replacements)"/>
 </xsl:template>
 

<!-- <xsl:template match="*[not(*)]/text()[matches(., $replacement-regex)]">
  <xsl:value-of select="xf:replace-items(., $replacements)"/>
 </xsl:template>
--> 
 <!--<xsl:template match="text()[matches(., $replacement-regex)]">
  <xsl:value-of select="xf:replace-items(., $replacements)"/>
 </xsl:template>-->
 
 <xsl:function name="xf:replace-items">
  <xsl:param name="text" as="xs:string"/>
  <xsl:param name="replacements" as="map(xs:string, xs:string)"/>
  <xsl:value-of select="fold-left(map:keys($replacements), $text, function($text, $next) {
   replace($text, $next, $replacements($next))
   })"/>
 </xsl:function>
 
 <xsl:template match="comment/annotation-text[row/cell/Normální]">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="annotation-text/row | annotation-text/row/cell">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="comment/annotation-text/row/cell/Normální">
  <annotation-text><xsl:apply-templates /></annotation-text>
 </xsl:template>
 
 <xsl:template match="annotation-text[not(node())]" />
 
 <xsl:template match="footnote/heading-1">
  <footnote-text><xsl:apply-templates /></footnote-text>
 </xsl:template>
 
 <xsl:template match="footnote-text/mw-page-title-main | footnote-text/grek">
  <foreign><xsl:copy-of select="@*" /><xsl:apply-templates /></foreign>
 </xsl:template>
 
 <xsl:template match="footnote-text/text[@sz-val='24']">
  <xsl:copy>
   <xsl:copy-of select="@* except @sz-val" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 
 <!-- TODO: split speaker and speech on the same line -->
 
 <xd:doc>
  <xd:desc> Paragraphs with no text (empty or with single dot)  </xd:desc>
 </xd:doc>
 <xsl:template match="Normální[not(matches(normalize-space(.), '\w'))] | Normální[not(node())]" />

 <xsl:template match="Normální[@jc-val = 'center'][contains(normalize-space(), 'Prius modo militum tribunis et lorariis aliquid edicam')]">
  <xsl:copy>
   <xsl:copy-of select="@* except @jc-val" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text/@sz-val" />

</xsl:stylesheet>