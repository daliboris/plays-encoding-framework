<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xd2t="https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei"
	xmlns:xpef="https://www.daliboris.cz/ns/xproc/plays-encoding-framework"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
	version="3.0">
	
	<p:import href="../src/includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />
	<p:import href="../src/xproc/docx2tei-lib.xpl" />
	
	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
   
	<!-- INPUT PORTS -->
	<p:input  port="source" primary="true" href="../src/input/text/docx/test/Rochotius-Comoedia-sample.docx" />
   
	<!-- OUTPUT PORTS -->
	<p:output port="result" primary="true" />
	
	<!-- OPTIONS -->
	<p:option name="debug-path" select="'../_debug'" as="xs:string?" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
	
	<p:option name="output-directory-path" as="xs:string?" select="'../_output'" />
	<p:option name="output-file-name" as="xs:string?" select="'rochotius-comoedia'"  />
	
	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<!-- PIPELINE BODY -->
	<xd2t:convert target="text" debug-path="{$debug-path}" base-uri="{$base-uri}" />
	<xlog:store output-directory="{$output-directory-path}/{$output-file-name}/text" base-uri="{$base-uri}" debug="true" file-name="{$output-file-name}-docx.xml" />
	

</p:declare-step>
