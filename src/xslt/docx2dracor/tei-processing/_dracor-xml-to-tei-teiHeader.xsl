<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xpef="https://www.daliboris.cz/ns/xslt/plays-encoding-framework"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei xpef" 
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 15, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p />
  </xd:desc>
 </xd:doc>

 <xsl:mode on-no-match="shallow-skip" name="tei" />
 <xsl:mode on-no-match="shallow-skip" />
 
 <xsl:output indent="yes" />
 
 <xsl:variable name="multiple-items-separator-regex">;\s</xsl:variable>
 <xsl:variable name="year-regex">^\d{4}$</xsl:variable>
 <xsl:variable name="not-before-after-regex">^not\sbefore\s(\d{4}),\snot\safter\s(\d{4})$</xsl:variable>
 <xsl:variable name="author-persName-default-lang">lat</xsl:variable>

 <xsl:variable name="rows" as="map(xs:string, xs:integer)">
  <xsl:map>
   <xsl:map-entry key="'work-title'" select="xs:int(2)" />
   <xsl:map-entry key="'work-wikidata-id'" select="xs:int(3)" />
   <xsl:map-entry key="'genre'" select="xs:int(4)" />
   <xsl:map-entry key="'genre-wikidata-id'" select="xs:int(5)" />
   <xsl:map-entry key="'region'" select="xs:int(6)" />
   <xsl:map-entry key="'region-wikidata-id'" select="xs:int(7)" />
   <xsl:map-entry key="'printed'" select="xs:int(8)" />
   <xsl:map-entry key="'premiered'" select="xs:int(9)" />
   <xsl:map-entry key="'written'" select="xs:int(10)" />
   <xsl:map-entry key="'author'" select="xs:int(11)" />
   <xsl:map-entry key="'author-wikidata-id'" select="xs:int(12)" />
   <xsl:map-entry key="'author-gnd-id'" select="xs:int(13)" />
   <xsl:map-entry key="'editor-of-the-source-critical-edition-or-source-online-edition'" select="xs:int(14)" />
   <xsl:map-entry key="'transcribed-under-the-supervision-of'" select="xs:int(15)" />
   <xsl:map-entry key="'transcribed-by'" select="xs:int(16)" />
   <xsl:map-entry key="'transcription-software'" select="xs:int(17)"/>
   <xsl:map-entry key="'converted-to-tei-under-the-supervision-of'" select="xs:int(18)"/>
   <xsl:map-entry key="'converted-to-tei-by'" select="xs:int(19)"/>
   <xsl:map-entry key="'institution'" select="xs:int(20)"/>
   <xsl:map-entry key="'funding-organisation-or-institution'" select="xs:int(21)"/>
   <xsl:map-entry key="'funding-line'" select="xs:int(22)"/>
   <xsl:map-entry key="'publisher'" select="xs:int(23)"/>
   <xsl:map-entry key="'licence-of-the-tei-file'" select="xs:int(24)"/>
   <xsl:map-entry key="'copyright-of-the-source-text-edition'" select="xs:int(25)"/>
   <xsl:map-entry key="'source-text-edition'" select="xs:int(26)"/>
   <xsl:map-entry key="'copyright-of-the-source-critical-edition'" select="xs:int(27)"/>
   <xsl:map-entry key="'source-critical-edition'" select="xs:int(28)"/>
   <xsl:map-entry key="'copyright-of-the-digital-source'" select="xs:int(29)"/>
   <xsl:map-entry key="'acknowledgements'" select="xs:int(30)"/>
   <xsl:map-entry key="'digital-source'" select="xs:int(31)"/>
   <xsl:map-entry key="'url-of-digital-source'" select="xs:int(32)"/>
   <xsl:map-entry key="'availability-status'" select="xs:int(33)"/>
   <xsl:map-entry key="'notes-on-the-availability-status'" select="xs:int(34)"/>
  </xsl:map>
 </xsl:variable>

 <xsl:variable name="publisher" select="'DraCor'"/>
 <xsl:variable name="publisher-id" select="'dracor'"/>
 <xsl:variable name="publisher-url" select="'https://dracor.org'"/>
 <xsl:variable name="licence-of-tei-file" select="'CC0 1.0'"/>
 <xsl:variable name="licence-of-tei-file-url" select="'https://creativecommons.org/publicdomain/zero/1.0/'"/>

 <!-- Use only with one document with multiple metadata tables -->
 <xsl:template match="/" use-when="false()">
  <TEI xmlns="http://www.tei-c.org/ns/1.0">
   <text>
    <xsl:apply-templates select="/body/table" />
   </text>
  </TEI>
 </xsl:template>

 <xsl:template match="table">
  <teiHeader>
   <fileDesc>
    <titleStmt>
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'work-title'" />
     </xsl:apply-templates>
     <author>
      <xsl:apply-templates select="." mode="element">
       <xsl:with-param name="row-key" select="'author'" />
      </xsl:apply-templates>
      
      <xsl:apply-templates select="." mode="element">
       <xsl:with-param name="row-key" select="'author-wikidata-id'" />
      </xsl:apply-templates>
      
      <xsl:apply-templates select="." mode="element">
       <xsl:with-param name="row-key" select="'author-gnd-id'" />
      </xsl:apply-templates>
     </author>
     
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'editor-of-the-source-critical-edition-or-source-online-edition'" />
     </xsl:apply-templates>
     
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'transcribed-under-the-supervision-of'" />
     </xsl:apply-templates>

     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'transcribed-by'" />
     </xsl:apply-templates>
     
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'converted-to-tei-under-the-supervision-of'" />
     </xsl:apply-templates>
     
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'converted-to-tei-by'" />
     </xsl:apply-templates>

     <!-- TODO: if aplicable -->
     <funder>
      <xsl:apply-templates select="." mode="element">
       <xsl:with-param name="row-key" select="'funding-organisation-or-institution'" />
      </xsl:apply-templates>
      <xsl:apply-templates select="." mode="element">
       <xsl:with-param name="row-key" select="'funding-line'" />
      </xsl:apply-templates>
     </funder>
     
     <xsl:if test="not(xpef:is-empty(., 'copyright-of-the-source-text-edition', 2))">
      <availability xmlns="http://www.tei-c.org/ns/1.0">
       <p><xsl:text>Copyright of the text edition (c)</xsl:text>
        <xsl:apply-templates select="." mode="tei">
         <xsl:with-param name="row-key" select="'copyright-of-the-source-text-edition'" />
        </xsl:apply-templates>
        <xsl:text>. Cf. </xsl:text>
        <xsl:apply-templates select="." mode="tei">
         <xsl:with-param name="row-key" select="'source-text-edition'" />
        </xsl:apply-templates>
       </p>
      </availability> 
       
     </xsl:if>

    </titleStmt>

    <xsl:variable name="source-text-edition" select="./row[$rows?source-text-edition]/cell[2]"/>
    <xsl:variable name="source-critical-edition" select="./row[$rows?source-critical-edition]/cell[2]"/>
    <xsl:variable name="digital-source" select="./row[$rows?digital-source]/cell[2]"/>
    
    <xsl:variable name="copyright-of-the-source-text-edition" select="./row[$rows?copyright-of-the-source-text-edition]/cell[2]"/>
    <xsl:variable name="copyright-of-the-source-critical-edition" select="./row[$rows?copyright-of-the-source-critical-edition]/cell[2]"/>
    <xsl:variable name="copyright-of-the-digital-source" select="./row[$rows?copyright-of-the-digital-source]/cell[2]"/>
    
    <publicationStmt>
     
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'institution'" />
     </xsl:apply-templates>
     
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'publisher'" /> <!-- DraCor -->
     </xsl:apply-templates>
     <availability>
      <licence>
       <xsl:apply-templates select="." mode="element">
        <xsl:with-param name="row-key" select="'licence-of-the-tei-file'" />
       </xsl:apply-templates>
      </licence>
      
      <xsl:if test="not(xpef:is-empty($copyright-of-the-source-text-edition))">
       <p xmlns="http://www.tei-c.org/ns/1.0">
        <xsl:text>Copyright of the text edition (c) </xsl:text>
        <xsl:apply-templates select="." mode="element">
         <xsl:with-param name="row-key" select="'copyright-of-the-source-text-edition'" />
        </xsl:apply-templates>
        <xsl:text>. Cf. </xsl:text>
        <xsl:apply-templates select="." mode="element">
         <xsl:with-param name="row-key" select="'source-text-edition'" />
        </xsl:apply-templates>
       </p>
      </xsl:if>
       
      <xsl:if test="not(xpef:is-empty($copyright-of-the-source-critical-edition))">
        <p xmlns="http://www.tei-c.org/ns/1.0">
         <xsl:text>Copyright of the critical edition (c) </xsl:text>
         <xsl:apply-templates select="." mode="element">
          <xsl:with-param name="row-key" select="'copyright-of-the-source-critical-edition'" />
         </xsl:apply-templates>
         <xsl:text>. Cf. </xsl:text>
         <xsl:apply-templates select="." mode="element">
          <xsl:with-param name="row-key" select="'source-critical-edition'" />
         </xsl:apply-templates>
        </p>
       </xsl:if>
       
      
       
      <xsl:if test="not(xpef:is-empty($copyright-of-the-digital-source))">
         <p xmlns="http://www.tei-c.org/ns/1.0">
          <xsl:text>Copyright of the digital source (c) </xsl:text>
          <xsl:apply-templates select="." mode="element">
           <xsl:with-param name="row-key" select="'copyright-of-the-digital-source'" />
          </xsl:apply-templates>
         </p>
       
      </xsl:if>
     </availability>
    </publicationStmt>
    
    <xsl:if 
      test="not(xpef:is-empty($digital-source))
      or not(xpef:is-empty($source-critical-edition))
      or not(xpef:is-empty($source-text-edition))
     ">
     
     <sourceDesc>
      <xsl:if 
       test="not(xpef:is-empty($digital-source))">
       
      </xsl:if>
      <bibl type="digitalSource" xmlns="http://www.tei-c.org/ns/1.0">
       <name  xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="$digital-source" mode="tei" /></name>
       <xsl:if test="not(xpef:is-empty($digital-source))">
        <xsl:variable name="url" select="./row[$rows?url-of-digital-source]/cell[2]"/>        
        <xsl:variable name="availability-status" select="./row[$rows?availability-status]/cell[2]"/>        
        <xsl:variable name="notes-on-the-availability-status" select="./row[$rows?notes-on-the-availability-status]/cell[2]"/>        
        <idno xmlns="http://www.tei-c.org/ns/1.0" type="URL"><xsl:value-of select="$url/normalize-space()" /></idno>
        <availability  xmlns="http://www.tei-c.org/ns/1.0" status="{$availability-status/normalize-space()}">
         <xsl:if test="not(xpef:is-empty($notes-on-the-availability-status))">
          <p  xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="$notes-on-the-availability-status" mode="tei" /></p>
         </xsl:if>
        </availability>
       </xsl:if>
       
      </bibl>
      <xsl:if 
       test="not(xpef:is-empty($source-critical-edition))">
       <bibl type="originalSource" xmlns="http://www.tei-c.org/ns/1.0">
        <xsl:apply-templates select="$source-critical-edition" mode="tei" />
       </bibl>
      </xsl:if>
      <xsl:if 
       test="not(xpef:is-empty($source-text-edition))">
       <bibl type="originalSource" xmlns="http://www.tei-c.org/ns/1.0">
        <xsl:apply-templates select="$source-text-edition" mode="tei" />
       </bibl>
      </xsl:if>
     </sourceDesc>
     
    </xsl:if>

   </fileDesc>
   <profileDesc>
    <textClass>
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'genre'" />
     </xsl:apply-templates>
     <xsl:apply-templates select="." mode="element">
      <xsl:with-param name="row-key" select="'genre-wikidata-id'" />
     </xsl:apply-templates>
    </textClass>
    <!-- <creation> <region /> </creation> -->
    <xsl:apply-templates select="." mode="element">
     <xsl:with-param name="row-key" select="'region'" />
    </xsl:apply-templates>
   </profileDesc>
  </teiHeader>
  <standOff>
   <listRelation>
    <xsl:apply-templates select="." mode="element">
     <xsl:with-param name="row-key" select="'work-wikidata-id'" />
    </xsl:apply-templates>
   </listRelation>
   <listEvent>
    <xsl:apply-templates select="." mode="element">
     <xsl:with-param name="row-key" select="'printed'" />
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="element">
     <xsl:with-param name="row-key" select="'premiered'" />
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="element">
     <xsl:with-param name="row-key" select="'written'" />
    </xsl:apply-templates>
   </listEvent>
  </standOff>
 </xsl:template>

 <xsl:template match="*[not(*)]" mode="tei">
  <xsl:value-of select="." />
 </xsl:template>

 <xsl:template match="table" mode="element">
  <xsl:param name="row-key" as="xs:string" />

  <xsl:variable name="row" select="row[$rows?($row-key)]" />
  <xsl:variable name="cell" select="$row/cell[2]" />
  <xsl:choose>
   <xsl:when test="xpef:is-empty($cell)" />
   <xsl:when test="$row-key = 'work-title'">
    <title xmlns="http://www.tei-c.org/ns/1.0" type="work">
     <xsl:apply-templates select="$cell" mode="tei" />
    </title>
   </xsl:when>
   <xsl:when test="$row-key = 'work-wikidata-id'">
    <xsl:variable name="value" select="$cell/normalize-space()" />
    <relation xmlns="http://www.tei-c.org/ns/1.0" name="wikidata" active="https://dracor.org/entity/neolatXXXXXX">
     <xsl:if test="not(xpef:is-empty($value))">
      <xsl:attribute name="passive" select="'https://www.wikidata.org/wiki/' || $value" />
     </xsl:if>
    </relation>
   </xsl:when>
   <xsl:when test="$row-key = 'genre'">
    <keywords xmlns="http://www.tei-c.org/ns/1.0" >
     <term type="genreTitle">
      <xsl:apply-templates select="$cell" mode="tei" />
     </term>
    </keywords>
   </xsl:when>
   <xsl:when test="$row-key = 'genre-wikidata-id'">
    <classCode xmlns="http://www.tei-c.org/ns/1.0" scheme="http://www.wikidata.org/entity/">
     <xsl:apply-templates select="$cell" mode="tei" />
    </classCode>
   </xsl:when>
   <xsl:when test="$row-key = 'region'">
    <xsl:variable name="wikidata-id" select="row[$rows?region-wikidata-id]/cell[2]/normalize-space()"/>
    <creation xmlns="http://www.tei-c.org/ns/1.0">
     <region>
      <xsl:choose>
       <xsl:when test="xpef:is-empty($wikidata-id)">
        <xsl:apply-templates select="$cell" mode="tei" /> 
       </xsl:when>
       <xsl:otherwise>
        <ref xmlns="http://www.tei-c.org/ns/1.0" target="https://www.wikidata.org/wiki/{$wikidata-id}"><xsl:apply-templates select="$cell" mode="tei" /></ref>
       </xsl:otherwise>
      </xsl:choose>
     </region>
    </creation>
   </xsl:when>
   <xsl:when test="$row-key = 'region-wikidata-id'" use-when="false()">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'printed'">
    <!-- TODO: notAfter, notBefore -->
    <xsl:call-template _name="process-event">
     <xsl:with-param name="cell" select="$cell" />
     <xsl:with-param name="type" select="'print'" />
    </xsl:call-template>
    <!--<xsl:variable name="value" select="$cell/normalize-space()"/>
    <event xmlns="http://www.tei-c.org/ns/1.0" type="print" when="{$value}"><desc/></event> -->
   </xsl:when>
   <xsl:when test="$row-key = 'premiered'">
    <xsl:call-template _name="process-event">
     <xsl:with-param name="cell" select="$cell" />
     <xsl:with-param name="type" select="'premiere'" />
    </xsl:call-template>
    <!--<xsl:variable name="value" select="$cell/normalize-space()"/>
    <event xmlns="http://www.tei-c.org/ns/1.0" type="premiere" when="{$value}"><desc/></event> -->
   </xsl:when>
   <xsl:when test="$row-key = 'written'">
    <xsl:call-template _name="process-event">
     <xsl:with-param name="cell" select="$cell" />
     <xsl:with-param name="type" select="'written'" />
    </xsl:call-template>
    <!--<xsl:variable name="value" select="$cell/normalize-space()"/>
    <event xmlns="http://www.tei-c.org/ns/1.0" type="written" when="{$value}"><desc/></event> -->
   </xsl:when>
   <xsl:when test="$row-key = 'author'">
    <persName xmlns="http://www.tei-c.org/ns/1.0" xml:lang="{$author-persName-default-lang}"><xsl:apply-templates select="$cell" mode="tei" /></persName>
   </xsl:when>
   <xsl:when test="$row-key = 'author-wikidata-id'">
    <idno xmlns="http://www.tei-c.org/ns/1.0" type="wikidata"><xsl:apply-templates select="$cell" mode="tei" /></idno>
   </xsl:when>
   <xsl:when test="$row-key = 'author-gnd-id'">
    <idno xmlns="http://www.tei-c.org/ns/1.0" type="pnd"><xsl:apply-templates select="$cell" mode="tei" /></idno>
   </xsl:when>
   <xsl:when test="$row-key = 'editor-of-the-source-critical-edition-or-source-online-edition'">
    <!-- TODO: multiple names -->
    <xsl:if test="not(xpef:is-empty($cell))">
     <xsl:call-template name="insert-multiple-items">
      <xsl:with-param name="cell" select="$cell"/>
      <xsl:with-param name="name" select="'editor'"/>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$row-key = 'transcribed-under-the-supervision-of'">
     <xsl:if test="not(xpef:is-empty($cell))">
      <respStmt> 
       <resp>Transcribed under the supervision of</resp>
      <xsl:call-template name="insert-multiple-items">
       <xsl:with-param name="cell" select="$cell"/>
       <xsl:with-param name="name" select="'persName'"/>
      </xsl:call-template>
       <xsl:variable name="sofware" select="row[$rows?('transcription-software')]/cell[2]"/>
       <xsl:if test="not(xpef:is-empty($sofware))">
        <note xmlns="http://www.tei-c.org/ns/1.0">
         <xsl:text xml:space="preserve"> using </xsl:text>
         <xsl:value-of select="$sofware/normalize-space()"/>         
        </note>
       </xsl:if>
      </respStmt>
     </xsl:if>
   </xsl:when>
   <xsl:when test="$row-key = 'transcribed-by'">
    
    <xsl:if test="not(xpef:is-empty($cell))">
     <respStmt> 
      <resp>Transcribed by</resp>
      <xsl:call-template name="insert-multiple-items">
       <xsl:with-param name="cell" select="$cell"/>
       <xsl:with-param name="name" select="'persName'"/>
      </xsl:call-template>
     </respStmt>
    </xsl:if>
   </xsl:when>
   
   <xsl:when test="$row-key = 'converted-to-tei-under-the-supervision-of'">
    
    <xsl:if test="not(xpef:is-empty($cell))">
     <respStmt> 
      <resp>Converted to TEI under the supervision of</resp>
      <xsl:call-template name="insert-multiple-items">
       <xsl:with-param name="cell" select="$cell"/>
       <xsl:with-param name="name" select="'persName'"/>
      </xsl:call-template>
     </respStmt>
    </xsl:if>

   </xsl:when>
   <xsl:when test="$row-key = 'converted-to-tei-by'">
    
    <xsl:if test="not(xpef:is-empty($cell))">
     <respStmt> 
      <resp>Converted to TEI by</resp>
      <xsl:call-template name="insert-multiple-items">
       <xsl:with-param name="cell" select="$cell"/>
       <xsl:with-param name="name" select="'persName'"/>
      </xsl:call-template>
     </respStmt>
    </xsl:if>
    
   </xsl:when>
   <xsl:when test="$row-key = 'institution'">
    <authority xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="$cell" mode="tei" /></authority>
   </xsl:when>
   <xsl:when test="$row-key = 'funding-organisation-or-institution'">
    <orgName xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:apply-templates select="$cell" mode="tei" /> 
    </orgName>
    
   </xsl:when>
   <xsl:when test="$row-key = 'funding-line'">
    <name xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="$cell" mode="tei" /></name>
   </xsl:when>
   <xsl:when test="$row-key = 'publisher'">
    <xsl:variable name="value" select="$cell/normalize-space()"/>
    <!-- hardcoded -->
    <publisher xml:id="{lower-case($publisher-id)}" xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="$publisher"/></publisher>
    <!-- hardcoded -->
    <idno type="URL" xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="$publisher-url"/></idno>
    
   </xsl:when>
   <xsl:when test="$row-key = 'licence-of-the-tei-file'">
    <!-- hardcoded -->
    <ab xmlns="http://www.tei-c.org/ns/1.0"><xsl:value-of select="$licence-of-tei-file"/></ab>
    <!-- hardcoded -->
    <ref xmlns="http://www.tei-c.org/ns/1.0" target="{$licence-of-tei-file-url}">Licence</ref>
   </xsl:when>
   <xsl:when test="$row-key = 'copyright-of-the-source-text-edition'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'source-text-edition'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'copyright-of-the-source-critical-edition'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'source-critical-edition'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'copyright-of-the-digital-source'">
    <xsl:apply-templates select="$cell" mode="tei" />    
   </xsl:when>
   <xsl:when test="$row-key = 'acknowledgements'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'digital-source'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'url-of-digital-source'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   <xsl:when test="$row-key = 'availability-status'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
   
   
   <xsl:when test="$row-key = 'notes-on-the-availability-status'">
    <xsl:apply-templates select="$cell" mode="tei" />
   </xsl:when>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template name="insert-multiple-items">
  <xsl:param name="cell" />
  <xsl:param name="name" />
  <xsl:variable name="items" select="tokenize(normalize-space($cell), $multiple-items-separator-regex)" />
  <xsl:for-each select="$items[.]">
   <xsl:element name="{$name}" namespace="http://www.tei-c.org/ns/1.0">
    <xsl:value-of select="." />
   </xsl:element>
  </xsl:for-each>
 </xsl:template>
 
 
 <xsl:template name="process-event">
  <xsl:param name="cell" as="element()"/>
  <xsl:param name="type" as="xs:string"/>
  <xsl:if test="not(xpef:is-empty($cell))">
   <xsl:variable name="value" select="$cell/normalize-space()"/>
   <xsl:choose>
    <xsl:when test="matches($value, $year-regex)">
     <event xmlns="http://www.tei-c.org/ns/1.0" type="{$type}" when="{$value}"><desc/></event>  
    </xsl:when>
    <xsl:otherwise>
     <xsl:analyze-string select="$value" regex="{$not-before-after-regex}">
      <xsl:matching-substring>
       <event xmlns="http://www.tei-c.org/ns/1.0" type="{$type}" notBefore="{regex-group(1)}" notAfter="{regex-group(2)}" ><desc/></event>
      </xsl:matching-substring>
     </xsl:analyze-string>
    </xsl:otherwise>
   </xsl:choose>
    
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="Hyperlink">
  <ref target="{.}"><xsl:value-of select="."/></ref>
 </xsl:template>
 
 <xsl:variable name="empty-values" select="('', '/')"/>

 <xsl:function name="xpef:is-empty" as="xs:boolean">
  <xsl:param name="node" as="item()?"/>
  <xsl:choose>
   <xsl:when test="$node instance of xs:string">
    <xsl:value-of select="normalize-space($node) = $empty-values"/>
   </xsl:when>
   <xsl:when test="empty($node)">
    <xsl:value-of select="true()"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="normalize-space($node) = $empty-values"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function>
 <xsl:function name="xpef:is-empty" as="xs:boolean">
  <xsl:param name="table" as="element()"/>
  <xsl:param name="row" as="xs:string"/>
  <xsl:param name="cell"  />
  <xsl:value-of select="xpef:is-empty($table[$rows?($row)]/cell[$cell])"/>
 </xsl:function>


</xsl:stylesheet>