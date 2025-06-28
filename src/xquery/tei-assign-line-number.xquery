xquery version "3.1" encoding "utf-8";

(:import module namespace xds="https://www.daliboris.cz/ns/xquery/drama/speaker" at "speaker-names-helper.xqm"; :)
(:declare namespace xds="https://www.daliboris.cz/ns/xquery/drama/speaker"; :)

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare default collation "http://www.w3.org/2013/collation/UCA?lang=cs-CZ";


declare function local:clean-name($name as xs:string?) as xs:string? 
{
 let $result := translate( normalize-space($name) , "[]:", "")
 let $result := replace($result, "Gen\.", "Genius")
 let $result := replace($result, "men\.", "mendicorum")
 let $result := replace($result, "žebr\.", "žebráků")
 let $result := if (contains($result, " omnes")) then () else $result
 return $result
};

 declare function local:get-valid-id ($item as xs:string?) as xs:string 
{
 translate($item,  " ,.:", "---") => replace("--", "-") => lower-case()
};

declare function local:get-valid-xml-id ($item as xs:string?, $play-name-suffix as xs:string?) as xs:string 
{
 let $suffix := if(empty($play-name-suffix)) then "" else "-" || $play-name-suffix
 return "per." || local:get-valid-id($item) || $suffix
};

declare function local:get-tei-particDesc ($items as element(speaker)*, $play-name as xs:string?) as element(tei:particDesc) 
{
<tei:particDesc>
 <tei:listPerson>
 <tei:head xml:lang="cs">Seznam postav</tei:head>
 <tei:head xml:lang="en">List of characters</tei:head>
  {for $item in $items 
   return local:get-person-tei($item, $play-name)
    }
 </tei:listPerson>
</tei:particDesc>
};

declare function local:get-person-tei ($item as element(speaker), $play-name as xs:string?) as element(tei:person)  {
 let $occupation := if(empty($play-name))
  then "Postava vystupující v této hře" 
  else "Postava vystupující ve hře " || $play-name
 let $id := $item/@id
 return <tei:person xml:id="{$id}" sex="MALE">
  {
  for $i in $item/variant
  let $invariant := $i/@invariant
  let $lang := $i/@xml:lang
  group by $lang, $invariant
  order by $lang descending
  return
   <tei:persName xml:lang="{$lang}" type="main">{$invariant}</tei:persName>
   }
   <tei:note type="bio"/>
   <tei:occupation>{$occupation}</tei:occupation>
   </tei:person>
};



declare function local:compute-indent($items as element(tei:l)*) as xs:integer*
{ 
 let $single := for $item at $i in $items
   let $speaker := $item/preceding::tei:speaker[1] => local:get-speaker-name()
   let $prev-speaker := $items[$i - 1]/preceding::tei:speaker[1] => local:get-speaker-name()
   let $prev-item := $items[$i - 1]
   return if($i = 1) then 0 
          else 
          if($item/ancestor::tei:front) then 1
          else
          if($item/tei:space/@quantity <= 2) then 1
          else
           if($speaker = $prev-speaker) then 1 
           else if($item/tei:space/@quantity < $prev-item/tei:space/@quantity) then 
           1
           else 0
                  
 (:return sum($single):)
 return $single
 }; 

declare function local:get-speaker-name($speaker as element(tei:speaker)?) {
 $speaker/text()[1]/normalize-space()
};

declare function local:exctract-lines($tei as element(tei:TEI)) as element(lines) 
{
 let $lang := $tei/@xml:lang
 let $id := $tei//tei:text[1]/@xml:id
 let $items := $tei//tei:l
 
 return <lines xml:lang="{$lang}" xml:id="{$id}"> {
 for tumbling window $w in $items
 start $s at $s-pos when $s[@n] or $s-pos = 1
 let $start := if($w[1]/@n) then xs:integer(translate($w[1]/@n, 'ab', '')) else 1
 return <group start="{$start}" count="{count($w)}">{
   for $item at $i in $w
   let $start-original := $item/@n 
   let $speaker := $item/preceding::tei:speaker[1] => local:get-speaker-name()
   let $prev-speaker := $w[$i - 1]/preceding::tei:speaker[1] => local:get-speaker-name()
   let $prev-lines := $w[position() <=  $i]
   let $indent := local:compute-indent($prev-lines)
  return <line position="{$s-pos + $i - 1}" n="{if($start-original) then $start-original else $start + sum($indent)}" indent="{$indent}" order="{$i}" speaker="{$speaker}" spaces="{$item/tei:space/@quantity}" id="{generate-id($item)}">{data($item/@n)}</line>
    }</group> 
  } </lines>
 
};

declare function local:extract-speakers-2 ($lines as element(lines)*, $play-name-suffix as xs:string?) as element(speakers) 
{ 
 let $group := for $line in $lines//line
  let $p := $line/@position
  group by $p
  let $id := string-join($line/@speaker ! local:clean-name(.), '|')
  return <speaker key="{$id}">
  {for $item in $line
   return <variant text="{$item/@speaker}" xml:lang="{($item/ancestor-or-self::lines[1]/@xml:lang)}" />
  }
  </speaker>
  
  let $group := for $item in $group
   let $key := $item/@key
   group by $key
   order by $key
   let $id := $item[1]/variant[lang('la')]/@text => local:clean-name() => local:get-valid-id()
   let $xmlid := local:get-valid-xml-id($id, $play-name-suffix)
   where $id != ""
   return <speaker id="{$xmlid}" key="{$key}">
    {
     for $variant in $item/variant
     group by $lang := $variant/@xml:lang, $text := $variant/@text
     order by $lang descending, $text
     return <variant id="{$xmlid}" text="{$text}" invariant="{local:clean-name($text)}" xml:lang="{$lang}" />
    }
   </speaker>
  
  return <speakers>{$group}</speakers>
  
};

declare function local:get-listPerson ($items as element(speaker)*, $play-name as xs:string?, $play-name-suffix as xs:string?) as element(tei:listPerson) {
 let $persons := for $item in $items
  return local:get-person-tei($item, $play-name)
  return <tei:listPerson>
  <tei:head xml:lang="cs">Seznam postav</tei:head>
  <tei:head xml:lang="en">List of characters</tei:head>
  {$persons}
  </tei:listPerson>
};

declare function local:extract-speakers ($lines as element(lines)*, $play-name as xs:string?, $play-name-suffix as xs:string?) as element(speakers) 
{ 
 let $group := for $line in $lines//line
  let $p := $line/@position
  group by $p
  return string-join($line/@speaker ! local:clean-name(.), '|')
  
  let $speakers := distinct-values($group)
  let $items := for $item in $speakers[contains(., '|')]
   order by $item
   let $speaker := <speaker id="{local:get-valid-id(substring-before($item, '|'))}" variants="{$item}" />
   let $tei := local:get-person-tei($speaker, $play-name)
   return <speaker id="{local:get-valid-id(substring-before($item, '|'))}" variants="{$item}">
   {$tei}
   </speaker>
  
  return <speakers xmlns:tei="http://www.tei-c.org/ns/1.0">{$items}</speakers>
 };

 let $play-name := /tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]
 let $play-name-abbreviation := $play-name/translate(., '[]', '') ! tokenize(normalize-space()) ! substring(., 1, 1) ! lower-case(.) => string-join()
 let $play-name-abbreviation := /tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[1]/@xml:id => translate('-', '') => lower-case()
 let $project-abbreviation := "tnl"
 let $play-name-suffix := $play-name-abbreviation || "-" || $project-abbreviation   
 let $teis := //tei:TEI[.//tei:l]
 let $lines := for $tei in $teis
   return local:exctract-lines($tei)
 let $speakers := local:extract-speakers-2($lines, $play-name-suffix)
 let $listPerson := local:get-listPerson($speakers/speaker, $play-name, $play-name-suffix)
 return <data> {($speakers, $listPerson, $lines)} </data>
 
  
 