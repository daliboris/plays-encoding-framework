<p:declare-step  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xh2t="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/hub2tei"
 xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
 xmlns:xevt="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt"
 xmlns:xdc="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/dracor"
 xmlns:xpl="https://www.daliboris.cz/ns/xproc/pipeline"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
 <p:import href="../src/xproc/pef-xpc-lib-base.xpl" />
 <p:import href="../src/xproc/hub2tei-lib.xpl" />
 <p:import href="../src/xproc/evt-play-lib.xpl" />
 <p:import href="../src/xproc/dracor-lib.xpl" />
 
 <!-- INPUT PORTS -->
 <p:input  port="source" primary="true" href="../input/text/hub/local.nepomuk-02.xml" />
 
 
 <!-- OUTPUT PORTS -->
 <p:output port="result" primary="true" />
 
 <!-- OPTIONS -->
 <p:option name="debug-path" select="'../_debug'" as="xs:string?" />
 <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
 <p:option name="data-file-path" as="xs:string?" select="'../data/angelus-02-data.xml'" />
 <p:option name="output-directory-path" as="xs:string?" select="'../output'" />
 <p:option name="output-file-name" as="xs:string?" select="'angelus'"  />
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <p:declare-step type="xh2t:process">
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
  <p:option name="output-directory-path" as="xs:string?" />
  <p:option name="output-file-name" as="xs:string?" />
  
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <xh2t:input-processing data-file-path="{$data-file-path}"  debug-path="{$debug-path}" base-uri="{$base-uri}" />
  <xh2t:tei-conversion data-file-path="{$data-file-path}" debug-path="{$debug-path}" base-uri="{$base-uri}" name="tei" />
  
  <xdc:tei-to-dracor data-file-path="{$data-file-path}" debug-path="{$debug-path}" base-uri="{$base-uri}">
   <p:with-input pipe="@tei" />
  </xdc:tei-to-dracor>
  
  <xevt:tei-to-evt 
    output-directory-path="{$output-directory-path}/evt" 
    data-file-path="{$data-file-path}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}" name="evt">
   <p:with-input pipe="@tei" />
  </xevt:tei-to-evt>
  <xevt:validate-hierarchies 
    output-directory-path="{$output-directory-path}/validation"
    output-file-name="{$output-file-name}"
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
   <p:with-input pipe="@tei" />
  </xevt:validate-hierarchies>
  
  <xevt:zip output-directory-path="{$data-file-path}" debug-path="{$debug-path}" base-uri="{$base-uri}">
   <p:with-input pipe="@tei" />
  </xevt:zip>
 
 
 </p:declare-step>
 
 <!-- VARIABLES -->
 <p:variable name="debug" select="$debug-path || '' ne ''" />
 <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
 
 
 <!-- PIPELINE BODY -->
 
 <xh2t:process data-file-path="{$data-file-path}" 
  output-directory-path="{$output-directory-path}"
  output-file-name="{$output-file-name}"
  debug-path="{$debug-path}" base-uri="{$base-uri}"/>
 <p:identity>
  <p:with-input select="base-uri(/)" />
 </p:identity>
 
</p:declare-step>