<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xps="https://www.daliboris.cs/ns/xproc/project/setup"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	version="3.0">
	
	<p:import href="../src/xproc/setup-lib.xpl" />
	
	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
   
  
	<!-- OUTPUT PORTS -->
	<p:output port="result" primary="true" serialization="map{'indent': true()}" />
	
	
	<!-- OPTIONS -->
	<p:option name="debug-path" select="()" as="xs:string?" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>

	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />


	<!-- PIPELINE BODY -->
	
<!-- 
	<xps:create-directories />
	<xps:create-gitignore />
	
	
	<p:directory-list path="../" max-depth="unbounded" />
-->
	<xps:download-schemas />
	<xps:download-morgana version="1.6.7" />
	<xps:download-saxon version="12-7" />
	<!--<p:directory-list path="../" max-depth="unbounded" />-->
	
	
	

</p:declare-step>
