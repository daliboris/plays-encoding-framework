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
   <xd:p><xd:b>Created on:</xd:b> Apr 13, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xd:doc>
  <xd:desc>Pro text Kolčava (převod z DOCX)</xd:desc>
 </xd:doc>
 <xsl:template match="tei:speaker/tei:space" />
 
 <xsl:template match="tei:l/tei:space[@dim='horizontal'][@quantity=(1,2)]" />
 
 <xsl:template match="tei:p[tei:space[@dim='horizontal'][@quantity=(1,2)]]" />
 
 <xsl:template match="tei:l/tei:space[@dim='horizontal'][@quantity > 2]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="quantity" select="@quantity - 2" />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>