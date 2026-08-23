<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:hub="http://docbook.org/ns/docbook"
 xmlns:css="http://www.w3.org/1996/css"
 xmlns:xd2t="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei"
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xevt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt"
 xmlns:xtei="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:dxfs="https://www.daliboris.cz/ns/xproc/file-system"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:fs="https://www.daliboris.cz/ns/file-system"
 xmlns:xxml="https://www.daliboris.cz/ns/xproc/xml"
 xmlns:tei = "http://www.tei-c.org/ns/1.0" 
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="../includes/file-system-xpc-lib/src/xproc/file-system-xpc-lib.xpl" />
 <p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="pef-xpc-lib-base.xpl" />
 <p:import href="tei-play-lib.xpl" />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:input-processing" name="input-processing">
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
  <p:option name="data-directory-path" as="xs:anyURI?"  required="false" />
  <p:option name="data-file-path" as="xs:string?" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <dxfs:document-file-info name="info" />
  <p:variable name="file" select="/fs:file" pipe="report@info" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <p:variable name="log-output-directory" select="if(empty($debug-path)) then () else $debug-path || '/docx2tei/' || $file/@stem" />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />
  
  <!-- PIPELINE BODY -->
  <xpef:input-processing debug-path="{$debug-path}" base-uri="{$base-uri}" />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />
  
  <!-- Apply replacements, save the result and reload it to be applied -->
  <p:xslt name="character-maps">
   <p:with-input port="stylesheet" href="../xslt/common/character-maps.xsl" />
  </p:xslt>
  <p:file-create-tempfile delete-on-exit="true" suffix=".xml"/>
  <p:variable name="href-tempfile-uri" select="string(.)"/>
  <p:store href="{$href-tempfile-uri}">
   <p:with-input pipe="result@character-maps"/>
  </p:store>
  <p:load href="{$href-tempfile-uri}" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl" />
   <p:with-option name="parameters" select="map {'phase' : 1 }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2"  />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl" />
   <p:with-option name="parameters" select="map {'phase' : 2 }" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="3" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-clean-element-names.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="4" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx2tei/xml/xml-fix-element-combinations.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:tei-conversion" name="tei-conversion">
  
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
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <dxfs:document-file-info name="info" />
  <p:variable name="file" select="/fs:file" pipe="report@info" />
  
  <p:variable name="log-output-directory" select="$debug-path || '/docx2tei/' || $file/@stem || '/teiCorpus'" />
  <p:variable name="log-file-name" select="$file/@stem || '.xml'" />

  <xxml:clean-namespaces />

  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="22" />
    
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:tei-postprocessing" name="tei-postprocessing">
  
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  <p:input  port="job-ticket" primary="false" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="data-file-path" as="xs:string?" />
  <p:option name="data-directory-path" as="xs:anyURI" required="true" />
  <p:option name="text-id" as="xs:string" required="true"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />

  <p:variable name="log-output-directory" select="$debug-path || '/' || $text-id || '/' || 'tei-postprocessing/'" />
  <p:variable name="log-file-name" select="$text-id || '.xml'" />
  
  <!-- PIPELINE BODY -->
  
  <p:delete match="tei:div[not(node())]" />

  <!--<p:variable name="personGrps" select="tokenize(/data/persons/females, '[,\s]+')[.]" href="{$data-file-path-uri}"/>-->
  <p:variable name="personGrps" select="'(&#34;' || replace(/data/persons/personGrp, ',\s+', '&#34;, &#34;') || '&#34;)'" href="{$data-file-path-uri}"/>
  <p:variable name="persNames" select="//tei:listPerson/tei:person[tei:persName[. = $personGrps]]"/>
  <p:rename match="tei:listPerson/tei:person[tei:persName[. = {$personGrps}]]" new-name="tei:personGrp" message="   ---- changing tei:person to tei:personGrp: {string-join($personGrps, '; ')}; $persNames: {count($persNames)} "/>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="1" />

  <p:rename match="tei:listPerson/tei:personGrp/tei:persName" new-name="tei:name" message="   ---- changing tei:personGrp/tei:persName to tei:name"/>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="2" />
  

  <!--<p:variable name="females" select="tokenize(/data/persons/females, '[,\s]+')[.]" href="{$data-file-path-uri}"/>-->
  <p:variable name="females" select="'(&#34;' || replace(/data/persons/females, ',\s+', '&#34;, &#34;') || '&#34;)'" href="{$data-file-path-uri}"/>
  <p:variable name="persNames" select="//tei:listPerson/tei:person[tei:persName[. = $females]]"/>
  <p:add-attribute match="tei:listPerson/tei:person[tei:persName[. = {$females}]]" attribute-name="sex" attribute-value="FEMALE" message="   ---- replacing females : {string-join($females, '; ')}; $persNames: {count($persNames)} " />
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="5" />
  
  <p:variable name="deletes" select="'(&#34;' || replace(/data/persons/delete, ',\s+', '&#34;, &#34;') || '&#34;)'" href="{$data-file-path-uri}"/>
  <p:variable name="persNames" select="//tei:listPerson/tei:person[tei:persName[. = $deletes]]"/>
  <p:delete match="tei:listPerson/tei:person[tei:persName[. = {$deletes}]]" message="   ---- deleting false persons : {string-join($deletes, '; ')}; $persNames: {count($persNames)}"></p:delete>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="10" />


  <p:variable name="replace-ids" select="/data/persons/replace-ids/replace" href="{$data-file-path-uri}" />
  <p:if test="$replace-ids">
   <p:xslt message="replacing-ids: {string-join($replace-ids/@from, '; ')}">
    <p:with-input port="stylesheet" href="../xslt/common/tei/tei-postprocessing/tei-replace-ids.xsl" />
    <p:with-option name="parameters" select="map {'replace-ids' : $replace-ids }" />
   </p:xslt>
   <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="15" />
  </p:if>

  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/common/tei/tei-postprocessing/tei-sort-listPerson.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="20" />
  
  <p:documentation>
   <p>Přiřazení obrázků ke stranám.</p>
   <p>Vytvoří se element <b>facsimile</b> se seznamem souborů s obrázky jednotlivých stran.</p>
   <p>V elementu <b>pb</b> se vytvří atrubut <b>@facs</b> s odkazem na soubor s obrázkem odpovídající strany.</p>
   <p>Jako parametry lze nastavit:</p>
   <ul>
    <li><i>path</i>: výchozí cestu k souborům (musí končit lomítkem);</li>
    <li><i>extension</i>: přípponá souborů (bez úvodní tečky)</li>
   </ul>
   <p>Jméno se generuje z identifikátoru elementu <b>pb</b> přidáním výchozí cesty a přípony.</p>
  </p:documentation>
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/tei/tei-add-facsimile.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="25" />
  
  <xxml:clean-namespaces />
  
  <xlog:store output-directory="{$log-output-directory}" base-uri="{$base-uri}" file-name="{$log-file-name}" debug="{$debug}" step="30" />
  
 </p:declare-step>

 <!-- STEP -->
 <p:declare-step type="xd2t:convert" name="conversion">
  
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
  <p:option name="target" as="xs:string*" values="('TEI', 'text')" />
  <p:option name="data-file-path" as="xs:string?" />
  
  <!-- PIPELINE BODY -->
  <p:choose>
   <p:when test="$target='TEI'">
    <xd2t:tei-conversion debug-path="{$debug-path}" base-uri="{$base-uri}" data-file-path="{$data-file-path}"/>
   </p:when>
  </p:choose>
  
  <p:choose>
   <p:when test="$target='text'">
    <xpef:docx-processing debug-path="{$debug-path}" base-uri="{$base-uri}"/>
   </p:when>
  </p:choose>
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:docx-to-text" use-when="false()">
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
  
  <!-- PIPELINE BODY -->
  
  
 </p:declare-step>

</p:library>