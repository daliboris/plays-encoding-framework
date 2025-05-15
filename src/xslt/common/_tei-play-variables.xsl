<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map" 
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 
 <xsl:param name="project-suffix" select="'tnl'"/>
 
 <xsl:variable name="play-title" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]" />
  <xsl:variable name="play-witness" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[1]/@xml:id" />
 
 <!--
   <title>Josephiados comoedia</title>
   => jc
   <title>Angelus ad aras D. Joannes Nepomucenus</title>
   => aa
 -->
 
 <xsl:variable name="name-suffix" select="$play-title/translate(., '[]', '')
  ! tokenize(normalize-space()) 
  ! substring(., 1, 1) 
  ! lower-case(.) 
  => string-join()
  => substring(1, 2)" use-when="false()"/>
  <xsl:variable name="name-suffix" select="$play-witness => translate('-', '') => lower-case()"/>
 <xsl:variable name="full-suffix" select="concat('-',  $name-suffix, '-', $project-suffix)"/>
 
 
 
</xsl:stylesheet>