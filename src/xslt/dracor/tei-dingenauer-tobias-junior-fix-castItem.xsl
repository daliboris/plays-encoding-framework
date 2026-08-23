<?xml version="1.0" encoding="UTF-8"?>
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
   <xd:p><xd:b>Created on:</xd:b> 2026-07-31</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 
 <xsl:mode name="make-group" on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:variable name="amici-group" select="('Hor.:', 'Sem.:', 'Ebul.:', 'Edom.:', 'Enos.:', 'Gebal.:', 'Onum.:', 'Raguel:', 'Gabelus:', 'Aristus:', 'Dorio:', 'Sannio:', 'Choragus:', 'Saphat:')"/>
 <xsl:variable name="foeminae-group" select="('Anna,', 'Sara:')"/>
 
 <xsl:template match="tei:role[. = ('Alectrica', 'Sagana')]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:value-of select=". || ','"/>
  </xsl:copy>
 </xsl:template>
 <xsl:template match="tei:roleDesc[. = (', Dina:', ', Credulitas:')]" mode="#all">
  <role><xsl:value-of select="substring-after(., ' ')"/></role>
 </xsl:template>
 
 
 <xsl:template match="tei:castGroup[tei:roleDesc = ('Amici', 'Foeminae')]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
   <xsl:choose>
    <xsl:when test="tei:roleDesc[ . = 'Amici']">
     <xsl:apply-templates select="following-sibling::tei:castItem[tei:role = $amici-group]" mode="make-group" />
    </xsl:when>
    <xsl:when test="tei:roleDesc[ . = 'Foeminae']">
     <xsl:apply-templates select="following-sibling::tei:castItem[tei:role = $foeminae-group]" mode="make-group" />
    </xsl:when>
   </xsl:choose>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:castItem[tei:role = $amici-group]" />
 <xsl:template match="tei:castItem[tei:role = $foeminae-group]" />
 
</xsl:stylesheet>