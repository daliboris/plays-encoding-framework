<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Feb 2, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-skip"/>
 <xsl:output method="html" indent="yes" />
 
 <xsl:template match="/">
  <html>
   <head>
    <title>Theatrum neolatinum</title>
    <style type="text/css">
     .container {display : flex; gap: 1em; justify-content: center; }
     .overview {  }
     .level:before {content: "["}
     .level:after {content: "] "}
     .level { font-size: 1em; }
     small:before {content: " ("}
     small:after {content: ")"}
     small { font-weight: normal;}
     
     table {
     table-layout: fixed;
     border-collapse: collapse;
     border: 3px solid black;
     }
     th,
     td {
     border: 1px solid black;
     padding: 0.5em;
     }
     thead tr:first-child {
     border: 2px solid black;
     }
     tbody tr th {
     border-right: 2px solid black;
     }
     
    </style>
   </head>
   <body>
    <div class="container">
     <xsl:apply-templates select="/tei:teiCorpus/tei:TEI/tei:text[@n=('Text edice')]/tei:body" /> 
     <xsl:apply-templates select="/tei:teiCorpus/tei:TEI/tei:text[@n=('Překlad')]/tei:body" /> 
    </div>
   </body>
  </html>
 </xsl:template>
 
 <xsl:template match="tei:body">
  <div class="overview">
   <h1><xsl:value-of select="parent::tei:text/@n"/></h1>
   <table>
    <thead>
     <tr>
      <th rowspan="2">Hierarchie</th>
      <th rowspan="2">Název</th>
      <th rowspan="2">Typ</th>
      <th rowspan="2">Podtyp</th>
      <th rowspan="2">Označení (@n)</th>
      <th colspan="2">Počet</th>
      <th rowspan="2">Verše</th>
      <th rowspan="2">Postavy</th>
     </tr>
     <tr>
      <th>řádků</th>
      <th>veršů</th>
     </tr>
    </thead>
    <tbody>
      <xsl:apply-templates select="tei:div" />  
    </tbody>
   </table>
   
   <hr />
  </div>
 </xsl:template>
 
<!-- <xsl:template match="tei:div[not(@n)]">
    <h2>
     <span class="level"><xsl:number from="tei:body" count="tei:div" level="multiple" /></span>
     <xsl:apply-templates select="tei:head" mode="content" />
     <small><xsl:apply-templates select="@* except @n" mode="content" /></small>
    </h2>
 </xsl:template>-->
 
 <xsl:template match="tei:div">
  <xsl:variable name="heading-level"><xsl:number from="tei:body" count="tei:div" level="single" /></xsl:variable>
  <xsl:variable name="name" select="concat('h', $heading-level)"/>
  <xsl:variable name="verse" select=".//tei:l"/>
  <tr>
   <td><xsl:number from="tei:body" count="tei:div" level="multiple" /></td>
   <td><strong><xsl:apply-templates select="tei:head" mode="content" /></strong></td>
   
   <td><xsl:value-of select="@type"/></td>
   <td><xsl:value-of select="@subtype"/></td>
   <td><xsl:value-of select="@n"/></td>
   
   <td><xsl:value-of select="count($verse)"/></td>
   <td><xsl:value-of select="count(distinct-values($verse/@n))"/></td>
   <td><xsl:value-of select="concat($verse[1]/@n, '–', $verse[last()]/@n)"/></td>
   <td><xsl:value-of select=".//tei:sp/id(tokenize(@who, '\s|#')[. != ''])/tei:persName[@xml:lang='la'] => string-join(', ')"/></td>
  </tr>
  <!-- 
    <xsl:element name="{$name}">
     <span class="level"><xsl:number from="tei:body" count="tei:div" level="multiple" /></span>
     <xsl:apply-templates select="tei:head" mode="content" />
      <small><xsl:apply-templates select="@* except @level" mode="content" /></small>
     <small>
      
      
      <xsl:if test="$verse">
       počet řádků: <xsl:value-of select="count($verse)"/>;
       počet veršů: <xsl:value-of select="count(distinct-values($verse/@n))"/>;
       <xsl:value-of select="concat($verse[1]/@n, '–', $verse[last()]/@n)"/>
      </xsl:if>
     </small>
    </xsl:element>
   -->
   <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="@*" mode="content">
  <xsl:value-of select="concat(name(), ': ', .)"/>
  <xsl:if test="position() != last()">; </xsl:if>
 </xsl:template>
 
 <xsl:template match="tei:div[not(@level)]" mode="collapsible">
  <details>
   <summary>
    <h3><xsl:apply-templates select="tei:head" mode="content" /></h3>
   </summary>
  </details>
 </xsl:template>
 
 <xsl:template match="tei:div[@level]"  mode="collapsible">
  <xsl:variable name="name" select="concat('h', @level - 1)"/>
  <details>
   <summary>
    <xsl:element name="{$name}">
     <xsl:apply-templates select="tei:head" mode="content" />
    </xsl:element>
   </summary>
   <xsl:apply-templates />
  </details>
 </xsl:template>
 
 <xsl:template match="tei:head" mode="content">
  <xsl:value-of select="normalize-space(string-join(text() |  (* except tei:note)/text(), ' '))" />
 </xsl:template>
 
</xsl:stylesheet>