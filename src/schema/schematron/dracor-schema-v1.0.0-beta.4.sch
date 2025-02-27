<?xml version="1.0" encoding="utf-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
   <title>ISO Schematron rules</title>
   <!-- This file generated 2025-02-07T22:39:01Z by 'extract-isosch.xsl'. -->
   <!-- ********************* -->
   <!-- namespaces, declared: -->
   <!-- ********************* -->
   <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
   <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
   <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
   <!-- ********************* -->
   <!-- namespaces, implicit: -->
   <!-- ********************* -->
   <ns prefix="dcr" uri="http://www.isocat.org/ns/dcr"/>
   <!-- ************ -->
   <!-- constraints: -->
   <!-- ************ -->
   <pattern id="schematron-constraint-dracor-att.datable.w3c-att-datable-w3c-when-1">
      <rule context="tei:*[@when]">
         <report test="@notBefore|@notAfter|@from|@to" role="nonfatal">The @when attribute cannot be used with any other att.datable.w3c attributes.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.datable.w3c-att-datable-w3c-from-2">
      <rule context="tei:*[@from]">
         <report test="@notBefore" role="nonfatal">The @from and @notBefore attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.datable.w3c-att-datable-w3c-to-3">
      <rule context="tei:*[@to]">
         <report test="@notAfter" role="nonfatal">The @to and @notAfter attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.datable-calendar-calendar-4">
      <rule context="tei:*[@calendar]">
         <assert test="string-length(.) gt 0"> @calendar indicates one or more systems or calendars to
              which the date represented by the content of this element belongs, but this
              <name/> element has no textual content.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.measurement-att-measurement-unitRef-5">
      <rule context="tei:*[@unitRef]">
         <report test="@unit" role="info">The @unit attribute may be unnecessary when @unitRef is present.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.typed-subtypeTyped-6">
      <rule context="tei:*[@subtype]">
         <assert test="@type">The <name/> element should not be categorized in detail with @subtype unless also categorized in general with @type</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.pointing-targetLang-targetLang-7">
      <rule context="tei:*[not(self::tei:schemaSpec)][@targetLang]">
         <assert test="@target">@targetLang should only be used on <name/> if @target is specified.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.spanning-spanTo-spanTo-points-to-following-8">
      <rule context="tei:*[@spanTo]">
         <assert test="id(substring(@spanTo,2)) and following::*[@xml:id=substring(current()/@spanTo,2)]">
The element indicated by @spanTo (<value-of select="@spanTo"/>) must follow the current element <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-att.styleDef-schemeVersion-schemeVersionRequiresScheme-9">
      <rule context="tei:*[@schemeVersion]">
         <assert test="@scheme and not(@scheme = 'free')">
              @schemeVersion can only be used if @scheme is specified.
            </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-p-abstractModel-structure-p-in-ab-or-p-10">
      <rule context="tei:p">
         <report test="    (ancestor::tei:ab or ancestor::tei:p)                          and not( ancestor::tei:floatingText                                 |parent::tei:exemplum                                 |parent::tei:item                                 |parent::tei:note                                 |parent::tei:q                                 |parent::tei:quote                                 |parent::tei:remarks                                 |parent::tei:said                                 |parent::tei:sp                                 |parent::tei:stage                                 |parent::tei:cell                                 |parent::tei:figure                                )">
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-p-abstractModel-structure-p-in-l-or-lg-11">
      <rule context="tei:p">
         <report test="    (ancestor::tei:l or ancestor::tei:lg)                          and not( ancestor::tei:floatingText                                 |parent::tei:figure                                 |parent::tei:note                                )">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab, unless p is a child of figure or note, or is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-desc-deprecationInfo-only-in-deprecated-12">
      <rule context="tei:desc[ @type eq 'deprecationInfo']">
         <assert test="../@validUntil">Information about a
        deprecation should only be present in a specification element
        that is being deprecated: that is, only an element that has a
        @validUntil attribute should have a child &lt;desc
        type="deprecationInfo"&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-rt-target-rt-target-not-span-13">
      <rule context="tei:rt/@target">
         <report test="../@from | ../@to">When target= is
            present, neither from= nor to= should be.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-rt-from-rt-from-14">
      <rule context="tei:rt/@from">
         <assert test="../@to">When from= is present, the to=
            attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-rt-to-rt-to-15">
      <rule context="tei:rt/@to">
         <assert test="../@from">When to= is present, the from=
            attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-ptr-ptrAtts-16">
      <rule context="tei:ptr">
         <report test="@target and @cRef">Only one of the
attributes @target and @cRef may be supplied on <name/>.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-ref-refAtts-17">
      <rule context="tei:ref">
         <report test="@target and @cRef">Only one of the
	attributes @target' and @cRef' may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-list-gloss-list-must-have-labels-18">
      <rule context="tei:list[@type='gloss']">
         <assert test="tei:label">The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-relatedItem-targetorcontent1-19">
      <rule context="tei:relatedItem">
         <report test="@target and count( child::* ) &gt; 0">
If the @target attribute on <name/> is used, the
relatedItem element must be empty</report>
         <assert test="@target or child::*">A relatedItem element should have either a 'target' attribute
        or a child element to indicate the related bibliographic item</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-l-abstractModel-structure-l-in-l-20">
      <rule context="tei:l">
         <report test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
        Abstract model violation: Lines may not contain lines or lg elements.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-lg-atleast1oflggapl-21">
      <rule context="tei:lg">
         <assert test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0">An lg element
        must contain at least one child l, lg, or gap element.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-lg-abstractModel-structure-lg-in-l-22">
      <rule context="tei:lg">
         <report test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
        Abstract model violation: Lines may not contain line groups.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-sp-network_sp_with_who_attr-23">
      <rule context="tei:sp" role="warning">
         <assert test="@who">
                    A speech 'sp' without an attribute '@who' is not used when
                    extracting the network. SHOULD consider linking the speech
                    act to a speaking character ('person') in the 'particDesc'.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-sp-network_unlinked_sp-24">
      <rule context="tei:sp[@who[not(contains(.,' '))]]" role="warning">
         <let name="localID" value="replace(@who/string(),'#','')"/>
         <assert test="ancestor::tei:TEI//tei:particDesc//(tei:person|tei:personGrp)[@xml:id eq $localID]"
                 role="warning">
                    A speech act SHOULD link to a 'person' or 'personGrp'
                    element in 'particDesc'. Use a valid character ID and
                    provide it as a pointer by prepending it with a hash '#'."
                  </assert>
      </rule>
      <rule context="tei:sp[contains(@who,' ')]">
         <let name="allIDs"
              value="./ancestor::tei:TEI//tei:particDesc//(tei:person|tei:personGrp)/@xml:id/string()"/>
         <let name="localIDs" value="tokenize(@who/string(),'\s+')"/>
         <assert test="every $i in $localIDs satisfies replace($i,'#','') = $allIDs"
                 role="warning">
                    At least one character ID provided as the value of the
                    attribute who '<value-of xmlns="http://www.w3.org/1999/XSL/Transform" select="@who/string()"/>' has
                    not been declared. A speech act SHOULD link to a 'person' or
                    'personGrp' element in 'particDesc'.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-titleStmt-play_main_title-25">
      <rule context="tei:titleStmt" role="warning">
         <assert test="tei:title[@type eq 'main']">
                    For the DraCor API to include the title of the play in the
                    response an element 'title' with the type-attribute value
                    'main' SHOULD be included.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-publicationStmt-identifier_corpus_name_in_corpus_xml-26">
      <rule context="tei:publicationStmt[ancestor::tei:teiCorpus]" role="critical">
         <assert test="tei:idno[@type eq 'URI']">
                    The identifier 'corpus name' of the corpus MUST be included
                    as an element idno with the value 'URI' of the attribute
                    'type'.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-publicationStmt-corpus_repository_url_in_corpus_xml-27">
      <rule context="tei:publicationStmt[ancestor::tei:teiCorpus]" role="warning">
         <assert test="tei:idno[@type eq 'repo']">
                    The URL of the corpus repository on GitHub SHOULD be
                    included as an element idno with the value 'repo' of the
                    attribute 'type'.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-idno-xml_base_required_on_idno_type_URI_in_corpus_xml-28">
      <rule context="tei:idno[@type eq 'URI' and parent::tei:publicationStmt and ancestor::tei:teiCorpus]"
            role="warning">
         <assert test="@xml:base/string() eq 'https://dracor.org/'">
                    The idno element in publicationStmt in the teiCorpus SHOULD
                    have an xml:base attribute with the value
                    'https://dracor.org/'.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-sourceDesc-digital_source_in_sourceDesc-29">
      <rule context="tei:sourceDesc">
         <assert test="tei:bibl[@type eq 'digitalSource']">
                    Digital source is missing
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-sourceDesc-original_source_in_sourceDesc-30">
      <rule context="tei:sourceDesc/tei:bibl[@type eq 'digitalSource']">
         <assert test="tei:bibl[@type eq 'originalSource']">
                    Original Source for digital source is missing
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-quotation-quotationContents-31">
      <rule context="tei:quotation">
         <report test="not(@marks) and not (tei:p)">
On <name/>, either the @marks attribute should be used, or a paragraph of description provided</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-citeStructure-delim-citestructure-inner-delim-32">
      <rule context="tei:citeStructure[parent::tei:citeStructure]">
         <assert test="@delim">A <name/> with a parent <name/> must have a @delim attribute.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-citeStructure-match-citestructure-outer-match-33">
      <rule context="tei:citeStructure[not(parent::tei:citeStructure)]">
         <assert test="starts-with(@match,'/')">An XPath in @match on the outer <name/> must start with '/'.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-citeStructure-match-citestructure-inner-match-34">
      <rule context="tei:citeStructure[parent::tei:citeStructure]">
         <assert test="not(starts-with(@match,'/'))">An XPath in @match must not start with '/' except on the outer <name/>.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-TEI-valid_dracor_ids_on_root_tei_element-35">
      <rule context="tei:TEI" role="warning">
         <assert test="matches(./@xml:id,'^[a-z]+[0-9]{6}$')">
                    For DraCor IDs we recommend the pattern ^[a-z]+[0-9]{6}$
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-body-network_check_basic_play_structure_div-38">
      <rule context="tei:body" role="warning">
         <assert test="tei:div">
                    A play SHOULD at least have one structural division 'div'
                    for the API to be able to extract a network.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-body-network_check_basic_play_structure_sp-39">
      <rule context="tei:body" role="warning">
         <assert test=".//tei:sp">
                    A play SHOULD be structured in speech-acts using the element
                    'sp' for the API to be able to extract a network.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-body-network_play_without_speaking_characters-40">
      <rule context="tei:body[not(.//tei:sp)]" role="warning">
         <assert test=".//tei:stage" role="warning">
                    A drama that does not contain a speech-act 'sp', SHOULD at
                    least contain a stage direction 'stage'.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-div-abstractModel-structure-div-in-l-or-lg-41">
      <rule context="tei:div">
         <report test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-div-abstractModel-structure-div-in-ab-or-p-42">
      <rule context="tei:div">
         <report test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
        Abstract model violation: p and ab may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-link-linkTargets3-43">
      <rule context="tei:link">
         <assert test="contains(normalize-space(@target),' ')">You must supply at least two values for @target or  on <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-ab-encoding-hint_ab_used_somewhere_else-44">
      <rule context="tei:ab"
            role="warning"
            see="https://dracor.org/doc/odd#TEI.ab">
         <assert test="./parent::tei:licence">
                    In DraCor the element 'ab' should only be used to mark the
                    label of the licence in the teiHeader.
                  </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-ab-abstractModel-structure-ab-in-ab-or-p-45">
      <rule context="tei:ab">
         <report test="    (ancestor::tei:p or ancestor::tei:ab)                          and not( ancestor::tei:floatingText                                  |parent::tei:exemplum                                 |parent::tei:item                                 |parent::tei:note                                 |parent::tei:q                                 |parent::tei:quote                                 |parent::tei:remarks                                 |parent::tei:said                                 |parent::tei:sp                                 |parent::tei:stage                                 |parent::tei:cell                                 |parent::tei:figure                                )">
        Abstract model violation: ab may not occur inside paragraphs or other ab elements.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-ab-abstractModel-structure-ab-in-l-or-lg-46">
      <rule context="tei:ab">
         <report test="    (ancestor::tei:l or ancestor::tei:lg)                         and not( ancestor::tei:floatingText                                 |parent::tei:figure                                 |parent::tei:note                                )">
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab, unless ab is a child of figure or note, or is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-join-joinTargets3-47">
      <rule context="tei:join">
         <assert test="contains(@target,' ')">
You must supply at least two values for @target on <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-standOff-nested_standOff_should_be_typed-48">
      <rule context="tei:standOff">
         <assert test="@type or not(ancestor::tei:standOff)">This
      <name/> element must have a @type attribute, since it is
      nested inside a <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-relation-reforkeyorname-49">
      <rule context="tei:relation">
         <assert test="@ref or @key or @name">One of the attributes  'name', 'ref' or 'key' must be supplied</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-relation-activemutual-50">
      <rule context="tei:relation">
         <report test="@active and @mutual">Only one of the attributes @active and @mutual may be supplied</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-relation-activepassive-51">
      <rule context="tei:relation">
         <report test="@passive and not(@active)">the attribute 'passive' may be supplied only if the attribute 'active' is supplied</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-s-noNestedS-52">
      <rule context="tei:s">
         <report test="tei:s">You may not nest one s element within
      another: use seg instead</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-span-targetfrom-53">
      <rule context="tei:span">
         <report test="@from and @target">
Only one of the attributes @target and @from may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-span-targetto-54">
      <rule context="tei:span">
         <report test="@to and @target">
Only one of the attributes @target and @to may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-span-tonotfrom-55">
      <rule context="tei:span">
         <report test="@to and not(@from)">
If @to is supplied on <name/>, @from must be supplied as well</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-span-tofrom-56">
      <rule context="tei:span">
         <report test="contains(normalize-space(@to),' ') or contains(normalize-space(@from),' ')">
The attributes @to and @from on <name/> may each contain only a single value</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-play_id-57">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_id">
         <let name="play_id" value="/tei:TEI/@xml:id/string()"/>
         <report test="/tei:TEI/@xml:id">
                  Supported API feature: play_id [value:
                  <value-of select="$play_id"/>]</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-play_wikidata_id-58">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_wikidata_id">
         <let name="play_wikidata"
              value="/tei:TEI/tei:standOff/tei:listRelation/tei:relation[@name eq 'wikidata']/@passive/string()"/>
         <report test="/tei:TEI/tei:standOff/tei:listRelation/tei:relation[@name eq 'wikidata']/@passive[starts-with(.,'http://www.wikidata.org/entity/')]">
                  Supported API feature: play_wikidata_id [value:
                  <value-of select="substring-after($play_wikidata, 'http://www.wikidata.org/entity/')"/>]
                </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-play_title-59">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_title">
         <let name="play_title"
              value="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[not(@type = 'sub') and not(@xml:lang or ./ancestor::tei:TEI/@xml:lang = @xml:lang)]/normalize-space()"/>
         <report test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[not(@type = 'sub') and not(@xml:lang or ./ancestor::tei:TEI/@xml:lang = @xml:lang)]">
                  Supported API feature: play_title [value:
                  <value-of select="$play_title"/>]
                </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-play_subtitle-60">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_subtitle">
         <let name="play_subtitle"
              value="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type = 'sub' and not(@xml:lang or ./ancestor::tei:TEI/@xml:lang = @xml:lang)]/normalize-space()"/>
         <report test="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='sub']">
                  Supported API feature: play_subtitle [value:
                  <value-of select="$play_subtitle"/>]
                </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-play_year_written-61">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_year_written">
         <let name="play_year_written"
              value="/tei:TEI/tei:standOff/tei:listEvent/tei:event[@type eq 'written']/@when/string()"/>
         <report test="/tei:TEI/tei:standOff/tei:listEvent/tei:event[@type eq 'written']/@when">
                  Supported API feature: play_year_written [value:
                  <value-of select="$play_year_written"/>]
                </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-play_year_printed-62">
      <rule context="/"
            role="information"
            see="https://dracor.org/doc/odd#play_year_printed">
         <let name="play_year_printed"
              value="/tei:TEI/tei:standOff/tei:listEvent/tei:event[@type eq 'print']/@when/string()"/>
         <report test="/tei:TEI/tei:standOff/tei:listEvent/tei:event[@type eq 'print']/@when">
                  Supported API feature: play_year_printed [value:
                  <value-of select="$play_year_printed"/>]
                </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-dracor-encoding-hint_play_wikidata_id-63">
      <rule context="tei:TEI/tei:standOff/tei:listRelation/tei:relation[@name eq 'wikidata']"
            role="warning"
            see="https://dracor.org/doc/odd#section-play-wikidata">
         <let name="expected_play_uri"
              value="concat('https://dracor.org/entity/',./ancestor::tei:TEI/@xml:id/string())"/>
         <assert test="starts-with(./@passive/string(),'http://www.wikidata.org/entity/')">
                  The value of the attribute '@passive' MUST start with
                  "http://www.wikidata.org/entity/" to be a valid Wikidata URI.
                </assert>
         <assert test="./@active/string() eq $expected_play_uri">
                  The value of the attribute '@passive' SHOULD follow the
                  pattern "http://www.wikidata.org/entity/{play_id}.
                  [Expected value:
                  '<value-of xmlns="http://www.w3.org/1999/XSL/Transform" select="$expected_play_uri"/>']"
                </assert>
      </rule>
   </pattern>
</schema>
