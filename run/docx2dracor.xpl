<p:declare-step  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xd2dc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor"
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xtei="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei"
 xmlns:xpefjt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/job-ticket"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 xmlns:dxfs="https://www.daliboris.cz/ns/xproc/file-system" 
 xmlns:fs="https://www.daliboris.cz/ns/file-system"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 name="docx2dracor"
 version="3.0">
 
 <p:import href="../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="../src/xproc/docx2dracor-lib.xpl" />
 <p:import href="../src/xproc/tei-play-lib.xpl" />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- INPUT PORTS -->
<!-- <p:input  port="source" primary="true" href="../src/input/text/docx/dracor/Metadata_table.docx" sequence="true" />-->
<!-- <p:input  port="source" primary="true" href="../src/input/text/docx/dracor/Metadata_table.docx" sequence="true" />-->
<!-- <p:input  port="source" primary="true" href="../src/input/text/docx/dracor/Lummenaeus-Saul.docx" sequence="true" />-->
 <p:input  port="source" primary="true" href="../src/input/text/docx/dracor/Placentius-Susanna.docx" sequence="true" />
<!-- <p:input  port="source" primary="true" href="../src/input/text/docx/dracor/Gnapheus-Acolastus_markup_v5.docx" sequence="true" />-->
 <p:input  port="job-ticket" primary="false" href="../data/translatin-ticket.xml" />
 
 
 <!-- OUTPUT PORTS -->
 <p:output port="result" primary="true" />

 <!-- OPTIONS -->
 <p:option name="debug-path" select="'../_debug'" as="xs:string?" />
 <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>

 <p:option name="data-directory-path" as="xs:anyURI"  select="'../data'" />
 <p:option name="data-file-path" as="xs:string" select="'../data/rochotius-ticket.xml'" />
 
 <p:option name="innput-directory-path" select="'../src/input/text/docx/dracor'" as="xs:string?" />
 <p:option name="output-directory-path" as="xs:string?" select="'../_output'" />
<!-- <p:option name="output-file-name" as="xs:string?" select="'Gnapheus-Acolastus'"  />-->
 <p:option name="output-file-name" as="xs:string?" select="()"  />
 
 <!-- VARIABLES -->
 <p:variable name="debug" select="$debug-path || '' ne ''" />
 <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
 <p:variable name="steps" select="/xpefjt:job-ticket/xpefjt:scenario/xpefjt:step" pipe="job-ticket@docx2dracor" />

 <dxfs:document-file-info name="info" />
 
 <p:variable name="file-stem" select="/fs:file/@stem" pipe="report@info" />

 <p:variable name="output-file-name" select="if(empty($output-file-name)) then $file-stem else $output-file-name" />
 
 <p:variable name="text-id" select="/data/@id" href="{$data-file-path}" />
 
 <p:variable name="source-debug-path" select="if(empty($debug-path)) then () else $debug-path ||  '/' || $text-id" />
 
 <!-- PIPELINE BODY -->
 <p:choose>
  <p:when test="$steps[@name='xd2dc:input-processing']">
   <xd2dc:input-processing debug-path="{$source-debug-path}" base-uri="{$base-uri}" data-directory-path="{$data-directory-path}" />
   <xlog:store output-directory="{$debug-path}/{$text-id}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="1" />
  </p:when> 
 </p:choose>

 <p:choose>
  <p:when test="$steps[@name='xd2dc:tei-processing']">
   <xd2dc:tei-processing debug-path="{$source-debug-path}" base-uri="{$base-uri}" 
    data-directory-path="{$data-directory-path}" 
    data-file-path="{$data-file-path}" 
    text-id="{$text-id}">
    <p:with-input port="job-ticket" pipe="job-ticket@docx2dracor" />
   </xd2dc:tei-processing>
   <xlog:store output-directory="{$debug-path}/{$text-id}/tei-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="1" />
  </p:when> 
 </p:choose>

 <p:choose use-when="false()">
  <p:when test="$steps[@name='xd2dc:tei-postprocessing']">
   <xd2dc:tei-postprocessing debug-path="{$source-debug-path}" base-uri="{$base-uri}" 
    data-directory-path="{$data-directory-path}" 
    data-file-path="{$data-file-path}" 
    text-id="{$text-id}">
    <p:with-input port="job-ticket" pipe="job-ticket@docx2dracor" />
   </xd2dc:tei-postprocessing>
   <xlog:store output-directory="{$debug-path}/{$text-id}/tei-postprocessing-rochotius" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="1" />
  </p:when> 
 </p:choose>
 
 <xpef:remove-xinclude debug-path="{$source-debug-path}" base-uri="{$base-uri}">
  <p:with-input port="ticket-in" pipe="job-ticket@docx2dracor" />
 </xpef:remove-xinclude>
 <p:identity name="tei" />
 
 <xlog:store output-directory="{$output-directory-path}/{$text-id}/tei" base-uri="{$base-uri}" debug="true" file-name="{$output-file-name}.xml" />

 <xtei:convert 
  output-directory-path="{$output-directory-path}" 
  data-file-path="{$data-file-path}" 
  debug-path="{$debug-path}" 
  base-uri="{$base-uri}" 
  output-file-name="{$output-file-name}" target="text">
  <p:with-input port="source" pipe="result@tei" />
 </xtei:convert>
 <xlog:store output-directory="{$output-directory-path}/{$text-id}/text" base-uri="{$base-uri}" debug="true" file-name="{$output-file-name}-tei.xml" />

 <xd2dc:convert target="text" debug-path="{$debug-path}" base-uri="{$base-uri}">
  <p:with-input port="source" pipe="source@docx2dracor" />
 </xd2dc:convert>
 <xlog:store output-directory="{$output-directory-path}/{$text-id}/text" base-uri="{$base-uri}" debug="true" file-name="{$output-file-name}-docx.xml" />

 <p:identity>
  <p:with-input port="source" pipe="report" />
 </p:identity>
 
</p:declare-step>