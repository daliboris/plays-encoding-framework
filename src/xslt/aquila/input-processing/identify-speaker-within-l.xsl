<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:tnf="https://www.daliboris.cz/ns/theatrum-neolatinum/xslt"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="#all"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2026-06-28</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:import href="../../common/_tei-common-functions.xsl"/>
 
 <xsl:param name="persons" as="element()*" required="no" />
 
 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="all-person-names" select="$persons/tei:persName"/>
 <xsl:variable name="all-person-names-sorted" select="tnf:sort-elements-by-string-length($all-person-names)"/>
 <xsl:variable name="person-names" select="string-join($all-person-names-sorted ! replace(., ' ', '\\s') ! replace(., '\.', '\\.'), '|')"/>
 <xsl:variable name="person-regex" select="'^(' || $person-names || '|\p{Lu}\w+)(?:[,\.]?)'"/>
 
 <xsl:variable name="speaker-name-regex" select="'\p{Lu}[\p{Ll}\[\]]+((\.|\s+\d|\s+\p{Lu}[\p{Ll}\[\]]+))?:'" use-when="false()"/>
 <xsl:variable name="speaker-name-regex" select="'(' || $person-names || '|' || '(\p{Lu}[\p{Ll}\[\]]+\s)?\p{Lu}[\p{Ll}\[\]]+((\set\s)?(\.|\s+\d|\p{Lu}[\p{Ll}\[\]]+))?):'"/>
 <xsl:variable name="speaker-regex" select="'^' || $speaker-name-regex || '$'"/>
 <xsl:variable name="speaker-supplied-regex" select="'^\[' || $speaker-name-regex || '?\]:?$'"/>
 
 <xsl:template match="tei:l[tei:space[1][following-sibling::text()[normalize-space() != ''][1][matches(., $speaker-regex)]]]" priority="2">
  <tei:speaker>
   <xsl:copy-of select="tei:space[1]" />
   <xsl:copy-of select="tei:space[1]/following-sibling::text()[normalize-space() != ''][1]" />
  </tei:speaker>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:l/text()[normalize-space() != ''][matches(., $speaker-regex)][preceding-sibling::*[1][self::tei:space]]" priority="2"/>
 
 <xsl:template match="tei:l[tei:space[1][following-sibling::text()[normalize-space() != ''][2] = ':'][following-sibling::text()[normalize-space() != ''][position() le 2] => string-join('') => matches($speaker-regex)]]">
  <xsl:variable name="end-node" select="tei:space[1]/following-sibling::text()[normalize-space() != ''][2][. = ':']"/>
  <tei:speaker>
   <xsl:copy-of select="tei:space[1]" />
   <xsl:copy-of select="tei:space[1]/following-sibling::node()[. &lt;&lt; $end-node]" />
   <xsl:copy-of select="$end-node" />
  </tei:speaker>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="tei:space[1]" />
   <xsl:apply-templates select="$end-node/following-sibling::node()" />
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>