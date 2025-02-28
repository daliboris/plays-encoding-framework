<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xdf="https://www.daliboris.cz/ns/xslt/drama/functions"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei xdf"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jan 29, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="data-file-path" as="xs:string" required="yes" />
 
 <xsl:param name="line-numbers" select="doc($data-file-path)"/>
 <xsl:key name="line" match="line" use="@position" />
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="lang" select="//tei:TEI/@xml:lang"/>
 
 <!--<xsl:template match="tei:l[@n]">
  <xsl:copy-of select="." />
 </xsl:template>-->
 
 <xsl:template match="tei:l"> <!-- [not(@n)] -->
  <xsl:variable name="position">
   <xsl:number from="tei:text" level="any" />
  </xsl:variable>
  <xsl:variable name="line" select="key('line', $position, $line-numbers)[1]"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="n" select="$line/@n"/>
   <xsl:call-template name="add-part-attribute">
    <xsl:with-param name="line" select="$line" />
   </xsl:call-template>
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template name="add-part-attribute">
  <xsl:param name="line" as="element(line)"/>
  <xsl:choose>
   <xsl:when test="$line/@indent != '0' and ends-with($line/@indent, '0')">
    <xsl:choose>
     <xsl:when test="$line/@n = $line/following-sibling::line[1]/@n">
      <xsl:attribute name="part" select="'M'" />
     </xsl:when>
     <xsl:otherwise>
      <xsl:attribute name="part" select="'F'" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:when test="$line/@n = $line/following-sibling::line[1]/@n">
    <xsl:attribute name="part" select="'I'" />
   </xsl:when>
  </xsl:choose>
 </xsl:template>
 
 
 
 <xsl:function name="xdf:correct-line-number">
  <xsl:param name="number" as="xs:string" />
  <xsl:param name="l" as="element(tei:l)" />
  <xsl:variable name="lang" select="$l/ancestor::tei:TEI[1]/@xml:lang"/>
  <xsl:choose>
   <xsl:when test="$number = '272 × 1'">
    <xsl:value-of select="'001'"/>
   </xsl:when>
   <xsl:when test="$number = '272 × 2'">
    <xsl:value-of select="'001'"/>
   </xsl:when>
   <xsl:when test="$number = '273 × 3'">
    <xsl:value-of select="'002'"/>
   </xsl:when>
   <xsl:when test="$number = '274 × 4'">
    <xsl:value-of select="'003'"/>
   </xsl:when>
   <xsl:when test="$number = '365 × 7'">
    <xsl:value-of select="'364'"/>
   </xsl:when>
   <xsl:when test="$number = '365 × 8'">
    <xsl:value-of select="'364'"/>
   </xsl:when>

   <xsl:when test="$number = '582' and $lang = 'cs'">   
    <xsl:value-of select="'581'"/>
   </xsl:when>

   <xsl:when test="$number = '583' and $lang = 'cs'">   
    <xsl:value-of select="'582'"/>
   </xsl:when>

   <xsl:when test="$number = '584' and $lang = 'cs'">   
    <xsl:value-of select="'583'"/>
   </xsl:when>

   <xsl:when test="$number = '585 × 5' and $lang = 'cs'">   
    <xsl:value-of select="'584'"/>
   </xsl:when>
   

   <xsl:when test="$number = '664'">
    <xsl:variable name="prev-l" select="$l/preceding::tei:l[@n][1]"/>
    <xsl:variable name="between" select="$l/preceding::tei:l[not($l/preceding::tei:l[@n][1] >> $l)]"/>
    <xsl:value-of select="format-number(count($between) + 1, '000')"/>
   </xsl:when>

   <xsl:when test="$number = '665 × 8'">
    <xsl:value-of select="'664'"/>
   </xsl:when>

   <xsl:when test="$number = '733' and $lang = 'cs'">   
    <xsl:value-of select="'732'"/>
   </xsl:when>

   <xsl:when test="$number = '734' and $lang = 'cs'">
    <xsl:value-of select="'733'"/>
   </xsl:when>

   <xsl:when test="$number = '735 × 5' and $lang = 'cs'">
    <xsl:value-of select="'734'"/>
   </xsl:when>
   
   <xsl:otherwise>
    <xsl:value-of select="$number"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function>
 
</xsl:stylesheet>