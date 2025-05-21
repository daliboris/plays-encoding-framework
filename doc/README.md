# XProc Analysis Report

## common-lib.xpl
#### Documentation (0)
    
##### 

#### Namespaces (7)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xevt | https://www.daliboris.cz/ns/xproc/evt |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xtei | https://www.daliboris.cz/ns/xproc/tei |
| xxml | https://www.daliboris.cz/ns/xproc/xml |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (1 + 0)
      
#### Documentation (0)
    
##### 


#### **xxml:clean-namespaces** (cleaning-namespaces)
#### Documentation (0)
    
##### 

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/xml/xml-removing-namespaces.xsl | 



## docx2dracor-lib.xpl
#### Documentation (0)
    
##### 

#### Namespaces (16)
    
| prefix | string |
| --- | --- |
| css | http://www.w3.org/1996/css |
| dxfs | https://www.daliboris.cz/ns/xproc/file-system |
| fs | https://www.daliboris.cz/ns/file-system |
| hub | http://docbook.org/ns/docbook |
| p | http://www.w3.org/ns/xproc |
| tei | http://www.tei-c.org/ns/1.0 |
| xd2dc | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2dracor |
| xevt | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpl | https://www.daliboris.cz/ns/xproc/pipeline |
| xs | http://www.w3.org/2001/XMLSchema |
| xtei | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei |
| xxml | https://www.daliboris.cz/ns/xproc/xml |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (6 + 0)
      
#### Documentation (0)
    
##### 


#### **xd2dc:input-processing** (input-processing)
#### Documentation (0)
    
##### 

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-directory-path | name = data-directory-path \| as = xs:anyURI? \| required = false |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 40)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | dxfs:document-file-info | info |   |   | 
| 4 | p:variable | file |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file | 
| 5 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 6 | p:variable | log-output-directory |   |   | 
|   |   |   | select | if(empty($debug-path)) then () else $debug-path \|\| '/docx2tei/' \|\| $file/@stem | 
| 7 | p:variable | log-file-name |   |   | 
|   |   |   | select | $file/@stem \|\| '.xml' | 
| 8 | xpef:input-processing |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 1 | 
| 10 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/xml/fix-dracor-inside-default.xsl | 
| 11 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 2 | 
| 12 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/xml/fix-tab-at-end.xsl | 
| 13 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 5 | 
| 14 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/xml/fix-tab-as-space.xsl | 
| 15 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 6 | 
| 16 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/common/character-maps.xsl | 
| 17 | p:file-create-tempfile |  |   |   | 
|   |   |   | delete-on-exit | true | 
|   |   |   | suffix | .xml | 
| 18 | p:variable | href-tempfile-uri |   |   | 
|   |   |   | select | string(.) | 
| 19 | p:store |  |   |   | 
|   |   |   | pipe | result@character-maps | 
|   |   |   | href | {$href-tempfile-uri} | 
| 20 | p:load |  |   |   | 
|   |   |   | href | {$href-tempfile-uri} | 
| 21 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 10 | 
| 22 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'phase' : 1 } | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl | 
| 23 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 15 | 
| 24 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'phase' : 2 } | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl | 
| 25 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 20 | 
| 26 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-clean-element-names.xsl | 
| 27 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 25 | 
| 28 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-fix-element-combinations.xsl | 
| 29 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 30 | 
| 30 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-group-elements-to-div.xsl | 
| 31 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 35 | 
| 32 | p:variable | sections |   |   | 
|   |   |   | select | count(//div/DraCor-additions[matches(normalize-space(), '^/(.+)_start/$')]) | 
| 33 | xd2dc:apply-xslt |  |   |   | 
|   |   |   | repeat | {$sections} | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-group-div-start-to-end.xsl | 
| 34 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 40 | 
| 35 | xd2dc:apply-xslt |  |   |   | 
|   |   |   | repeat | 2 | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-group-elements-to-div.xsl | 
| 36 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 45 | 
| 37 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-group-elements-to-div.xsl | 
| 38 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 45 | 
| 39 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-group-elements-to-div.xsl | 
| 40 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 50 | 


#### **xd2dc:tei-processing** (tei-processing)
#### Documentation (0)
    
##### 

#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-directory-path | name = data-directory-path \| as = xs:anyURI? \| required = false |
| data-file-path | name = data-file-path \| as = xs:string? |
| text-id | name = text-id \| as = xs:string? |

#### Ports (3)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | job-ticket | false |
| output | **result** | true |

### Steps  (0 + 34)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | p:variable | log-file-name |   |   | 
|   |   |   | select | $text-id \|\| '.xml' | 
| 5 | p:variable | log-output-directory |   |   | 
|   |   |   | select | if(empty($debug-path)) then () else $debug-path \|\| '/tei-processing/' \|\| $text-id | 
| 6 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/dracor-xml-to-tei.xsl | 
| 7 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 1 | 
| 8 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/dracor-tei-convert-to-lb.xsl | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 2 | 
| 10 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-add-castList.xsl | 
| 11 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 5 | 
| 12 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-fix-stage.xsl | 
| 13 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 10 | 
| 14 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-fix-speaker.xsl | 
| 15 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 15 | 
| 16 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-insert-speaker.xsl | 
| 17 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 16 | 
| 18 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/rochotius/tei-postprocessing/rochotius-add-sp.xsl | 
| 19 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 20 | 
| 20 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'person-prefix' : '' } | 
|   |   |   | href | ../xslt/common/tei-add-who-to-sp.xsl | 
| 21 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 21 | 
| 22 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-generate-particDesc.xsl | 
| 23 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 22 | 
| 24 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-add-l-part.xsl | 
| 25 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 25 | 
| 26 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-space.xsl | 
| 27 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 30 | 
| 28 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2dracor/tei-processing/tei-clean-whitespace.xsl | 
| 29 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 35 | 
| 30 | p:delete |  |   |   | 
|   |   |   | match | tei:speaker[@resp='#pef-dracor'] | 
| 31 | p:delete |  |   |   | 
|   |   |   | match | @xd2dc:* | 
| 32 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | xd2dc | 
| 33 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/xml/xml-removing-namespaces.xsl | 
| 34 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 50 | 


#### **xd2dc:apply-xslt** (applying-xslt)
#### Options (1)
      
| name | properties |
| --- | --- |
| repeat | name = repeat \| select = 1 \| as = xs:integer |

#### Ports (3)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | stylesheet | false |
| output | **result** | true |

### Steps  (0 + 1)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | pipe | source@applying-xslt | 
|   |   |   | pipe | stylesheet@applying-xslt | 
|   |   |   | test | $repeat gt 1 | 
| 2 | p:otherwise |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | pipe | source@applying-xslt | 
|   |   |   | pipe | stylesheet@applying-xslt | 


#### **xd2dc:tei-conversion** (tei-conversion)
#### Documentation (0)
    
##### 

#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 9)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | dxfs:document-file-info | info |   |   | 
| 5 | p:variable | file |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file | 
| 6 | p:variable | log-output-directory |   |   | 
|   |   |   | select | $debug-path \|\| '/docx2dracor/' \|\| $file/@stem | 
| 7 | p:variable | log-file-name |   |   | 
|   |   |   | select | $file/@stem \|\| '.xml' | 
| 8 | xxml:clean-namespaces |  |   |   | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 20 | 


#### **xd2dc:convert** (conversion)
#### Documentation (0)
    
##### 

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| target | name = target \| as = xs:string* \| values = ('TEI', 'text') |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 2)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $target='TEI' | 
| 2 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $target='text' | 


#### **xd2dc:docx-to-text**
#### Documentation (0)
    
##### 

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 0)
      
#### Documentation (0)
    
##### 




## docx2tei-lib.xpl
#### Documentation (0)
    
##### 

#### Namespaces (16)
    
| prefix | string |
| --- | --- |
| css | http://www.w3.org/1996/css |
| dxfs | https://www.daliboris.cz/ns/xproc/file-system |
| fs | https://www.daliboris.cz/ns/file-system |
| hub | http://docbook.org/ns/docbook |
| p | http://www.w3.org/ns/xproc |
| tei | http://www.tei-c.org/ns/1.0 |
| xd2t | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/docx2tei |
| xevt | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpl | https://www.daliboris.cz/ns/xproc/pipeline |
| xs | http://www.w3.org/2001/XMLSchema |
| xtei | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei |
| xxml | https://www.daliboris.cz/ns/xproc/xml |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (4 + 0)
      
#### Documentation (0)
    
##### 


#### **xd2t:input-processing** (input-processing)
#### Documentation (0)
    
##### 

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-directory-path | name = data-directory-path \| as = xs:anyURI? \| required = false |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 22)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | dxfs:document-file-info | info |   |   | 
| 4 | p:variable | file |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file | 
| 5 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 6 | p:variable | log-output-directory |   |   | 
|   |   |   | select | if(empty($debug-path)) then () else $debug-path \|\| '/docx2tei/' \|\| $file/@stem | 
| 7 | p:variable | log-file-name |   |   | 
|   |   |   | select | $file/@stem \|\| '.xml' | 
| 8 | xpef:input-processing |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 1 | 
| 10 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/common/character-maps.xsl | 
| 11 | p:file-create-tempfile |  |   |   | 
|   |   |   | delete-on-exit | true | 
|   |   |   | suffix | .xml | 
| 12 | p:variable | href-tempfile-uri |   |   | 
|   |   |   | select | string(.) | 
| 13 | p:store |  |   |   | 
|   |   |   | pipe | result@character-maps | 
|   |   |   | href | {$href-tempfile-uri} | 
| 14 | p:load |  |   |   | 
|   |   |   | href | {$href-tempfile-uri} | 
| 15 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'phase' : 1 } | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl | 
| 16 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 2 | 
| 17 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'phase' : 2 } | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-combine-elements-after-ooxml-conversion.xsl | 
| 18 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 3 | 
| 19 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-clean-element-names.xsl | 
| 20 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 4 | 
| 21 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx2tei/xml/xml-fix-element-combinations.xsl | 
| 22 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 5 | 


#### **xd2t:tei-conversion** (tei-conversion)
#### Documentation (0)
    
##### 

#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 9)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | dxfs:document-file-info | info |   |   | 
| 5 | p:variable | file |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file | 
| 6 | p:variable | log-output-directory |   |   | 
|   |   |   | select | $debug-path \|\| '/docx2tei/' \|\| $file/@stem \|\| '/teiCorpus' | 
| 7 | p:variable | log-file-name |   |   | 
|   |   |   | select | $file/@stem \|\| '.xml' | 
| 8 | xxml:clean-namespaces |  |   |   | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 22 | 


#### **xd2t:convert** (conversion)
#### Documentation (0)
    
##### 

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| target | name = target \| as = xs:string* \| values = ('TEI', 'text') |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 2)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $target='TEI' | 
| 2 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $target='text' | 


#### **xd2t:docx-to-text**
#### Documentation (0)
    
##### 

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 0)
      
#### Documentation (0)
    
##### 




## dracor-lib.xpl
#### Documentation (0)
    
##### 

#### Namespaces (8)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| tei | http://www.tei-c.org/ns/1.0 |
| xdc | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/dracor |
| xhtml | http://www.w3.org/1999/xhtml |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xs | http://www.w3.org/2001/XMLSchema |
| xxml | https://www.daliboris.cz/ns/xproc/xml |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (1 + 0)
      
#### Documentation (0)
    
##### 


#### **xdc:tei-to-dracor** (tei-to-dracor)
#### Documentation (0)
    
##### 

#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 45)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | p:variable | dracor-id |   |   | 
|   |   |   | href | {$data-file-path-uri} | 
|   |   |   | select | /data/@dracor-id | 
| 5 | p:delete |  |   |   | 
|   |   |   | match | tei:div[@type='editorial'] | 
| 6 | p:delete |  |   |   | 
|   |   |   | match | tei:fileDesc/tei:notesStmt | 
| 7 | p:delete |  |   |   | 
|   |   |   | match | tei:sourceDesc/tei:listWit | 
| 8 | p:delete |  |   |   | 
|   |   |   | match | tei:sourceDesc/tei:msDesc | 
| 9 | p:delete |  |   |   | 
|   |   |   | match | tei:listPerson/tei:head[@xml:lang='cs'] | 
| 10 | p:delete |  |   |   | 
|   |   |   | match | tei:listPerson/tei:head/@xml:lang | 
| 11 | p:delete |  |   |   | 
|   |   |   | match | tei:listPerson/tei:person/tei:persName[@xml:lang='cs'] | 
| 12 | p:delete |  |   |   | 
|   |   |   | match | tei:listPerson/tei:person/tei:occupation | 
| 13 | p:replace |  |   |   | 
|   |   |   | match | tei:listBibl | 
|   |   |   | use-when | false() | 
| 14 | p:delete |  |   |   | 
|   |   |   | match | tei:encodingDesc | 
| 15 | p:delete |  |   |   | 
|   |   |   | match | tei:profileDesc/tei:creation | 
| 16 | p:delete |  |   |   | 
|   |   |   | match | tei:profileDesc/tei:langUsage | 
| 17 | p:delete |  |   |   | 
|   |   |   | match | tei:body/tei:div[@type='title'] | 
| 18 | p:delete |  |   |   | 
|   |   |   | match | tei:text/@* | 
| 19 | p:delete |  |   |   | 
|   |   |   | match | tei:p/@* | 
| 20 | p:delete |  |   |   | 
|   |   |   | match | tei:emph/@rendition | 
| 21 | p:delete |  |   |   | 
|   |   |   | match | tei:facsimile | 
| 22 | p:delete |  |   |   | 
|   |   |   | match | tei:pb/@xml:id | 
| 23 | p:delete |  |   |   | 
|   |   |   | match | tei:pb/@facs | 
| 24 | p:unwrap |  |   |   | 
|   |   |   | match | tei:speaker/tei:persName | 
| 25 | p:delete |  |   |   | 
|   |   |   | match | tei:app/tei:rdg | 
| 26 | p:unwrap |  |   |   | 
|   |   |   | match | tei:app/tei:lem | 
| 27 | p:unwrap |  |   |   | 
|   |   |   | match | tei:app | 
| 28 | p:delete |  |   |   | 
|   |   |   | match | tei:anchor/@subtype | 
| 29 | p:unwrap |  |   |   | 
|   |   |   | match | tei:supplied | 
| 30 | p:rename |  |   |   | 
|   |   |   | match | tei:hi | 
|   |   |   | new-name | tei:emph | 
| 31 | p:add-attribute |  |   |   | 
|   |   |   | attribute-name | place | 
|   |   |   | attribute-value | foot | 
|   |   |   | match | tei:note[@n] | 
| 32 | p:add-attribute |  |   |   | 
|   |   |   | attribute-name | style | 
|   |   |   | attribute-value | font-style: italic; | 
|   |   |   | match | tei:emph[@rend='italic' or @rendition='italic'] | 
|   |   |   | use-when | false() | 
| 33 | p:rename |  |   |   | 
|   |   |   | match | @rendition | 
|   |   |   | new-name | rend | 
| 34 | p:delete |  |   |   | 
|   |   |   | match | tei:space | 
| 35 | p:delete |  |   |   | 
|   |   |   | match | tei:editionStmt | 
| 36 | p:replace |  |   |   | 
|   |   |   | match | tei:availability | 
| 37 | p:unwrap |  |   |   | 
|   |   |   | match | tei:div[@type='scene']/tei:div[tei:div] | 
| 38 | p:insert |  |   |   | 
|   |   |   | match | tei:teiHeader | 
|   |   |   | position | after | 
|   |   |   | use-when | false() | 
| 39 | p:add-attribute |  |   |   | 
|   |   |   | attribute-name | xml:id | 
|   |   |   | attribute-value | {$dracor-id} | 
|   |   |   | match | tei:TEI | 
| 40 | p:insert |  |   |   | 
|   |   |   | match | tei:TEI | 
|   |   |   | position | before | 
| 41 | p:unwrap |  |   |   | 
|   |   |   | match | tei:ref[starts-with(@target, '#')][. = 'Potipharis'] | 
| 42 | p:delete |  |   |   | 
|   |   |   | match | tei:note[tei:person][count(*) eq 1] | 
| 43 | p:delete |  |   |   | 
|   |   |   | match | tei:person/tei:note[@type='bio'] | 
| 44 | xxml:clean-namespaces |  |   |   | 
| 45 | p:identity |  |   |   | 



## evt-play-lib.xpl
#### Documentation (0)
    
##### 

#### Namespaces (10)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| tei | http://www.tei-c.org/ns/1.0 |
| xevt | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpefc | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/common |
| xs | http://www.w3.org/2001/XMLSchema |
| xxml | https://www.daliboris.cz/ns/xproc/xml |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

#### Options (0)
      
| name | properties |
| --- | --- |

### Steps  (6 + 0)
      
#### Documentation (0)
    
##### 


#### **xevt:move-front**
#### Documentation (0)
    
##### 

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/evt/evt-move-front-to-body.xsl | 
| 4 | xxml:clean-namespaces |  |   |   | 


#### **xevt:divide-texts** (dividing-texts)
#### Documentation (0)
    
##### 

#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory-path | name = output-directory-path \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | output-directory-path-uri |   |   | 
|   |   |   | select | resolve-uri($output-directory-path, $base-uri) | 
| 4 | xxml:clean-namespaces |  |   |   | 
| 5 | p:for-each |  |   |   | 
|   |   |   | select | //tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse') or contains(@xml:id, 'preklad')]] | 
| 6 | p:identity |  |   |   | 
|   |   |   | pipe | source@dividing-texts | 


#### **xevt:include-texts** (including-texts)
#### Documentation (0)
    
##### 

#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | p:replace |  |   |   | 
|   |   |   | match | /tei:teiCorpus//tei:listPerson | 
|   |   |   | href | {$data-file-path-uri} | 
|   |   |   | select | /data/tei:listPerson | 
| 5 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-change-text-to-include.xsl | 
| 6 | xxml:clean-namespaces |  |   |   | 


#### **xevt:tei-to-evt** (tei-to-evt)
#### Documentation (0)
    
##### 

#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |
| output-directory-path | name = output-directory-path \| as = xs:string? |
| output-file-name | name = output-file-name \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 15)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | p:variable | output-file-path-uri |   |   | 
|   |   |   | select | resolve-uri(concat($output-directory-path, '/', $output-file-name), $base-uri) | 
| 5 | xpefc:add-persName-to-speaker |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
| 6 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | p:use-when | $enable-logging | 
|   |   |   | step | 1 | 
| 7 | p:delete |  |   |   | 
|   |   |   | match | //*[@source='#dracor'] | 
| 8 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | p:use-when | $enable-logging | 
|   |   |   | step | 2 | 
| 9 | p:viewport |  |   |   | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse')]] | 
| 10 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | p:use-when | $enable-logging | 
|   |   |   | step | 3 | 
| 11 | xevt:divide-texts |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path} | 
| 12 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | p:use-when | $enable-logging | 
|   |   |   | step | 4 | 
| 13 | xevt:include-texts |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
| 14 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | p:use-when | $enable-logging | 
|   |   |   | step | 5 | 
| 15 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | not(empty($output-directory-path) or empty($output-file-name)) | 


#### **xevt:validate-hierarchies** (validating-hierarchies)
#### Documentation (0)
    
##### 

#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |
| output-directory-path | name = output-directory-path \| as = xs:string? |
| output-file-name | name = output-file-name \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | p:variable | output-file-path-uri |   |   | 
|   |   |   | select | resolve-uri(concat($output-directory-path, '/', $output-file-name), $base-uri) | 
| 5 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/validation/hierarchy-overview.xsl | 
| 6 | p:store |  |   |   | 
|   |   |   | href | {$output-file-path-uri} | 


#### **xevt:zip** (zipping)
#### Documentation (0)
    
##### 

#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |
| input-directory-path | name = input-directory-path \| as = xs:string? |
| output-directory-path | name = output-directory-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:identity |  |   |   | 



## hub2tei-lib.xpl
#### Documentation (0)
    
##### 

#### Namespaces (16)
    
| prefix | string |
| --- | --- |
| css | http://www.w3.org/1996/css |
| dxfs | https://www.daliboris.cz/ns/xproc/file-system |
| fs | https://www.daliboris.cz/ns/file-system |
| hub | http://docbook.org/ns/docbook |
| p | http://www.w3.org/ns/xproc |
| tei | http://www.tei-c.org/ns/1.0 |
| xevt | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt |
| xh2t | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/hub2tei |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpl | https://www.daliboris.cz/ns/xproc/pipeline |
| xs | http://www.w3.org/2001/XMLSchema |
| xtei | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei |
| xxml | https://www.daliboris.cz/ns/xproc/xml |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (3 + 0)
      
#### Documentation (0)
    
##### 


#### **xh2t:input-processing** (input-processing)
#### Documentation (0)
    
##### 

#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 21)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | dxfs:document-file-info | info |   |   | 
| 4 | p:variable | file |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file | 
| 5 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 6 | p:variable | log-output-directory |   |   | 
|   |   |   | select | $debug-path \|\| '/hub2tei/' \|\| $file/@stem | 
| 7 | p:variable | log-file-name |   |   | 
|   |   |   | select | $file/@stem \|\| '.xml' | 
| 8 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/hub/hub-remove-fw.xsl | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 1 | 
| 10 | p:xslt |  |   |   | 
|   |   |   | href | ../Xslt/hub/hub-split2section.xsl | 
| 11 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 2 | 
| 12 | p:xslt |  |   |   | 
|   |   |   | href | ../Xslt/hub/hub-group-notes.xsl | 
| 13 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 3 | 
| 14 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/hub/hub-move-sections.xsl | 
| 15 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 4 | 
| 16 | p:xslt |  |   |   | 
|   |   |   | href | ../Xslt/hub/hub-preclean-typos.xsl | 
| 17 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 5 | 
| 18 | p:xslt |  |   |   | 
|   |   |   | href | ../Xslt/hub/hub-clean-typos.xsl | 
| 19 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 6 | 
| 20 | p:delete |  |   |   | 
|   |   |   | match | hub:section[@role='figure'] | 
| 21 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 7 | 


#### **xh2t:tei-conversion** (tei-conversion)
#### Documentation (0)
    
##### 

#### Documentation (47)
    
#### Documentation (379)
    
#### Documentation (458)
    
#### Documentation (194)
    
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 59)
      
#### Documentation (0)
    
##### 

#### Documentation (47)
    
#### Documentation (379)
    
#### Documentation (458)
    
#### Documentation (194)
    


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | dxfs:document-file-info | info |   |   | 
| 5 | p:variable | file |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file | 
| 6 | p:variable | log-output-directory |   |   | 
|   |   |   | select | $debug-path \|\| '/hub2tei/' \|\| $file/@stem \|\| '/teiCorpus' | 
| 7 | p:variable | log-file-name |   |   | 
|   |   |   | select | $file/@stem \|\| '.xml' | 
| 8 | p:viewport |  |   |   | 
|   |   |   | match | hub:hub/hub:section | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 1 | 
| 10 | p:rename |  |   |   | 
|   |   |   | match | hub:hub | 
|   |   |   | new-name | tei:teiCorpus | 
| 11 | p:add-attribute |  |   |   | 
|   |   |   | attribute-name | xml:lang | 
|   |   |   | attribute-value | la | 
|   |   |   | match | tei:teiCorpus | 
| 12 | p:delete |  |   |   | 
|   |   |   | match | tei:teiCorpus/@version | 
| 13 | p:delete |  |   |   | 
|   |   |   | match | tei:teiCorpus/@css:version | 
| 14 | p:delete |  |   |   | 
|   |   |   | match | tei:teiCorpus/@css:rule-selection-attribute | 
| 15 | p:insert |  |   |   | 
|   |   |   | href | {$data-file-path-uri} | 
|   |   |   | select | //tei:teiHeader | 
|   |   |   | match | tei:teiCorpus | 
|   |   |   | position | first-child | 
| 16 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 2 | 
| 17 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-text-kind-of.xsl | 
| 18 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 3 | 
| 19 | xxml:clean-namespaces |  |   |   | 
| 20 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 4 | 
| 21 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-arrange-play-hierarchy.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 22 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 5 | 
| 23 | p:viewport | play-text |   |   | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 24 | xxml:clean-namespaces |  |   |   | 
| 25 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 6 | 
| 26 | p:viewport |  |   |   | 
|   |   |   | match | tei:TEI[tei:text[@n=('Synopse')]] | 
| 27 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 7 | 
| 28 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'data-file-path' : $data-file-path-uri } | 
|   |   |   | href | ../xslt/tei/tei-assign-persons.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 29 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 8 | 
| 30 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'data-file-path' : $data-file-path-uri } | 
|   |   |   | href | ../xslt/tei/tei-assign-line-number-iterating.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 31 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 9 | 
| 32 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-assign-note-by-line.xsl | 
| 2 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-notes-to-critical-apparatus.xsl | 
| 3 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-speaker-remove-colon.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]]/tei:text/tei:body | 
|   |   |   | use-when | true() | 
| 33 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 10 | 
| 34 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/angelus/angelus-assign-line-number-cantus.xsl | 
| 2 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/angelus/angelus-divide-line-in-cantus.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 35 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 11 | 
| 36 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-square-brackets-to-supplied.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 37 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 12 | 
| 38 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-separate-cantus-div.xsl | 
| 2 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-divide-speech.xsl | 
| 3 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-group-speeches-by-divison.xsl | 
| 4 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-arrange-div-hieararchy.xsl | 
| 5 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-add-n-to-num-divs.xsl | 
| 6 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-add-n-to-intermediate-divs.xsl | 
| 7 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-group-sp-without-div.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 39 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 12 | 
| 40 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/angelus/angelus-move-note-to-speaker.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 41 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 13 | 
| 42 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-pb-add-id.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse')]] | 
| 43 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 14 | 
| 44 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/angelus/angelus-normalize-indentation-spaces.xsl | 
| 2 | p:xslt |  |   |   | 
|   |   |   | href | ../Xslt/angelus-add-spaces-to-cantus.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad', 'Synopse')]] | 
|   |   |   | use-when | true() | 
| 45 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 15 | 
| 46 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-add-facsimile.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Synopse')]] | 
| 47 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 16 | 
| 48 | p:delete |  |   |   | 
|   |   |   | match | tei:div/@level | 
| 49 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 17 | 
| 50 | p:delete |  |   |   | 
|   |   |   | match | tei:div/*[position() =last()][self::tei:p[@class='division']] | 
| 51 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 18 | 
| 52 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-cleaning-markup.xsl | 
| 53 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 19 | 
| 54 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-add-rend-to-space.xsl | 
| 55 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 20 | 
| 56 | xtei:add-lang-usage |  |   |   | 
| 57 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 21 | 
| 58 | p:viewport |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-sp-clean.xsl | 
| 2 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-sp-ad-missing.xsl | 
|   |   |   | match | tei:TEI[tei:text[@n=('Text edice', 'Překlad')]] | 
| 59 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 22 | 


#### **xh2t:section-to-tei** (section-to-tei)
#### Documentation (0)
    
##### 

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |
| position | name = position \| as = xs:integer |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 57)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 4 | dxfs:document-file-info | info |   |   | 
| 5 | p:variable | file |   |   | 
|   |   |   | pipe | report@info | 
|   |   |   | select | /fs:file | 
| 6 | p:variable | log-output-directory |   |   | 
|   |   |   | select | $debug-path \|\| '/hub2tei/' \|\| $file/@stem \|\| '/section-' \|\| $position | 
| 7 | p:variable | log-file-name |   |   | 
|   |   |   | select | $file/@stem \|\| '.xml' | 
| 8 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/hub2tei.xsl | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 1 | 
| 10 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-clean-formatting.xsl | 
| 11 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 2 | 
| 12 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-group-elements.xsl | 
| 13 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 3 | 
| 14 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-arrange-elements.xsl | 
| 15 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 4 | 
| 16 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-group-vertical-space.xsl | 
| 17 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 5 | 
| 18 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-clean-elements.xsl | 
| 19 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 6 | 
| 20 | p:insert |  |   |   | 
|   |   |   | href | {$data-file-path-uri} | 
|   |   |   | select | /data/tei:text | 
|   |   |   | match | tei:front | 
| 21 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/nepomuk/nepomuk-add-editorial-to-front.xsl | 
| 22 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 7 | 
| 23 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-group-speeches.xsl | 
| 24 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 8 | 
| 25 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-move-division-p.xsl | 
| 26 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 9 | 
| 27 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-move-trailer.xsl | 
| 28 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 10 | 
| 29 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-move-pb.xsl | 
| 30 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 11 | 
| 31 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-drama-hierarchy.xsl | 
| 32 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 12 | 
| 33 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-synopsis-add-n-to-div.xsl | 
| 34 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 13 | 
| 35 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-move-trailer.xsl | 
| 36 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 14 | 
| 37 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-drama-hierarchy-missing-levels.xsl | 
| 38 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 15 | 
| 39 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-move-trailer.xsl | 
| 40 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 16 | 
| 41 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-drama-hierarchy-missing-levels-n.xsl | 
| 42 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 17 | 
| 43 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-drama-hierarchy-missing-levels-n.xsl | 
| 44 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 18 | 
| 45 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-drama-hierarchy-missing-levels-n.xsl | 
| 46 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 19 | 
| 47 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-div-notes.xsl | 
| 48 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 20 | 
| 49 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-group-speaker-divs.xsl | 
| 50 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 21 | 
| 51 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/angelus/angelus-group-speaker-divs-correct.xsl | 
| 52 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 22 | 
| 53 | p:wrap |  |   |   | 
|   |   |   | match | tei:text | 
|   |   |   | wrapper | tei:TEI | 
| 54 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 23 | 
| 55 | p:insert |  |   |   | 
|   |   |   | href | {$data-file-path-uri} | 
|   |   |   | select | //tei:teiHeader | 
|   |   |   | match | tei:TEI | 
|   |   |   | position | first-child | 
| 56 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$log-file-name} | 
|   |   |   | output-directory | {$log-output-directory} | 
|   |   |   | step | 24 | 
| 57 | xxml:clean-namespaces |  |   |   | 



## pef-xpc-lib-base.xpl
#### Documentation (37)
    
##### Plays Encoding Framework Base Library

#### Namespaces (12)
    
| prefix | string |
| --- | --- |
| dxar | https://www.daliboris.cz/ns/xproc/archive |
| dxd | https://www.daliboris.cz/ns/xproc/docx |
| p | http://www.w3.org/ns/xproc |
| tei | http://www.tei-c.org/ns/1.0 |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xpefc | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/common |
| xpl | https://www.daliboris.cz/ns/xproc/pipeline |
| xs | http://www.w3.org/2001/XMLSchema |
| xsl | http://www.w3.org/1999/XSL/Transform |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (4 + 0)
      
#### Documentation (37)
    
##### Plays Encoding Framework Base Library


#### **xpef:docx-processing** (docx-processing)
#### Documentation (16)
    
##### input-processing

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | ticket-in | false |
| output | **result** | true |
| output | ticket-out | false |

### Steps  (0 + 21)
      
#### Documentation (16)
    
##### input-processing



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | content-type |   |   | 
|   |   |   | select | p:document-property(/, 'Q{}' \|\| 'content-type') | 
| 4 | p:variable | file-stem |   |   | 
|   |   |   | select | tokenize(base-uri(/), '/')[last()] ! substring-before(., '.') | 
| 5 | p:variable | output-temp-directory |   |   | 
|   |   |   | select | if($debug) then string-join(( $debug-path-uri, $file-stem, 'docx-processing'), '/')  else () | 
| 6 | dxd:get-ooxml-content |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | content | document | 
|   |   |   | debug-path | {$debug-path} | 
| 7 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$file-stem}.xml | 
|   |   |   | output-directory | {$output-temp-directory} | 
|   |   |   | step | 1 | 
| 8 | dxd:process-revisions-ooxml |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | operation | accept | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$file-stem}.xml | 
|   |   |   | output-directory | {$output-temp-directory} | 
|   |   |   | step | 5 | 
| 10 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/common/character-maps.xsl | 
| 11 | p:file-create-tempfile |  |   |   | 
|   |   |   | delete-on-exit | true | 
|   |   |   | suffix | .xml | 
| 12 | p:variable | href-tempfile-uri |   |   | 
|   |   |   | select | xs:anyURI(.) | 
| 13 | p:store |  |   |   | 
|   |   |   | pipe | result@character-maps | 
|   |   |   | href | {$href-tempfile-uri} | 
| 14 | p:load |  |   |   | 
|   |   |   | href | {$href-tempfile-uri} | 
| 15 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/docx/docx-document-to-text.xsl | 
| 16 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$file-stem}.txt | 
|   |   |   | output-directory | {$output-temp-directory} | 
|   |   |   | step | 10 | 
| 17 | p:file-create-tempfile |  |   |   | 
|   |   |   | delete-on-exit | true | 
|   |   |   | suffix | .txt | 
| 18 | p:variable | href-tempfile-uri |   |   | 
|   |   |   | select | xs:anyURI(.) | 
| 19 | p:store |  |   |   | 
|   |   |   | pipe | result@docx-text | 
|   |   |   | href | {$href-tempfile-uri} | 
| 20 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'href' : $href-tempfile-uri } | 
|   |   |   | href | ../xslt/docx/text-clean-lines.xsl | 
| 21 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$file-stem}.xml | 
|   |   |   | output-directory | {$output-temp-directory} | 
|   |   |   | step | 15 | 


#### **xpef:input-processing** (input-processing)
#### Documentation (16)
    
##### input-processing

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | ticket-in | false |
| output | **result** | true |
| output | ticket-out | false |

### Steps  (0 + 4)
      
#### Documentation (16)
    
##### input-processing



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | content-type |   |   | 
|   |   |   | select | p:document-property(/, 'Q{}' \|\| 'content-type') | 
| 3 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $content-type = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' | 
| 4 | p:identity |  |   |   | 


#### **xpef:xml-processing** (xml-processing)
#### Documentation (14)
    
##### xml-processing

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | ticket-in | false |
| output | **result** | true |
| output | ticket-out | false |

### Steps  (0 + 1)
      
#### Documentation (14)
    
##### xml-processing



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:identity |  |   |   | 


#### **xpef:create-list-of-speakers** (creating-list-of-speakers)
#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| doc-name | name = doc-name \| as = xs:string \| required = true |
| data-directory-path | name = data-directory-path \| as = xs:anyURI \| required = true |
| data-file-path | name = data-file-path \| as = xs:anyURI \| required = true |

#### Ports (3)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | job-ticket | false |
| output | **result** | true |

### Steps  (0 + 13)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | line-numbers-file-path |   |   | 
|   |   |   | select | concat($data-directory-path, '/', $doc-name, '-line-numbers.xml') | 
| 3 | p:variable | output-temp-directory |   |   | 
|   |   |   | select | $debug-path \|\| '/' \|\| $doc-name \|\| '/' \|\| 'create-list-of-speakers' | 
| 4 | p:variable | data-file-path-uri |   |   | 
|   |   |   | select | resolve-uri($data-file-path, $base-uri) | 
| 5 | p:variable | file-stem |   |   | 
|   |   |   | select | $doc-name | 
| 6 | p:identity | original |   |   | 
| 7 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
| 1 | p:xquery |  |   |   | 
|   |   |   | href | ../xquery/tei-assign-line-number.xquery | 
| 2 | p:xslt |  |   |   | 
|   |   |   | parameters | map {      'line-numbers-file-path' : $data-file-path-uri      } | 
|   |   |   | pipe | source@creating-list-of-speakers | 
|   |   |   | href | ../xslt/common/tei-assign-line-number-iterating.xsl | 
|   |   |   | test | false() | 
| 2 | p:otherwise |  |   |   | 
| 1 | p:xslt |  |   |   | 
|   |   |   | parameters | map {      'line-numbers-file-path' : $data-file-path-uri      } | 
|   |   |   | pipe | source@creating-list-of-speakers | 
|   |   |   | href | ../xslt/common/tei-assign-line-number-iterating.xsl | 
| 8 | p:viewport | play-text |   |   | 
| 1 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | false() | 
| 2 | p:otherwise |  |   |   | 
|   |   |   | match | tei:TEI | 
| 9 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$file-stem}.xml | 
|   |   |   | output-directory | {$output-temp-directory} | 
|   |   |   | step | 1 | 
| 10 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/common/tei-add-who-to-sp.xsl | 
| 11 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$file-stem}.xml | 
|   |   |   | output-directory | {$output-temp-directory} | 
|   |   |   | step | 5 | 
| 12 | xpefc:add-persName-to-speaker | corpus |   |   | 
| 13 | xlog:store |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug | {$debug} | 
|   |   |   | file-name | {$file-stem}.xml | 
|   |   |   | output-directory | {$output-temp-directory} | 
|   |   |   | step | 10 | 



## pef-xpc-lib-common.xpl
#### Documentation (39)
    
##### Plays Encoding Framework Common Library

#### Namespaces (6)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpefc | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/common |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (2 + 0)
      
#### Documentation (39)
    
##### Plays Encoding Framework Common Library


#### **xpefc:add**
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 5)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'parameter' : 'value' } | 
|   |   |   | href | ../Xslt/?.xsl | 
| 4 | p:if |  |   |   | 
|   |   |   | test | $debug | 
| 5 | p:store |  |   |   | 
|   |   |   | href | ../result/?.xml | 
|   |   |   | serialization | map{'indent' : true()} | 


#### **xpefc:add-persName-to-speaker**
#### Documentation (0)
    
##### 

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/common/add-persName-to-speaker.xsl | 



## tei-play-lib.xpl
#### Documentation (0)
    
##### 

#### Namespaces (11)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xdc | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/dracor |
| xevt | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/evt |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xpef | https://www.daliboris.cz/ns/xproc/plays-encoding-framework |
| xs | http://www.w3.org/2001/XMLSchema |
| xsl | http://www.w3.org/1999/XSL/Transform |
| xtei | https://www.daliboris.cz/ns/xproc/plays-encoding-framework/tei |
| xxml | https://www.daliboris.cz/ns/xproc/xml |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (5 + 0)
      
#### Documentation (0)
    
##### 


#### **xtei:create-person-list** (creating-person-list)
#### Documentation (0)
    
##### 

#### Options (3)
      
| name | properties |
| --- | --- |
| include-variants | name = include-variants \| as = xs:boolean \| select = false() |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xquery |  |   |   | 
|   |   |   | parameters | map { 'include-variants' : $include-variants} | 
|   |   |   | href | ../xquery/get-listPerson-from-play.xquery | 


#### **xtei:add-lang-usage** (adding-lang-usage)
#### Documentation (0)
    
##### 

#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-add-lang-usage.xsl | 


#### **xtei:postprocessing** (postprocessing)
#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |
| output-directory-path | name = output-directory-path \| as = xs:string? |
| output-file-name | name = output-file-name \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | xdc:tei-to-dracor |  |   |   | 
|   |   |   | pipe | source@postprocessing | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
| 2 | xevt:tei-to-evt | evt |   |   | 
|   |   |   | pipe | source@postprocessing | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | data-file-path | {$data-file-path} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path}/evt | 
| 3 | xevt:validate-hierarchies |  |   |   | 
|   |   |   | pipe | source@postprocessing | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory-path | {$output-directory-path}/validation | 
|   |   |   | output-file-name | {$output-file-name}.html | 
| 4 | xevt:zip |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | input-directory-path | {$output-directory-path}/evt | 
|   |   |   | output-directory-path | {$output-directory-path}/zip | 


#### **xtei:convert** (converting)
#### Options (6)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| data-file-path | name = data-file-path \| as = xs:string? |
| output-directory-path | name = output-directory-path \| as = xs:string? |
| output-file-name | name = output-file-name \| as = xs:string? |
| target | name = target \| as = xs:string* \| values = ('EVT', 'DraCor', 'text') |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | output-directory-path-uri |   |   | 
|   |   |   | select | resolve-uri($output-directory-path, $base-uri) | 
| 4 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $target='DraCor' | 
| 5 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | not(empty($output-directory-path) or empty($output-file-name)) | 
| 6 | p:choose |  |   |   | 
| 1 | p:when |  |   |   | 
|   |   |   | test | $target='text' | 


#### **xtei:tei-to-text**
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 5)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/tei/tei-to-text.xsl | 
| 2 | p:file-create-tempfile |  |   |   | 
|   |   |   | delete-on-exit | true | 
|   |   |   | suffix | .txt | 
| 3 | p:variable | href-tempfile-uri |   |   | 
|   |   |   | select | xs:anyURI(.) | 
| 4 | p:store |  |   |   | 
|   |   |   | pipe | result@tei-to-text | 
|   |   |   | href | {$href-tempfile-uri} | 
| 5 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'href' : $href-tempfile-uri } | 
|   |   |   | href | ../xslt/docx/text-clean-lines.xsl | 



## xproc-project-setup.xpl
#### **default**
#### Documentation (0)
    
##### 

#### Namespaces (6)
    
| prefix | string |
| --- | --- |
| c | http://www.w3.org/ns/xproc-step |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xps | https://www.daliboris.cs/ns/xproc/project/setup |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| saxon-version | name = saxon-version \| as = xs:string \| select = '12.3' |
| morgana-version | name = morgana-version \| as = xs:string \| select = '1.6.4' |

#### Ports (1)
    
| direction | value | primary |
| --- | --- | ---| 
| output | **result** | true |

### Steps  (7 + 7)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | xps:create-directories |  |   |   | 
| 4 | xps:download-morgana |  |   |   | 
|   |   |   | version | {$morgana-version} | 
| 5 | xps:download-saxon |  |   |   | 
|   |   |   | version | {$saxon-version} | 
| 6 | xps:setup-morgana |  |   |   | 
|   |   |   | morgana-version | {$morgana-version} | 
|   |   |   | saxon-version | {$saxon-version} | 
| 7 | p:directory-list |  |   |   | 
|   |   |   | max-depth | unbounded | 
|   |   |   | path | ../ | 

#### **xps:create-directories**
### Steps  (0 + 21)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../../doc | 
| 2 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../../run | 
| 3 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../../input/text/docx | 
| 4 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../../input/text/hub | 
| 5 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../../input/text/tei | 
| 6 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../../output | 
| 7 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../_debug | 
| 8 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../_temp | 
| 9 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../etalon | 
| 10 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../schema/schematron | 
| 11 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../schema/xsd | 
| 12 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../schema/rng | 
| 13 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../settings | 
| 14 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../morgana | 
| 15 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../tests | 
| 16 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../input/text/docx | 
| 17 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../input/text/xml | 
| 18 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../input/text/hub | 
| 19 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../output/text/tei | 
| 20 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../xslt | 
| 21 | p:file-mkdir |  |   |   | 
|   |   |   | href | ../xquery | 


#### **xps:create-gitignore**
### Steps  (0 + 3)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:file-info |  |   |   | 
|   |   |   | fail-on-error | false | 
|   |   |   | href | ../../.gitignore | 
| 2 | p:variable | file-exists |   |   | 
|   |   |   | select | exists(/c:file) | 
| 3 | p:if |  |   |   | 
|   |   |   | test | not($file-exists) | 


#### **xps:download-morgana**
#### Options (1)
      
| name | properties |
| --- | --- |
| version | name = version \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | result | false |

### Steps  (0 + 9)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | file-name |   |   | 
|   |   |   | select | 'MorganaXProc-IIIse-' \|\| $version \|\| '.zip' | 
| 2 | p:file-info |  |   |   | 
|   |   |   | fail-on-error | false | 
|   |   |   | href | ../morgana/{$file-name} | 
| 3 | p:variable | file-exists |   |   | 
|   |   |   | select | exists(/c:file) | 
| 4 | p:if |  |   |   | 
|   |   |   | test | not($file-exists) | 
| 5 | p:load |  |   |   | 
|   |   |   | href | ../morgana/{$file-name} | 
| 6 | p:unarchive |  |   |   | 
|   |   |   | exclude-filter | ^__MACOSX/ | 
|   |   |   | relative-to | {p:document-property(/, 'base-uri')} | 
| 7 | p:for-each |  |   |   | 
| 8 | p:sink |  |   |   | 
| 9 | p:directory-list |  |   |   | 
|   |   |   | max-depth | unbounded | 
|   |   |   | path | ../morgana | 


#### **xps:setup-morgana**
#### Options (2)
      
| name | properties |
| --- | --- |
| saxon-version | name = saxon-version \| as = xs:string \| required = true |
| morgana-version | name = morgana-version \| as = xs:string \| required = true |

### Steps  (0 + 2)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:file-copy |  |   |   | 
|   |   |   | href | ../_temp/saxon/saxon-he-{$saxon-version}.jar | 
|   |   |   | target | ../morgana/MorganaXProc-IIIse-{$morgana-version}/MorganaXProc-IIIse_lib/saxon-he-{$saxon-version}.jar | 
| 2 | p:file-copy |  |   |   | 
|   |   |   | href | ../_temp/saxon/saxon-he-xqj-{$saxon-version}.jar | 
|   |   |   | target | ../morgana/MorganaXProc-IIIse-{$morgana-version}/MorganaXProc-IIIse_lib/saxon-he-xqj-{$saxon-version}.jar | 


#### **xps:download-saxon**
#### Options (1)
      
| name | properties |
| --- | --- |
| version | name = version \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | result | false |

### Steps  (0 + 11)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | url-version |   |   | 
|   |   |   | select | replace($version, '\.', '-') | 
| 2 | p:variable | file-name |   |   | 
|   |   |   | select | 'SaxonHE' \|\| $version \|\| 'J.zip' | 
| 3 | p:variable | url-file-name |   |   | 
|   |   |   | select | 'SaxonHE' \|\| $url-version \|\| 'J.zip' | 
| 4 | p:file-info |  |   |   | 
|   |   |   | fail-on-error | false | 
|   |   |   | href | ../_temp/saxon/{$file-name} | 
| 5 | p:variable | file-exists |   |   | 
|   |   |   | select | exists(/c:file) | 
| 6 | p:if |  |   |   | 
|   |   |   | test | not($file-exists) | 
| 7 | p:load |  |   |   | 
|   |   |   | href | ..//_temp/saxon/{$file-name} | 
| 8 | p:unarchive |  |   |   | 
|   |   |   | relative-to | {p:document-property(/, 'base-uri')} | 
| 9 | p:for-each |  |   |   | 
| 10 | p:sink |  |   |   | 
| 11 | p:directory-list |  |   |   | 
|   |   |   | max-depth | unbounded | 
|   |   |   | path | ../_temp/saxon | 


#### **xps:download-schemas**
#### Ports (1)
    
| direction | value | primary |
| --- | --- | ---| 
| output | result | false |

### Steps  (0 + 9)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | xps:download-file |  |   |   | 
|   |   |   | file-name | dracor-schema-v1.0.0-beta.4.rng | 
|   |   |   | target-directory | ../schema/rng | 
|   |   |   | url | https://github.com/dracor-org/dracor-schema/releases/download/v1.0.0-beta.4/dracor-schema-v1.0.0-beta.4.rng | 
| 2 | xps:download-file |  |   |   | 
|   |   |   | file-name | dracor-schema-v1.0.0-beta.4.sch | 
|   |   |   | target-directory | ../schema/schematron | 
|   |   |   | url | https://github.com/dracor-org/dracor-schema/releases/download/v1.0.0-beta.4/dracor-schema-v1.0.0-beta.4.sch | 
| 3 | xps:download-file |  |   |   | 
|   |   |   | file-name | dracor-schema-v1.0.0-beta.4.sch | 
|   |   |   | target-directory | ../schema/schematron | 
|   |   |   | url | https://github.com/dracor-org/dracor-schema/releases/download/v1.0.0-beta.4/dracor-schema-v1.0.0-beta.4.sch | 
| 4 | xps:download-file |  |   |   | 
|   |   |   | file-name | hub.rng | 
|   |   |   | target-directory | ../schema/rng | 
|   |   |   | url | https://raw.githubusercontent.com/le-tex/Hub/refs/heads/master/hub.rng | 
| 5 | xps:download-file |  |   |   | 
|   |   |   | file-name | cssa-publisher-extensions.rng | 
|   |   |   | target-directory | ../schema/rng/css | 
|   |   |   | url | https://raw.githubusercontent.com/le-tex/CSSa/6ea9e14d9ffe551f7bbdd8fe1e9db5830e28f85e/cssa-publisher-extensions.rng | 
| 6 | xps:download-file |  |   |   | 
|   |   |   | file-name | cssa-rules.rng | 
|   |   |   | target-directory | ../schema/rng/css | 
|   |   |   | url | https://raw.githubusercontent.com/le-tex/CSSa/6ea9e14d9ffe551f7bbdd8fe1e9db5830e28f85e/cssa-rules.rng | 
| 7 | xps:download-file |  |   |   | 
|   |   |   | file-name | css.rng | 
|   |   |   | target-directory | ../schema/rng/css | 
|   |   |   | url | https://raw.githubusercontent.com/le-tex/CSSa/6ea9e14d9ffe551f7bbdd8fe1e9db5830e28f85e/css.rng | 
| 8 | xps:download-file |  |   |   | 
|   |   |   | file-name | docbook.rng | 
|   |   |   | target-directory | ../schema/rng/dbk | 
|   |   |   | url | https://raw.githubusercontent.com/le-tex/Hub/refs/heads/master/dbk/docbook.rng | 
| 9 | p:directory-list |  |   |   | 
|   |   |   | max-depth | unbounded | 
|   |   |   | path | ../schema | 


#### **xps:download-file**
#### Options (3)
      
| name | properties |
| --- | --- |
| file-name | name = file-name \| as = xs:string |
| url | name = url \| as = xs:anyURI |
| target-directory | name = target-directory \| as = xs:string |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | result | false |

### Steps  (0 + 3)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:file-info |  |   |   | 
|   |   |   | fail-on-error | false | 
|   |   |   | href | {$target-directory}/{$file-name} | 
| 2 | p:variable | file-exists |   |   | 
|   |   |   | select | exists(/c:file) | 
| 3 | p:if |  |   |   | 
|   |   |   | test | not($file-exists) | 



