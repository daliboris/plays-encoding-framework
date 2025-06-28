<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 xmlns:xf="https://www.daliboris.cz/ns/xslt/functions"
 exclude-result-prefixes="xs math xd map"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 5, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
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
  '\s-\s' : ' – ',
  '(\w+)([,!])(\w+)' : '$1 $2$3'
  }"/>
 <xsl:variable name="replacement-regex" select="string-join(map:keys($replacements), '|')"/>
 
 
</xsl:stylesheet>