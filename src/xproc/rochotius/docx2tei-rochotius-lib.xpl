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
 
 <p:import href="../../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="../pef-xpc-lib-base.xpl" />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:input-processing-rochotius" name="input-processing">
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

  <p:option name="text-id" as="xs:string" required="true"/>
  <p:option name="data-directory-path" as="xs:anyURI" required="true" />
  <p:option name="data-file-path" as="xs:anyURI" required="true"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)"/>
  
<!--  <p:variable name="file-stem" select="tokenize(tokenize(resolve-uri(base-uri(/), $base-uri), '/')[last()], '\.')[position() lt last()] => string-join('.')" />-->
  <p:variable name="file-stem" select="$text-id" />
  
  <p:variable name="output-temp-directory" select="if(empty($debug-path)) then () else $debug-path || '/' || $file-stem" />
  
  <!-- PIPELINE BODY -->
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/common/xml-remove-annotation-reference.xsl" />
  </p:xslt> 
  <xlog:store output-directory="{$output-temp-directory}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="1"  />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-xml-move-comment-range.xsl" />
  </p:xslt> 
  <xlog:store output-directory="{$output-temp-directory}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="5"  />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-start-comments-from-1.xsl" />
  </p:xslt> 
  <xlog:store output-directory="{$output-temp-directory}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="6"  />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-xml-fix-errors.xsl" />
  </p:xslt>   
  <xlog:store output-directory="{$output-temp-directory}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="7" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-xml-split-critical-apparatus.xsl" />
  </p:xslt>   
  <xlog:store output-directory="{$output-temp-directory}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="8" />

  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-xml-move-punctation-after-comments.xsl" />
  </p:xslt>   
  <xlog:store output-directory="{$output-temp-directory}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="9" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-xml-move-punctation-after-critical-apparatus.xsl" />
  </p:xslt>   
  <xlog:store output-directory="{$output-temp-directory}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml" step="10" />

  <p:variable name="teiHeader" select="doc($data-file-path-uri)/data[@id =$text-id]/tei:teiHeader" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-xml-to-tei.xsl" />
   <p:with-option name="parameters" select="map {'text-id' : $text-id, 'teiHeader' : $teiHeader }" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}/tei" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="1"  />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-remove-bold-from-head.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}/tei" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="2" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/input-processing/rochotius-comoedia-tei-replace-text-by-critical-apparatus.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}/tei" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="3" />
  
 
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:tei-postprocessing-rochotius" name="tei-processing">
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  <p:input  port="job-ticket" primary="false" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="text-id" as="xs:string" required="true"/>
  <p:option name="data-directory-path" as="xs:anyURI" required="true" />
  <p:option name="data-file-path" as="xs:anyURI" required="true"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="data-file-path-uri" select="resolve-uri($data-file-path, $base-uri)"/>
  
<!--  <p:variable name="file-stem" select="tokenize(tokenize(resolve-uri(base-uri(/), $base-uri), '/')[last()], '\.')[position() lt last()] => string-join('.')" />-->
  <p:variable name="file-stem" select="$text-id" />
  
  <p:variable name="output-temp-directory" select="$debug-path || '/' || $file-stem || '/' || 'tei-postprocessing'" />
  
  <xlog:log message="Postprocessing {$file-stem}" debug="{$debug}" format="text" p:use-when="false()" >
   <p:with-input port="log"><p:empty /></p:with-input>
  </xlog:log>
  
  <!-- Rochotius 1-40 × Ostatní: tei-docx-group-head.xsl -->
  <p:xslt>
   <p:documentation>Převede [A1v] ap. na element pb.</p:documentation>
   <p:with-input port="stylesheet" href="../../xslt/common/tei/tei-postprocessing/tei-add-pb.xsl" />
   <p:with-option name="parameters" select="map {'pb-regex' : '\[([A-Z]+[a-z]*\d+[rv])\]' }" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="1" />
  
  <p:delete match="tei:head[not(node())]" />
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="5" />
  
  <p:xslt>
   <p:documentation>Seskupí oddíly podle nadpisů.</p:documentation>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-group-head.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="10" />
  
  <p:xslt>
   <p:documentation>V seznamu postav (Dramatis personae) změní verše na odstavce a přesune ho do frontu.</p:documentation>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-change-dramatis-personae.xsl" />
  </p:xslt>
  <?xlog-store?>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="15" />
  
  <p:xslt>
   <p:documentation>Přesune element front před body.</p:documentation>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-move-front.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="20" />
  
  <p:xslt>
   <p:documentation>Seskupí verše do samostaných oddílů.</p:documentation>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-group-front-verses.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="25" />
  
  <p:xslt>
   <p:documentation>Seskupí verše promluvy jedné postavy do elementu sp.</p:documentation>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-add-sp.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="30" />
  
  <p:xslt>
   <p:documentation>Rozdělí oddíly na akty a scény.</p:documentation>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-group-scenes.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="35" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-reduce-indetation.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="40" />
  
  <!-- TODO: Kolcava-Veritas -->
  <!-- 
   tei-docx-group-head.xsl 
   tei-group-vertical-space.xsl 
  -->
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/common/tei/tei-postprocessing/tei-group-vertical-space.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="45" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/common/tei/tei-postprocessing//tei-clean-elements.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="50" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/common/tei/tei-postprocessing/tei-group-speeches.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="55" />
  
  <!-- TODO: + Kolcava-Veritas -->
  <!--
   kolcava-change-l-to-p.xsl
  -->
  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/common/tei/tei-postprocessing/tei-clean-elements.xsl"/>  
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="60" />
  
  <!-- TODO: + Kolcava-Veritas -->
  <!-- 
    kolcava-clean-elements.xsl
    kolcava-remove-spaces.xsl
    kolcava-move-pb.xsl
  -->
  
  <p:delete match="tei:l[not(node())]" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/common/tei/tei-postprocessing/tei-pb-add-id.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="65" />
  
  <!-- TODO: + Kolcava-Veritas -->
  <!--
   tei-assign-line-number-iterating.xsl
  -->
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-tei-fix-lemma-rdg.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="70" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/common/tei/tei-postprocessing/tei-move-pb-inside-elements.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="71" />
  
  <xpef:identify-first-verses >
   <p:with-input port="job-ticket" pipe="job-ticket@tei-processing" />
  </xpef:identify-first-verses>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="72" />

  <xpef:create-list-of-speakers doc-name="{$file-stem}" data-directory-path="{$data-directory-path}" data-file-path="{$data-file-path}" debug-path="{$debug-path}" base-uri="{$base-uri}">
   <p:with-input port="job-ticket" pipe="job-ticket@tei-processing" />
  </xpef:create-list-of-speakers>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="75" />
  
  <xd2t:person-list-postprocessing doc-name="{$file-stem}" data-directory-path="{$data-directory-path}" debug-path="{$debug-path}" base-uri="{$base-uri}">
   <p:with-input port="job-ticket" pipe="job-ticket@tei-processing" />
  </xd2t:person-list-postprocessing>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="80" />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/tei/tei-square-brackets-to-supplied.xsl"/>
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="85" />
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="xd2t:person-list-postprocessing">
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  <p:input  port="job-ticket" primary="false" />
  
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="doc-name" as="xs:string" required="true" />
  <p:option name="data-directory-path" as="xs:anyURI" required="true" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="output-temp-directory" select="$debug-path || '/' || $doc-name || '/' || 'person-list-postprocessing'" />
  <p:variable name="file-stem" select="$doc-name" />
  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-tei-identify-persons-in-list-of-persons.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="1" />
  
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../../xslt/rochotius/tei-postprocessing/rochotius-tei-merge-notes-in-list-of-persons.xsl" />
  </p:xslt>
  <xlog:store output-directory="{$output-temp-directory}" base-uri="{$base-uri}" debug="{$debug}" file-name="{$file-stem}.xml"  step="5" />
  
  
 </p:declare-step>
 
</p:library>