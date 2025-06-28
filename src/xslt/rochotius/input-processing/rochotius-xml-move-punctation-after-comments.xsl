<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 5, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 
 <!--
  <text sz-val="24">
         <tab/>Nili ministrum praevium ad arva fertilis</text>
      <comment-range type="end"
                     id="16"/>
      <text sz-val="24">,</text>
      
       <text sz-val="24">
         <tab/>Sequimini comites in proximum me hac locum</text>
      <comment-range type="end"
                     id="34"/>
      <text sz-val="24">.</text>
      
 -->
 
 
 <xsl:template match=" text[following-sibling::*[1][self::comment-range]] 
  [following-sibling::*[2][self::text[.= (',', '.')]]]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:value-of select="following-sibling::*[2][self::text[.= (',', '.')]]"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="text[.= (',', '.')][preceding-sibling::*[1][self::comment-range]] 
  [preceding-sibling::*[2][self::text]]" />
 
</xsl:stylesheet>