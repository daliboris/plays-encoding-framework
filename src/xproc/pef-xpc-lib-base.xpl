<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xpefc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/common"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:tei = "http://www.tei-c.org/ns/1.0" 
 xmlns:dxar="https://www.daliboris.cz/ns/xproc/archive"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 xmlns:dxd="https://www.daliboris.cz/ns/xproc/docx"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 version="3.0">
 
 <p:import href="../includes/docx-xpc-lib/src/xproc/docx-xpc-lib.xpl" />
 <p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="pef-xpc-lib-common.xpl" />

 <p:documentation>
  <xhtml:section>
   <xhtml:h1>Plays Encoding Framework Base Library</xhtml:h1>
   <xhtml:p />
  </xhtml:section>
 </p:documentation>

 <p:declare-step type="xpef:docx-processing" name="docx-processing">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2>input-processing</xhtml:h2>
    <xhtml:p />
   </xhtml:section>
  </p:documentation>

  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true" />
  <p:input port="ticket-in" primary="false" sequence="true">
   <p:empty />
  </p:input>

  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true" />
  <p:output port="ticket-out" primary="false" sequence="true" pipe="ticket-in@docx-processing" />

  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()" />

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />

  <p:variable name="content-type" select="p:document-property(/, 'Q{}' || 'content-type')" />
  <p:variable name="file-stem" select="tokenize(base-uri(/), '/')[last()] ! substring-before(., '.')" />
  <p:variable name="output-temp-directory" select="if($debug) then string-join(( $debug-path-uri, $file-stem, 'docx-processing'), '/')  else ()" />


  <dxd:get-ooxml-content content="document" debug-path="{$debug-path}" base-uri="{$base-uri}" />
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="1" />

  <dxd:process-revisions-ooxml operation="accept" debug-path="{$debug-path}" base-uri="{$base-uri}" />
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="5" />

  <p:xslt name="character-maps">
   <p:with-input port="stylesheet" href="../xslt/common/character-maps.xsl" />
  </p:xslt>
  <p:file-create-tempfile delete-on-exit="true" suffix=".xml" />
  <p:variable name="href-tempfile-uri" select="xs:anyURI(.)" />
  <p:store href="{$href-tempfile-uri}">
   <p:with-input pipe="result@character-maps" />
  </p:store>
  <p:load href="{$href-tempfile-uri}" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/docx/docx-remove-dracor-metadata.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="10" />

  <p:xslt name="docx-text">
   <p:with-input port="stylesheet" href="../xslt/docx/docx-document-to-text.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.txt" step="15" />


  <p:file-create-tempfile delete-on-exit="true" suffix=".txt" />
  <p:variable name="href-tempfile-uri" select="xs:anyURI(.)" />

  <p:store href="{$href-tempfile-uri}">
   <p:with-input pipe="result@docx-text" />
  </p:store>

  <p:xslt template-name="xsl:initial-template">
   <p:with-input port="stylesheet" href="../xslt/docx/text-clean-lines.xsl" />
   <p:with-option name="parameters" select="map {'href' : $href-tempfile-uri }" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="20" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/common/xml-fix-common-text-errors.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="25" />



  <!-- 
  <p:text-replace pattern="^\d+[\s\t]+" replacement="" flags="m"/>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.txt"  step="15" />
  
  <p:text-replace pattern="^[\s\t]+" replacement="" flags="m"/>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.txt"  step="20" />
   -->
 </p:declare-step>

 <p:declare-step type="xpef:input-processing" name="input-processing" xpl:step-type="abstract">

  <p:documentation>
   <xhtml:section>
    <xhtml:h2>input-processing</xhtml:h2>
    <xhtml:p />
   </xhtml:section>
  </p:documentation>

  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true" />
  <p:input port="ticket-in" primary="false" sequence="true">
   <p:empty />
  </p:input>

  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true" />
  <p:output port="ticket-out" primary="false" sequence="true" pipe="ticket-in@input-processing" />

  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()" />

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="content-type" select="p:document-property(/, 'Q{}' || 'content-type')" />

  <p:choose>
   <p:when test="$content-type = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'">
    <dxd:docx-to-xml clean-markup="true" keep-direct-formatting="true" debug-path="{$debug-path}" base-uri="{$base-uri}" />
   </p:when>
  </p:choose>

  <p:identity />

 </p:declare-step>

 <p:declare-step type="xpef:xml-processing" name="xml-processing" xpl:step-type="abstract">

  <p:documentation>
   <xhtml:section>
    <xhtml:h2>xml-processing</xhtml:h2>
    <xhtml:p />
   </xhtml:section>
  </p:documentation>

  <!-- Input ports -->
  <p:input port="source" primary="true" sequence="true" />
  <p:input port="ticket-in" primary="false" sequence="true">
   <p:empty />
  </p:input>

  <!-- Output ports -->
  <p:output port="result" primary="true" sequence="true" />
  <p:output port="ticket-out" primary="false" sequence="true" pipe="ticket-in@xml-processing" />

  <!-- Options -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()" />

  <!-- 
  <xpef:xml-conversion />
  <xpef:xml-preprocessing />
  <xpef:xml-block-processing />
  <xpef:xml-inline-processing />
  <xpef:xml-postprocessing />
   -->

  <p:identity />

 </p:declare-step>

 <p:declare-step type="xpef:identify-first-verses" name="identifying-first-verses">
  <p:input port="source" primary="true" />
  <p:input port="job-ticket" primary="false" />


  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  <p:output port="job-ticket-out" primary="false" pipe="job-ticket@identifying-first-verses" />

  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/common/tei/tei-postprocessing/tei-identify-first-verses.xsl" />
  </p:xslt>

 </p:declare-step>

 <p:declare-step type="xpef:create-list-of-speakers" name="creating-list-of-speakers">
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" />
  <p:input port="job-ticket" primary="false" />


  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />

  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()" />

  <p:option name="doc-name" as="xs:string" required="true" />
  <p:option name="data-directory-path" as="xs:anyURI" required="true" />
  <p:option name="data-file-path" as="xs:anyURI" required="true" />

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="line-numbers-file-path" select="concat($data-directory-path, '/local.', $doc-name, '-line-numbers.xml')" />
  <p:variable name="line-numbers-file-path-uri" select="resolve-uri($line-numbers-file-path, $base-uri)" />
  <p:variable name="output-temp-directory" select="$debug-path || '/' || $doc-name || '/' || 'create-list-of-speakers'" />

  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)" />

  <p:variable name="file-stem" select="$doc-name" />
  <p:variable name="listPerson-in-data-file-exists" select="doc($data-file-path-uri)/data/tei:listPerson[1][tei:person]" />

  <p:identity name="original" message="   ... tei-assign-line-number: {base-uri(/)}" />


  <p:choose>
   <p:when test="$listPerson-in-data-file-exists">

    <p:identity message=" ---- loading {$data-file-path-uri}">
     <p:with-input port="source" href="{$data-file-path-uri}" />
    </p:identity>

    <p:xslt>
     <p:with-input port="source" pipe="source@creating-list-of-speakers" />
     <p:with-input port="stylesheet" href="../xslt/common/tei-assign-line-number-iterating.xsl" />
     <p:with-option name="parameters" select="map {
     'line-numbers-file-path' : $data-file-path-uri
     }" />
    </p:xslt>

   </p:when>
   <p:otherwise>
    <p:xquery message=" ---- applying tei-assign-line-number.xquery">
     <p:with-input port="query" href="../xquery/tei-assign-line-number.xquery" />
    </p:xquery>
    <p:store href="{$line-numbers-file-path-uri}" message=" ---- storing {$line-numbers-file-path-uri}" />

    <p:xslt>
     <p:with-input port="source" pipe="source@creating-list-of-speakers" />
     <p:with-input port="stylesheet" href="../xslt/common/tei-assign-line-number-iterating.xsl" />
     <p:with-option name="parameters" select="map {
     'line-numbers-file-path' : $line-numbers-file-path-uri
     }" />
    </p:xslt>
   </p:otherwise>
  </p:choose>



  <p:viewport match="tei:TEI" name="play-text">

   <p:choose>
    <p:when test="$listPerson-in-data-file-e
     xists">
     <p:load href="{$data-file-path-uri}" />     
    </p:when>
    <p:otherwise>
     <p:load href="{$line-numbers-file-path}" />
    </p:otherwise>
   </p:choose>

   <p:filter select="/data/tei:listPerson[1]" name="person-list" />

   <p:replace match="tei:listPerson">
    <p:with-input port="source" pipe="current@play-text" />
    <p:with-input port="replacement" pipe="@person-list" />
   </p:replace>

  </p:viewport>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="1" />


  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/common/tei-add-who-to-sp.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="5" />

  <xpefc:add-persName-to-speaker p:message="Adding persName to speaker" name="corpus" />
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="10" />


 </p:declare-step>

 <p:declare-step type="xpef:remove-xinclude" name="removing-xinclude">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2>input-processing</xhtml:h2>
    <xhtml:p />
   </xhtml:section>
  </p:documentation>

  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true" />
  <p:input port="ticket-in" primary="false" sequence="true">
   <p:empty />
  </p:input>

  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true" />
  <p:output port="ticket-out" primary="false" sequence="true" pipe="ticket-in@removing-xinclude" />

  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()" />

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/common/xml-remove-xinclude.xsl" />
  </p:xslt>

 </p:declare-step>


</p:library>
