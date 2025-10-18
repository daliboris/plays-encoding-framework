<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 xmlns:fn="http://www.w3.org/2005/xpath-functions"
 exclude-result-prefixes="xs math xd fn"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 13, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output method="xml" indent="yes" />
 
 <xsl:variable name="variant-delimiters-regex" select="'([\|&lt;=])'"/>
 <xsl:variable name="biblio-regex" select="'(\p{Lu}\p{Ll}*),\s(\p{Lu}\p{Ll}.[^\s]*(\s[A-Za-z]+)*,?),?\s?(([A-Z]*\s?[-\d–,^\s]+([vp]\.)?\s[-\d–]*)|([A-Z]+[a-z]*\d+[rv])|(\p{Lu},\d)|(([vp]\.)?\s[-\d–]*[\s,]*)+)\.'"/>
 <xsl:variable name="bibl-regex" select="'(Allusion:\s)(Cf\.\s)(Vulg\s)(\p{Lu}\p{Ll}*)\s(\d+,[-\d–]*)\.'"/>
 
<!-- <xsl:variable name="biblio-regex" select="'(\p{Lu}\p{Ll}*),\s(\p{Lu}\p{Ll}.[^\s]*(\s[A-Za-z]+)?,?),\s(([A-Z]+[a-z]*\d+[rv])|(\p{Lu},\d)|(([vp]\.)?\s[-\d–]*[\s,]*)+)\.'"/>-->
<!-- <xsl:variable name="biblio-regex" select="'(\p{Lu}\p{Ll}*),\s(\p{Lu}\p{Ll}.[^\s]*(\s[A-Z]+)?,?),\s(([A-Z]+[a-z]*\d+[rv])|(([vp]\.)?\s[-\d–]*[\s,]*)+)\.'"/>-->
 
 <xsl:template match="tei:app/tei:note">
  <xsl:variable name="app" select="parent::tei:app"/>
  <xsl:variable name="text" select="../../(* except (tei:app, tei:note))/text() => string-join(' ')"/> <!-- TODO: celý rozsah mezi [] -->
  
  <xsl:copy>
   <xsl:copy-of select="@*" />
   
   <xsl:for-each select="tei:p">
    <xsl:variable name="position" select="position()"/>
    <xsl:variable name="start" select="tokenize(normalize-space())[1]"/>
    
    <xsl:choose>
     <xsl:when test="$position = 1 and not(node())">
      <tei:quote>
       <xsl:call-template name="get-quotation">
        <xsl:with-param name="app" select="$app" />
       </xsl:call-template>
      </tei:quote>
     </xsl:when>
     <xsl:otherwise>
      <xsl:choose>
       <xsl:when test=".[tei:ref]">
        <xsl:copy-of select="tei:ref" />
       </xsl:when>
       <xsl:when test="matches(., $bibl-regex)">
        
        <xsl:analyze-string select="." regex="{$bibl-regex}">
         <xsl:matching-substring>
          <xsl:variable name="analyse" select="fn:analyze-string(., $bibl-regex)"/>
          <tei:lbl>Cf.</tei:lbl>
          <tei:bibl>
           <xsl:attribute name="type" select="'allusion'" />
           <tei:title><xsl:value-of select="$analyse//fn:group[@nr='3']"/></tei:title>, <tei:biblScope><xsl:value-of select="$analyse//fn:group[@nr='4'] || ' ' || $analyse//fn:group[@nr='5']"/></tei:biblScope>.</tei:bibl>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
          <xsl:call-template name="analyze-quotation">
           <xsl:with-param name="text" select="." />
          </xsl:call-template>
         </xsl:non-matching-substring>
        </xsl:analyze-string>
       </xsl:when>
       <xsl:when test="matches(., $biblio-regex)">
        <xsl:analyze-string select="." regex="{$biblio-regex}">
         <xsl:matching-substring>
          <xsl:variable name="analyse" select="fn:analyze-string(., $biblio-regex)"/>
          <tei:bibl><tei:author><xsl:value-of select="$analyse//fn:group[@nr='1']"/></tei:author>, <tei:title><xsl:value-of select="$analyse//fn:group[@nr='2']"/></tei:title>, <tei:biblScope><xsl:value-of select="$analyse//fn:group[@nr='4']"/></tei:biblScope>.</tei:bibl>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
          <xsl:call-template name="analyze-quotation">
           <xsl:with-param name="text" select="." />
          </xsl:call-template>
         </xsl:non-matching-substring>
        </xsl:analyze-string>
       </xsl:when>
       <xsl:when test="starts-with(., 'http')">
        <xsl:variable name="content" select="fn:normalize-space(.)"/>
        <xsl:variable name="html" select="if(ends-with($content, '.')) then fn:substring($content, 1, fn:string-length($content) - 1) else $content"/>
        <tei:ref target="{$html}"><xsl:value-of select="$html"/></tei:ref>
       </xsl:when>
       <xsl:when test="not(node())">
       </xsl:when>       
       <xsl:otherwise>
        <xsl:call-template name="analyze-quotation">
         <xsl:with-param name="text" select="." />
        </xsl:call-template>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
    
    <xsl:choose use-when="false()">
     <xsl:when test="$position = 1">
      
      <xsl:choose>
       <xsl:when test="not(node())">
        <tei:quote><xsl:value-of select="$text"/></tei:quote>
       </xsl:when>
       <xsl:when test="not(starts-with($start, 'http')) and matches(., $variant-delimiters-regex)">
        <xsl:analyze-string select="normalize-space(.)" regex="{$variant-delimiters-regex}">
         <xsl:matching-substring>
          <tei:milestone><xsl:value-of select="."/></tei:milestone>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
          <tei:seg type=""><xsl:value-of select="."/></tei:seg>
         </xsl:non-matching-substring>
        </xsl:analyze-string>
       </xsl:when>
       <xsl:when test="$start = 'Cf.'">
        <tei:seg type="allusion"><xsl:apply-templates /></tei:seg>
       </xsl:when>
       <xsl:otherwise>
        <tei:seg type="allusion"><xsl:apply-templates /></tei:seg>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:when>
     <xsl:when test="$position = 2">
      <xsl:choose>
       
       <xsl:when test=".[tei:ref]">
        <xsl:copy-of select="tei:ref" />
       </xsl:when>
       <xsl:when test="starts-with($start, 'http')">
        <tei:ref target="{normalize-space()}"><xsl:apply-templates /></tei:ref>
       </xsl:when>
       <xsl:when test="matches(., $variant-delimiters-regex)">
        <xsl:analyze-string select="normalize-space(.)" regex="{$variant-delimiters-regex}">
         <xsl:matching-substring>
          <tei:milestone><xsl:value-of select="."/></tei:milestone>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
          <xsl:choose>
           <xsl:when test="matches(., '/')">
            <tei:seg type=""><xsl:value-of select="."/></tei:seg>  
           </xsl:when>
           <xsl:when test="matches(., '\d')">
            <tei:bibl><xsl:value-of select="."/></tei:bibl>
           </xsl:when>
           <xsl:otherwise>
            <tei:seg type=""><xsl:value-of select="."/></tei:seg>
           </xsl:otherwise>
          </xsl:choose>
          
         </xsl:non-matching-substring>
        </xsl:analyze-string>
       </xsl:when>
       <xsl:when test="exists(node())">
        <tei:bibl><xsl:apply-templates /></tei:bibl>       
       </xsl:when>
       <xsl:otherwise>
        
       </xsl:otherwise>
      </xsl:choose>
     </xsl:when>
     <xsl:otherwise>
      <xsl:choose>
       <xsl:when test=".[tei:ref]">
        <xsl:copy-of select="tei:ref" />
       </xsl:when>
       <xsl:when test="not(node())">
       </xsl:when>
       <xsl:when test="matches(., $variant-delimiters-regex)">
        <xsl:analyze-string select="normalize-space(.)" regex="{$variant-delimiters-regex}">
         <xsl:matching-substring>
          <tei:milestone><xsl:value-of select="."/></tei:milestone>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
          <xsl:choose>
           <xsl:when test="matches(., '/')">
            <tei:seg type=""><xsl:value-of select="."/></tei:seg>  
           </xsl:when>
           <xsl:when test="matches(., '\d')">
            <tei:bibl><xsl:value-of select="."/></tei:bibl>
           </xsl:when>
           <xsl:otherwise>
            <tei:bibl><xsl:value-of select="."/></tei:bibl>
           </xsl:otherwise>
          </xsl:choose>
          
         </xsl:non-matching-substring>
        </xsl:analyze-string>
       </xsl:when>
       <xsl:otherwise>
        <tei:bibl><xsl:apply-templates /></tei:bibl>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template name="analyze-quotation">
  <xsl:param name="text" as="xs:string"/>
  <xsl:choose>
   <xsl:when test="matches($text, $variant-delimiters-regex)">
    <xsl:analyze-string select="normalize-space($text)" regex="{$variant-delimiters-regex}">
     <xsl:matching-substring>
      <tei:milestone><xsl:value-of select="."/></tei:milestone>
     </xsl:matching-substring>
     <xsl:non-matching-substring>
      <xsl:call-template name="analyze-quotation">
       <xsl:with-param name="text" select="." />
      </xsl:call-template>
     </xsl:non-matching-substring>
    </xsl:analyze-string>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="type" select="if(fn:starts-with($text, 'Cf.')) then 'allusion' else 'paraphrase'"/>
    <tei:seg type="{$type}"><xsl:value-of select="$text"/></tei:seg>  
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template name="get-quotation">
  <xsl:param name="app" as="element(tei:app)" />
  
  <xsl:variable name="start" select="id(substring-after($app/@from, '#'))" />
  <xsl:variable name="end" select="$app"/>
  
  <!-- Použijeme xsl:for-each-group k výběru všech uzlů mezi těmito dvěma uzly -->
  <xsl:variable name="text">
   <xsl:apply-templates select="$start/following::node()[self::text()][. &lt;&lt; $end]" mode="quote" />
  </xsl:variable>
  <!-- 
  <xsl:for-each select="$start/following::node()[. &lt;&lt; $end]">
   <xsl:choose>
    <xsl:when test="local-name(.) = ('note', 'app')" />
    <xsl:when test="text()"><xsl:value-of select="."/></xsl:when>
   </xsl:choose>
  </xsl:for-each>
   -->
  <xsl:value-of select="fn:normalize-space($text)"/>
 </xsl:template>
 
 <xsl:template match="text()" mode="quote">
  <xsl:value-of select="."/>
  <xsl:if test="fn:position() != last()">
   <xsl:choose>
    <xsl:when test="parent::*[self::tei:persName]"><xsl:text>: </xsl:text></xsl:when>
    <xsl:when test="parent::*[self::tei:l]"><xsl:text> / </xsl:text></xsl:when>
    <xsl:otherwise><xsl:text> / </xsl:text></xsl:otherwise>
   </xsl:choose>
  </xsl:if>
  
 </xsl:template>
 
 <!--<xsl:template name="text-variants">
  
  </xsl:template>-->
 
</xsl:stylesheet>