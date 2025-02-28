xquery version "3.1" encoding "utf-8";

module namespace xds="https://www.daliboris.cz/ns/xquery/drama/speaker";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare default collation "http://www.w3.org/2013/collation/UCA?lang=cs-CZ";

declare function xds:clean-name($name as xs:string?) as xs:string? 
{
 let $result := translate( normalize-space($name) , "[]:", "")
 let $result := replace($result, "Gen\.", "Genius")
 let $result := replace($result, "men\.", "mendicorum")
 let $result := replace($result, "žebr\.", "žebráků")
 let $result := if (contains($result, " omnes")) then () else $result
 return $result
};

 declare function xds:get-valid-id ($item as xs:string?) as xs:string 
{
 translate($item,  " ,.:", "---") => replace("--", "-") => lower-case()
};

declare function xds:get-valid-xml-id ($item as xs:string?, $play-name-suffix as xs:string?) as xs:string 
{
 let $suffix := if(empty($play-name-suffix)) then "" else "-" || $play-name-suffix
 return "per." || xds:get-valid-id($item) || $suffix
};

declare function xds:get-tei-particDesc ($items as element(speaker)*, $play-name as xs:string?) as element(tei:particDesc) 
{
<tei:particDesc>
 <tei:listPerson>
 <tei:head xml:lang="cs">Seznam postav</tei:head>
 <tei:head xml:lang="en">List of characters</tei:head>
  {for $item in $items 
   return xds:get-person-tei($item, $play-name)
    }
 </tei:listPerson>
</tei:particDesc>
};

declare function xds:get-person-tei ($item as element(speaker), $play-name as xs:string?) as element(tei:person)  {
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

