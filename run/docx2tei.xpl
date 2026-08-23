<p:declare-step  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xd2t="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei"
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xtei="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei"
 xmlns:xpefjt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/job-ticket"
 xmlns:xevt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 name="docx2tei"
 version="3.0">
 
 <p:import href="../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="../src/xproc/docx2tei-lib.xpl" />
 <p:import href="../src/xproc/rochotius/docx2tei-rochotius-lib.xpl" />
 <p:import href="../src/xproc/tei-play-lib.xpl" />
 <p:import href="../src/xproc/evt-play-lib.xpl" />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- INPUT PORTS -->
 <p:input  port="source" primary="true" href="../src/input/text/docx/theatrum-neolatinum/rochotius-iosephiados-comoedia.docx" />
 <!-- <p:input  port="source" primary="true" href="../src/input/text/docx/Rochotius_JC_edice_digitalni-2024-11-19.docx" content-type="application/json"  />-->
 <p:input  port="job-ticket" primary="false" href="../data/rochotius-iosephiados-comoedia/rochotius-iosephiados-comoedia.ticket.xml" />
 
 
 <!-- OUTPUT PORTS -->
 <p:output port="result" primary="true" />

 <!-- OPTIONS -->
 <p:option name="debug-path" select="'../_debug'" as="xs:string?" />
 <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
 <p:option name="data-directory-path" as="xs:anyURI"  select="'../data/rochotius-iosephiados-comoedia'" />
 <p:option name="data-file-path" as="xs:string" select="'../data/rochotius-iosephiados-comoedia/local.rochotius-iosephiados-comoedia.data.xml'" />
 <p:option name="output-directory-path" as="xs:string?" select="'../output'" />
 <p:option name="output-file-name" as="xs:string?" select="'rochotius-iosephiados-comoedia'"  />
 
 <!-- VARIABLES -->
 <p:variable name="debug" select="$debug-path || '' ne ''" />
 <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
 <p:variable name="steps" select="/xpefjt:job-ticket/xpefjt:scenario/xpefjt:step" pipe="job-ticket@docx2tei" />
 
 <p:variable name="text-id" select="/data/@id" href="{$data-file-path}" />
 
 <p:variable name="source-debug-path" select="if(empty($debug-path)) then () else $debug-path ||  '/' || $text-id" />
 
 <!-- PIPELINE BODY -->
 <p:choose>
  <p:when test="$steps[@name='xd2t:input-processing']">
   <xd2t:input-processing debug-path="{$source-debug-path}" base-uri="{$base-uri}" data-directory-path="{$data-directory-path}" />
   <xlog:store output-directory="{$debug-path}/{$text-id}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="1" />
  </p:when> 
 </p:choose>

 <p:choose>
  <p:when test="$steps[@name='xd2t:input-processing-rochotius']">
   <xd2t:input-processing-rochotius debug-path="{$source-debug-path}" base-uri="{$base-uri}" data-directory-path="{$data-directory-path}" data-file-path="{$data-file-path}" text-id="{$text-id}" />
   <xlog:store output-directory="{$debug-path}/{$text-id}/input-processing" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="2" />
  </p:when> 
 </p:choose>
 
 <p:choose>
  <p:when test="$steps[@name='xd2t:tei-processing-rochotius']">
   <xd2t:tei-processing-rochotius debug-path="{$source-debug-path}" base-uri="{$base-uri}" 
    data-directory-path="{$data-directory-path}" 
    data-file-path="{$data-file-path}" 
    text-id="{$text-id}">
    <p:with-input port="job-ticket" pipe="job-ticket@docx2tei" />
   </xd2t:tei-processing-rochotius>
   <xlog:store output-directory="{$debug-path}/{$text-id}/tei-processing-rochotius" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="1" />
  </p:when> 
 </p:choose>
 
 <p:choose>
  <p:when test="$steps[@name='xd2t:tei-postprocessing-rochotius']">
   <xd2t:tei-postprocessing-rochotius debug-path="{$source-debug-path}" base-uri="{$base-uri}" 
    data-directory-path="{$data-directory-path}" 
    data-file-path="{$data-file-path}" 
    text-id="{$text-id}">
    <p:with-input port="job-ticket" pipe="job-ticket@docx2tei" />
   </xd2t:tei-postprocessing-rochotius>
   <xlog:store output-directory="{$debug-path}/{$text-id}/tei-postprocessing-rochotius" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="1" />
  </p:when> 
 </p:choose>
 
 <p:choose>
  <p:when test="$steps[@name='xd2t:tei-postprocessing']">
   <xd2t:tei-postprocessing debug-path="{$source-debug-path}" base-uri="{$base-uri}" 
    data-directory-path="{$data-directory-path}" 
    data-file-path="{$data-file-path}" 
    text-id="{$text-id}">
    <p:with-input port="job-ticket" pipe="job-ticket@docx2tei" />
   </xd2t:tei-postprocessing>
   <xlog:store output-directory="{$debug-path}/{$text-id}/tei-postprocessing-rochotius" base-uri="{$base-uri}" debug="{$debug}" file-name="{$output-file-name}.xml" step="1" />
  </p:when> 
 </p:choose>
 
 <p:identity name="tei" />
 
 <xlog:store output-directory="{$output-directory-path}/{$text-id}/tei" base-uri="{$base-uri}" debug="true" file-name="{$output-file-name}.xml" />

 <p:variable name="dracor-file-stem" select="if(/data/dracor/@file-stem) then /data/dracor/@file-stem else $output-file-name" href="{$data-file-path}" />
 
 <p:group xmlns:p="http://www.w3.org/ns/xproc" use-when="false()">
  <p:identity message="========================"/>
  <p:identity message="|:-    docx2tei    -:|"/>
  <p:identity message="   ::  option  $debug-path = {$debug-path}  :: "/>
  <p:identity message="   ::  option  $base-uri = {$base-uri}  :: "/>
  <p:identity message="   ::  option  $data-directory-path = {$data-directory-path}  :: "/>
  <p:identity message="   ::  option  $data-file-path = {$data-file-path}  :: "/>
  <p:identity message="   ::  option  $output-directory-path = {$output-directory-path}  :: "/>
  <p:identity message="   ::  option  $output-file-name = {$output-file-name}  :: "/>
  <p:identity message="   ::  variable  $debug = {$debug}  :: "/>
  <p:identity message="   ::  variable  $debug-path-uri = {$debug-path-uri}  :: "/>
  <p:identity message="   ::  variable  $steps = {$steps}  :: "/>
  <p:identity message="   ::  variable  $text-id = {$text-id}  :: "/>
  <p:identity message="   ::  variable  $source-debug-path = {$source-debug-path}  :: "/>
  <p:identity message="   ::  variable  $dracor-file-stem = {$dracor-file-stem}  :: "/>
  <p:identity message="========================"/>
 </p:group>
 
 <xtei:convert
  output-directory-path="{$output-directory-path}/{$text-id}/evt" 
  data-file-path="{$data-file-path}"
  text-id="{$text-id}"
  debug-path="{if($debug) then $debug-path || '/' || $text-id || '/convert/evt' else ()}" 
  base-uri="{$base-uri}" 
  output-file-name="{$output-file-name}" target="EVT">
  <p:with-input port="source" pipe="result@tei" />
 </xtei:convert>
 <p:identity name="evt" />
 <xlog:store p:use-when="false()" output-directory="{$output-directory-path}/{$text-id}/evt" base-uri="{$base-uri}" debug="true" file-name="{$dracor-file-stem}.xml" />
 
 <xevt:validate-hierarchies output-directory-path="{$output-directory-path}/{$text-id}/evt" 
  data-file-path="{$data-file-path}"
  debug-path="{if($debug) then $debug-path || '/' || $text-id || '/convert/evt' else ()}" 
  base-uri="{$base-uri}" 
  output-file-name="{$text-id}-hierarchies.html" />
 
 <xtei:convert 
  output-directory-path="{$output-directory-path}" 
  data-file-path="{$data-file-path}"
  text-id="{$text-id}"
  debug-path="{if($debug) then $debug-path || '/' || $text-id || '/convert/dracor' else ()}" 
  base-uri="{$base-uri}" 
  output-file-name="{$output-file-name}" target="DraCor">
  <p:with-input port="source" pipe="result@tei" />
 </xtei:convert>
 <xlog:store output-directory="{$output-directory-path}/{$text-id}/dracor" base-uri="{$base-uri}" debug="true" file-name="{$dracor-file-stem}.xml"  p:use-when="false()"/>
   <p:store href="{p:urify($output-directory-path, $base-uri)}/{$text-id}/dracor/{$dracor-file-stem}.xml"
         serialization="map { 'encoding' : 'utf-8', 'indent' : true(), 'undeclare-prefixes' : true()}" />

 <xtei:convert 
  output-directory-path="{$output-directory-path}" 
  data-file-path="{$data-file-path}" 
  debug-path="{if($debug) then $debug-path || '/' || $text-id || '/convert/text' else ()}" 
  base-uri="{$base-uri}" 
  text-id="{$text-id}"
  output-file-name="{$output-file-name}" target="text">
  <p:with-input port="source" pipe="result@tei" />
 </xtei:convert>
 <xlog:store output-directory="{$output-directory-path}/{$text-id}/text" base-uri="{$base-uri}" debug="true" file-name="{$output-file-name}-tei.xml" />

 <xd2t:convert target="text" debug-path="{$debug-path}" base-uri="{$base-uri}">
  <p:with-input port="source" pipe="source@docx2tei" />
 </xd2t:convert>
 <xlog:store output-directory="{$output-directory-path}/{$text-id}/text" base-uri="{$base-uri}" debug="true" file-name="{$output-file-name}-docx.xml" />

 <xd2t:tei-conversion debug-path="{$debug-path}" base-uri="{$base-uri}" data-file-path="{$data-file-path}" name="tei" p:use-when="false()" />
 
 <p:identity>
  <p:with-input port="source" pipe="report" />
 </p:identity>
 
</p:declare-step>