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
	
	<p:option name="saxon-version" as="xs:string" select="'12.3'" />
	<p:option name="morgana-version" as="xs:string" select="'1.6.4'" />

	<!-- STEP -->
	<p:declare-step type="xps:create-directories">

		<p:file-mkdir href="../../doc" />
		<p:file-mkdir href="../../run" />
		
		<p:file-mkdir href="../../input/text/docx" />
		<p:file-mkdir href="../../input/text/hub" />
		<p:file-mkdir href="../../input/text/tei" />
		<p:file-mkdir href="../../output" />
		
		
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
		<p:file-mkdir href="../input/text/hub" />
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
	
	<!-- STEP -->
	<p:declare-step type="xps:download-morgana">
		<p:input port="source" sequence="true">
			<p:empty />
		</p:input>
		<p:output port="result" sequence="true" />
		
		<!-- OPTIONS -->
		<p:option name="version" as="xs:string" required="true"  />
		
		<!-- VARIABLES -->
		<p:variable name="file-name" select="'MorganaXProc-IIIse-' || $version || '.zip'" />		
		<!--		<p:variable name="file-name" select="'winmerge-2.16.38-x64-exe' || '.zip'" />		-->
		
		<p:file-info href="../morgana/{$file-name}" fail-on-error="false" />
		<p:variable name="file-exists" select="exists(/c:file)"  />
		
		<p:if test="not($file-exists)" message="File {$file-name} exists: {$file-exists}">
			<p:http-request href="https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-{$version}/{$file-name}/download" message="Downloading Morgana IIIse" />
			<p:store href="../morgana/{$file-name}" />			
		</p:if>
		
		<p:load href="../morgana/{$file-name}" />
		<!--		<p:archive-manifest message="{$file-name}: {p:document-property(/, 'content-type')}"/>-->
		
		<p:unarchive relative-to="{p:document-property(/, 'base-uri')}" exclude-filter="^__MACOSX/" message="MorganaXProc-IIIse-{$version}.zip: {p:document-property(/, 'content-type')}" />
		<p:for-each>
			<p:store href="{p:document-property(/, 'base-uri')}" />
		</p:for-each>
		
		<p:sink />
		
		<p:directory-list path="../morgana" max-depth="unbounded" />
	</p:declare-step>
	
	<!-- STEP -->
	<p:declare-step type="xps:setup-morgana">
		
		<p:option name="saxon-version" as="xs:string" required="true" />
		<p:option name="morgana-version" as="xs:string" required="true" />
		
		<p:file-copy href="../_temp/saxon/saxon-he-{$saxon-version}.jar" target="../morgana/MorganaXProc-IIIse-{$morgana-version}/MorganaXProc-IIIse_lib/saxon-he-{$saxon-version}.jar" />
		<p:file-copy href="../_temp/saxon/saxon-he-xqj-{$saxon-version}.jar" target="../morgana/MorganaXProc-IIIse-{$morgana-version}/MorganaXProc-IIIse_lib/saxon-he-xqj-{$saxon-version}.jar" />
	</p:declare-step>
	
	<!-- STEP -->
	<p:declare-step type="xps:download-saxon">
		<p:input port="source" sequence="true">
			<p:empty />
		</p:input>
		<p:output port="result" sequence="true" />
		
		<!-- OPTIONS -->
		<p:option name="version" as="xs:string" required="true"  />
		
		<!-- VARIABLES -->
		<p:variable name="url-version" select="replace($version, '\.', '-')" />
		<p:variable name="file-name" select="'SaxonHE' || $version || 'J.zip'" />		
		<p:variable name="url-file-name" select="'SaxonHE' || $url-version || 'J.zip'" />		
		
		<p:file-info href="../_temp/saxon/{$file-name}" fail-on-error="false" />
		<p:variable name="file-exists" select="exists(/c:file)"  />
		
		<p:if test="not($file-exists)" message="File {$file-name} exists: {$file-exists}">
			<p:http-request href="https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE{$url-version}/{$url-file-name}" message="Downloading SaxonHE" />
			<p:store href="..//_temp/saxon/{$file-name}" />			
		</p:if>
		
		<p:load href="..//_temp/saxon/{$file-name}" />
		<!--		<p:archive-manifest message="{$file-name}: {p:document-property(/, 'content-type')}"/>-->
		
		<p:unarchive relative-to="{p:document-property(/, 'base-uri')}" message="{$file-name}: {p:document-property(/, 'content-type')}" />
		<p:for-each>
			<p:store href="{p:document-property(/, 'base-uri')}" />
		</p:for-each>
		
		<p:sink />
		
		<p:directory-list path="../_temp/saxon" max-depth="unbounded" />
	</p:declare-step>

	<!-- STEP -->
	<p:declare-step type="xps:download-schemas">
		
		<!-- OUTPUT PORTS -->
		<p:output port="result" sequence="true" />
		
		<xps:download-file file-name="dracor-schema-v1.0.0-beta.4.rng" url="https://github.com/dracor-org/dracor-schema/releases/download/v1.0.0-beta.4/dracor-schema-v1.0.0-beta.4.rng" target-directory="../schema/rng" />
		<xps:download-file file-name="dracor-schema-v1.0.0-beta.4.sch" url="https://github.com/dracor-org/dracor-schema/releases/download/v1.0.0-beta.4/dracor-schema-v1.0.0-beta.4.sch" target-directory="../schema/schematron" />
		<xps:download-file file-name="dracor-schema-v1.0.0-beta.4.sch" url="https://github.com/dracor-org/dracor-schema/releases/download/v1.0.0-beta.4/dracor-schema-v1.0.0-beta.4.sch" target-directory="../schema/schematron" />
		<xps:download-file file-name="hub.rng" url="https://raw.githubusercontent.com/le-tex/Hub/refs/heads/master/hub.rng" target-directory="../schema/rng" />
		<xps:download-file file-name="cssa-publisher-extensions.rng" url="https://raw.githubusercontent.com/le-tex/CSSa/6ea9e14d9ffe551f7bbdd8fe1e9db5830e28f85e/cssa-publisher-extensions.rng" target-directory="../schema/rng/css" />
		<xps:download-file file-name="cssa-rules.rng" url="https://raw.githubusercontent.com/le-tex/CSSa/6ea9e14d9ffe551f7bbdd8fe1e9db5830e28f85e/cssa-rules.rng" target-directory="../schema/rng/css" />
		<xps:download-file file-name="css.rng" url="https://raw.githubusercontent.com/le-tex/CSSa/6ea9e14d9ffe551f7bbdd8fe1e9db5830e28f85e/css.rng" target-directory="../schema/rng/css" />
		<xps:download-file file-name="docbook.rng" url="https://raw.githubusercontent.com/le-tex/Hub/refs/heads/master/dbk/docbook.rng" target-directory="../schema/rng/dbk" />
		<p:directory-list path="../schema" max-depth="unbounded" />
	</p:declare-step>
	
	<!-- STEP -->
	<p:declare-step type="xps:download-file" visibility="private">
		<p:input port="source" sequence="true">
			<p:empty />
		</p:input>
		
		<!-- OUTPUT PORTS -->
		<p:output port="result" sequence="true" />
		
		<!-- OPTIONS -->		
		<p:option name="file-name" as="xs:string" />
		<p:option name="url" as="xs:anyURI" />
		<p:option name="target-directory" as="xs:string" />
		
		<p:file-info href="{$target-directory}/{$file-name}" fail-on-error="false" />
		<p:variable name="file-exists" select="exists(/c:file)"  />
		
		<p:if test="not($file-exists)" message="File {$file-name} exists: {$file-exists}">
			<p:http-request href="{$url}" message="Downloading {$file-name}" />
			<p:store href="{$target-directory}/{$file-name}" />			
		</p:if>
		
		
	</p:declare-step>
	

	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />


	<!-- PIPELINE BODY -->
	
 
	<xps:create-directories />
	<!--<xps:create-gitignore />-->
	<xps:download-morgana version="{$morgana-version}" />
	<xps:download-saxon version="{$saxon-version}" />
	<xps:setup-morgana  morgana-version="{$morgana-version}" saxon-version="{$saxon-version}" />
	<p:directory-list path="../" max-depth="unbounded" />

	<!--<xps:download-schemas />-->
	
	<!--<p:directory-list path="../" max-depth="unbounded" />-->
	
	
	

</p:declare-step>
