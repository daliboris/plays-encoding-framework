<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xps="https://www.daliboris.cs/ns/xproc/project/setup"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	version="3.0">
	
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

	<!-- STEP -->
	<p:declare-step type="xps:create-directories">

		<p:file-mkdir href="../../doc" />
		<p:file-mkdir href="../../run" />
		
		
		<p:file-mkdir href="../_debug" />
		<p:file-mkdir href="../_temp" />
		
		<p:file-mkdir href="../etalon" />
		<p:file-mkdir href="../schema/schematron" />
		<p:file-mkdir href="../schema/xsd" />
		<p:file-mkdir href="../schema/rng" />
		<p:file-mkdir href="../settings" />
		<p:file-mkdir href="../morgana" />
		<p:file-mkdir href="../tests" />
		
		<p:file-mkdir href="../input/text/docx" />
		<p:file-mkdir href="../input/text/xml" />
		<p:file-mkdir href="../output/text/tei" />
		
		<p:file-mkdir href="../xslt" />
		<p:file-mkdir href="../xquery" />
		
	</p:declare-step>

	<!-- STEP -->
	
	<p:declare-step type="xps:create-gitignore">
	<p:file-info href="../../.gitignore" fail-on-error="false" />
	<p:variable name="file-exists" select="exists(/c:file)"  />

		<p:if test="not($file-exists)" message="File .gitignore exists: {$file-exists}">
			<p:store href="../../.gitignore" serialization="map { 'method' : 'text'}">
		<p:with-input>
			<p:inline content-type="text/plain" xml:space="preserve">
# directories with temporary files
_debug
_temp

# editor settings and directories
.vscode
.vs
*.code-workspace

# local files with local settings
*local*
			</p:inline>
		</p:with-input>
	</p:store>	
</p:if>
		
	</p:declare-step>

	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />


	<!-- PIPELINE BODY -->
	

	<xps:create-directories />
	<xps:create-gitignore />
	
	<p:directory-list path="../" max-depth="unbounded" />
	

</p:declare-step>
