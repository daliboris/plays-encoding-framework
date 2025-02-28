<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xdf="https://www.daliboris.cz/ns/xslt/drama/functions"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei xdf"
 version="3.0">
 
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Feb 2, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:key name="note" match="tei:div[@type='notes']/tei:note" use="tei:hi[1]" />
 
 <xsl:variable name="lines" select="//tei:div[@type='notes']/tei:note/tei:hi"/>
 
 <xsl:variable name="id-format" select="'000000'"/>

 
 <xsl:template match="tei:l[@n = $lines] | tei:speaker[following-sibling::tei:l[1][@n = $lines]]">
  <xsl:variable name="n" select="head(@n | following-sibling::tei:l[1]/@n)"/>
  <xsl:variable name="note" select="key('note', $n)"/>
  <xsl:variable name="text" select="$note/substring-before(text()[normalize-space() != ''][1], ']') => normalize-space()"/>
  <xsl:choose>
   <xsl:when test="matches(., concat('', $text, ''))">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:iterate select="node()">
      <xsl:choose>
       <xsl:when test="self::text()[matches(., $text)]">
        <xsl:analyze-string select="." regex="{$text}">
         <xsl:matching-substring>
          <tei:anchor xml:id="{concat('note.', format-number($n, $id-format))}" />
           <xsl:value-of select="."/>
          <xsl:apply-templates select="$note" mode="note">
           <xsl:with-param name="n" select="$n" />
          </xsl:apply-templates>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
          <xsl:value-of select="."/>
         </xsl:non-matching-substring>
        </xsl:analyze-string>
       </xsl:when>
       <xsl:otherwise>
        <xsl:copy-of select="." />
       </xsl:otherwise>
      </xsl:choose>
     </xsl:iterate>
    </xsl:copy>
   </xsl:when>
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="tei:div[@type='notes']/tei:note" mode="note">
  <xsl:param name="n" />
  <tei:app from="{concat('#note.', $n)}">
   <xsl:copy-of select="." />   
  </tei:app>
  
 </xsl:template>
 
 <xsl:template match="tei:div[@type='notes']" />
 
</xsl:stylesheet>