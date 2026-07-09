<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xdc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/dracor"
 xmlns:xxml="https://www.daliboris.cz/ns/xproc/xml"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 xmlns:tei = "http://www.tei-c.org/ns/1.0" 
 version="3.0">
 
 <p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="common-lib.xpl" />

 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <p:declare-step type="xdc:tei-to-dracor" name="tei-to-dracor">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="data-file-path" as="xs:string?" />
  <p:option name="text-id" as="xs:string" required="true"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  <p:variable name="log-output-directory" select="$debug-path || '/' || $text-id || '/tei-to-dracor/'" />
  
  <p:variable name="dracor-id" select="/data/dracor/@id" href="{$data-file-path-uri}" />
  
  <!-- PIPELINE BODY -->
  
  <p:add-attribute match="*[@xml:lang['la']]" attribute-name="xml:lang" attribute-value="lat" use-when="false()" />
  <p:delete match="tei:div[@type='editorial']" />
  <p:delete match="tei:fileDesc/tei:notesStmt" />
  <p:delete match="tei:sourceDesc/tei:listWit" />
  <p:delete match="tei:sourceDesc/tei:msDesc" />
  
  <!-- TODO -->
  <!-- TODO: nahradit -->
  <p:replace match="tei:listBibl" use-when="false()">
   <p:with-input port="replacement">
    <tei:bibl type="digitalSource">
     <tei:name>Theatrum Neolatinum Repository</tei:name>
     <tei:idno type="URL">http://theatrum-neolatinum.cz/</tei:idno>
     <tei:availability>
      <tei:licence>
       <tei:ab>CC-BY-3.0</tei:ab>
       <tei:ref target="http://creativecommons.org/licenses/by/3.0/de/legalcode">Lizenzvertrag</tei:ref>
      </tei:licence>
     </tei:availability>
     <tei:bibl type="originalSource">
      <tei:author>Kateřina Bobková-Valentová</tei:author>, <tei:author>Alena Bočková</tei:author>, <tei:author>Magdaléna Jacková</tei:author>, <tei:author>Martin Bažil</tei:author>, <tei:author>Eva Pauerová</tei:author>, <tei:author>Jan Zdichynec</tei:author> a <tei:author>Zdeněk Žalud</tei:author>:
      <tei:title level="a">Angelus ad aras D. Joannes Nepomucenus</tei:title>. In <tei:title level="s">Sv. Jan Nepomucký na jezuitských školních scénách, Theatrum Neolatinum. Latinské divadlo v českých zemích 1</tei:title>. <tei:pubPlace>Praha</tei:pubPlace>: <tei:publisher>Academia</tei:publisher>, <tei:date when="2015">2015</tei:date>, s. <tei:biblScope unit="page" from="78" to="139">78–139</tei:biblScope>.
     </tei:bibl>
    </tei:bibl>   
   </p:with-input>
  </p:replace>
  
  <!-- move divs to front -->
  <p:insert match="tei:front" position="last-child">
   <p:with-input port="insertion" select="//tei:body/*[following-sibling::tei:div[@type='list-of-persons']]" pipe="source@tei-to-dracor" />
  </p:insert>
  <p:insert match="tei:front" position="last-child">
   <p:with-input port="insertion" select="//tei:body/tei:div[@type='list-of-persons']" pipe="source@tei-to-dracor"/>
  </p:insert>
  
  <p:delete match="tei:body/*[following-sibling::tei:div[@type='list-of-persons']]" />
  <p:delete match="tei:body/tei:div[@type='list-of-persons']" />
  
  <p:if test="tei:titlePage/following-sibling::*[1][self::tei:epigraph]">
   <p:insert match="tei:titlePage" position="last-child">
    <p:with-input port="insertion" select="//tei:titlePage/following-sibling::*[1][self::tei:epigraph]" pipe="source@tei-to-dracor" />
   </p:insert>
   <p:delete match="tei:titlePage/following-sibling::*[1][self::tei:epigraph]" />
  </p:if>
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="10" />
  
  <!-- change divs to stage -->
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/tei-change-div-to-stage.xsl" />
  </p:xslt>
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="11" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/tei-change-argument-to-stage.xsl" />
  </p:xslt>
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="12" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/tei-list-of-persons-to-castList.xsl" />
  </p:xslt>
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="13" />
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/tei-castItem-split-by-role.xsl" />
  </p:xslt>
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="14" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/tei-castItem-fix-punctuation.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="15" />
  
  <p:replace match="tei:teiHeader" message="   ---- replacing teiHeader --- ">
   <p:with-input port="replacement" select="/data/dracor/tei:teiHeader" href="{$data-file-path-uri}" />
  </p:replace>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="16" />
  
  <p:replace match="tei:listPerson" message="   ---- replacing listPerson --- ">
   <p:with-input port="replacement" select="//tei:teiHeader//tei:listPerson[not(@xml:id)][tei:person]" pipe="source@tei-to-dracor"/>
  </p:replace>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="17" />
  
  <p:insert match="tei:listPerson" position="last-child">
   <p:with-input port="insertion" select="//tei:teiHeader//tei:listPerson[@xml:id]/tei:person" pipe="source@tei-to-dracor" />
  </p:insert>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="18" />

 <p:group use-when="false()">
  <p:insert match="tei:listPerson" position="last-child">
   <p:with-input port="insertion" select="/data/persons/tei:person"  href="{$data-file-path-uri}" />
  </p:insert>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="20" />
 </p:group>
  

  <p:delete match="tei:listPerson[not(tei:person)]" />
  <p:delete match="tei:listPerson/tei:head[@xml:lang='cs']" use-when="false()" />
  <p:delete match="tei:listPerson/tei:head[@xml:lang]" />
  <p:delete match="tei:listPerson/tei:person/tei:persName[@xml:lang='cs']" />
  <p:delete match="tei:listPerson/tei:person/tei:persName/@xml:lang" />
  <p:delete match="tei:listPerson/tei:person/tei:persName/@type" />
  <p:delete match="tei:listPerson/tei:person/tei:occupation" />

  <p:delete match="tei:listPerson/tei:personGrp/tei:persName/@xml:lang" />
  <p:delete match="tei:listPerson/tei:personGrp/tei:persName/@type" />
  <p:delete match="tei:listPerson/tei:personGrp/tei:occupation" />
  
  <p:delete match="tei:sourceDesc/tei:listWit" />
  
  <p:variable name="castGroups" select="'(&#34;' || replace(/data/persons/castGroup, ',\s+', '&#34;, &#34;') || '&#34;)'" href="{$data-file-path-uri}"/>
  <p:variable name="persNames" select="//tei:castList/tei:castItem[*[. = $castGroups]]"/>
  <p:rename match="tei:castList/tei:castItem[*[. = {$castGroups}]]" new-name="tei:castGroup" message="   ---- renaming castItem to castGroup : {string-join($castGroups, '; ')}; $persNames: {count($persNames)}"></p:rename>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$text-id}.xml" debug="{$debug}" step="21" />
  
  <p:variable name="roleDescs" select="'(&#34;' || replace(/data/persons/roleDesc[@type='simple'], ',\s+', '&#34;, &#34;') || '&#34;)'" href="{$data-file-path-uri}"/>
  <p:variable name="persNames" select="//tei:castList/tei:*/tei:role[. = $roleDescs]"/>
  <p:rename match="tei:castList/tei:*/tei:role[. = {$roleDescs}]" new-name="tei:roleDesc" message="   ---- renaming role to roleDesc : {string-join($castGroups, '; ')}; $persNames: {count($persNames)}"></p:rename>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$text-id}.xml" debug="{$debug}" step="22" />
  
  <p:variable name="roleDescs" select="/data/persons/roleDesc[@type='multiple']" href="{$data-file-path-uri}"/>
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/tei-change-role.xsl" />
   <p:with-option name="parameters" select="map {'roleDesc' : $roleDescs }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$text-id}.xml" debug="{$debug}" step="23" />

  <p:delete match="tei:TEI/tei:standOff" />
  <p:insert match="tei:teiHeader">
   <p:with-input port="insertion" select="/data/dracor/tei:standOff"  href="{$data-file-path-uri}" />
  </p:insert>
  
  <p:delete match="tei:encodingDesc" />
  
  <!-- TODO: do <standOff> -->
  <p:delete match="tei:profileDesc/tei:langUsage" />
  
  <p:delete match="tei:body/tei:div[@type='title']"/>
  <p:delete match="tei:text/@*" />
  <p:delete match="tei:p/@*" />
  <p:delete match="tei:emph/@rendition" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="25" />
  
  <p:delete match="tei:facsimile" />
  <p:delete match="tei:pb/@xml:id" />
  <p:delete match="tei:pb/@facs" />
  
  <p:unwrap match="tei:speaker/tei:persName" />
  
  <p:delete match="tei:app/tei:rdg" />
  <p:unwrap match="tei:app/tei:lem" />
  <p:unwrap match="tei:app" />
  
  <p:delete match="tei:anchor" />
  
  <p:unwrap match="tei:supplied" />
  <p:unwrap match="tei:hi[@rendition='normal'][. = ' ']" /><!-- whitespace between 2 <tei:app> elements -->
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="26" />
  <p:rename match="tei:hi" new-name="tei:emph" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="27" />
  <p:unwrap match="tei:emph[@xml:space='preserve'][. = ' ']" /><!-- whitespace between 2 <tei:app> elements -->
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="28" />
  
  <p:delete match="tei:note[@n]" />
  <p:delete match="tei:note[not(@n)]" />
  <p:add-attribute match="tei:note[@n]" attribute-name="place" attribute-value="foot" use-when="false()" />
  <p:add-attribute match="tei:emph[@rend='italic' or @rendition='italic']" attribute-name="style" attribute-value="font-style: italic;" use-when="false()" />
  <p:rename match="@rendition" new-name="rend" />
  <!--<p:set-attributes match="tei:*[matches(@rend, 'indent\d')]" attributes="map{'rend': 'indent'}"/>-->
  <!--<p:delete match="tei:emph/@rend[. ='italic']" />
  <p:delete match="tei:emph/@rendition[. ='italic']" />-->
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="30" />
  
  <p:variable name="fixes" select="/data/dracor/fixes/fix" href="{$data-file-path-uri}"/>
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/apply-fixes-for-dracor.xsl" />
   <p:with-option name="parameters" select="map {'fixes' : $fixes}" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="31" />
  
  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/change-latin-numbers-to-arabic.xsl" />
  </p:xslt>
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="35" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/move-pb-outside.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="40" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/rename-ids.xsl" />
  </p:xslt>
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/move-finis-to-stage.xsl" />
  </p:xslt>
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/dracor/remove-trailing-spaces.xsl" />
  </p:xslt>
  
  <!-- ??? -->
  <p:delete match="tei:space" />
  <p:delete match="tei:*/tei:lb" />
  
  <!-- SKIP -->
  <p:delete match="tei:editionStmt" use-when="false()" />
  <!-- 
 <p:delete match="tei:publicationStmt/tei:pubPlace" />
 <p:delete match="tei:publicationStmt/tei:date" />
  -->
  
  <!-- <p:add-attribute match="tei:availability" attribute-name="status" attribute-value="free" />-->
  <!-- SKIP -->
  <p:replace match="tei:availability"  use-when="false()">
   <p:with-input port="replacement">
    <tei:availability status="free">
     <tei:licence>
      <tei:ab>CC BY-NC-SA 4.0</tei:ab>
      <tei:ref target="https://creativecommons.org/licenses/by-nc-sa/4.0/">License</tei:ref>
     </tei:licence>
    </tei:availability>
   </p:with-input>
  </p:replace>
  
  <!--
  tei:div[@type='scene']/tei:div[tei:div]
 -->
  <p:unwrap match="tei:div[@type='scene']/tei:div[tei:div]" />
  
  <p:add-attribute match="tei:TEI" attribute-name="xml:id" attribute-value="{$dracor-id}" />
  <p:add-attribute match="tei:TEI" attribute-name="type" attribute-value="dracor" />
  
  <!-- SKIP -->
  <!-- 
  <p:insert match="tei:TEI" position="before" use-when="false()">
   <p:with-input port="insertion"><p:inline><?xml-model href="https://dracor.org/schema.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?></p:inline> </p:with-input>
  </p:insert>
   -->
  
  <p:unwrap match="tei:ref[starts-with(@target, '#')][. = 'Potipharis']" />
  <p:delete match="tei:note[tei:person][count(*) eq 1]" />
  <p:delete match="tei:person/tei:note[@type='bio']" />

  <xxml:clean-namespaces p:message="   ---- cleaning namespaces" />
  <xxml:remove-xinclude p:message="   ---- removing XInclude" />
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="50" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/common/xml-sort-attribute-order.xsl" />
  </p:xslt>
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$text-id}.xml"  step="55" />
  
   <p:identity />
 
 </p:declare-step>
 
</p:library>