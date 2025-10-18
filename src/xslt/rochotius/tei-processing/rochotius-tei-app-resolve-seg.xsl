<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 19, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:seg[@type=('allusion', 'paraphrase')] | tei:quote">
  <tei:quote>
   <xsl:copy-of select="@*" />
   <xsl:if test="preceding-sibling::*[1][self::tei:milestone]">
    <xsl:variable name="milestone" select="preceding-sibling::*[1]"/>
    <xsl:attribute name="subtype" select="if($milestone = '|') then 'equal' else if ($milestone = '&lt;') then 'predecessor' else 'unknown'">
    </xsl:attribute>
   </xsl:if>
   <xsl:if test="following-sibling::*[2][self::tei:milestone]">
    <xsl:variable name="milestone" select="following-sibling::*[2]"/>
    <xsl:attribute name="subtype" select="if($milestone = '|') then 'equal' else if ($milestone = '&lt;') then 'successor' else 'unknown'">
    </xsl:attribute>
   </xsl:if>
   <xsl:apply-templates />
  </tei:quote>
 </xsl:template>
 
 <!-- Te advenire, cedo tuam mihi dexteram. Ubi sunt spes meae
  3 citáty < <
 -->
 
 
 <xsl:template match="tei:milestone" use-when="false()" />
 
</xsl:stylesheet>