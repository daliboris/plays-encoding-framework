<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Sep 22, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" /> 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:docTitle/tei:p[tei:pb]" />
 
 <xsl:template match="tei:docTitle/tei:titlePart[preceding-sibling::*[1][self::tei:p[tei:pb]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="preceding-sibling::tei:p/tei:pb" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l/tei:speaker" />
 
 <xsl:template match="tei:l[tei:speaker]">
  <tei:sp>
   <xsl:copy-of select="tei:speaker" />
   <xsl:copy>
    <xsl:copy-of select="@*" />
    <xsl:apply-templates />
   </xsl:copy>
  </tei:sp>
 </xsl:template>
 
 <xsl:template match="@style">
  <xsl:attribute name="{name()}">
   <xsl:value-of select="normalize-space(.)"/> 
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="tei:p[preceding-sibling::*[1][self::tei:head]][not(ancestor::tei:div[@type=('contents', 'list-of-persons')])]">
  <tei:argument>
   <xsl:copy-of select="." />
  </tei:argument>
 </xsl:template>
 
 <xsl:template match="tei:div[last()]/tei:l[last()][. = ('O. A. M. D. G. et H. S. J. N.', 'Vše k větší slávě Boží a poctě sv. Jana Nepomuckého')] | 
  tei:div[last()]/tei:p[last()][. = ('A. M. D. G. et S. J. N. H.', 'Vše k větší slávě Boží a poctě sv. Jana Nepomuckého')]">
  <tei:trailer>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </tei:trailer>
 </xsl:template>
 
</xsl:stylesheet>