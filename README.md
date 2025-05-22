# Plays Encoding Framework

Plays Encoding Framework for conversion and encoding plays in TEI format

## Prerequisites

- [Java 11](https://www.azul.com/downloads/?version=java-11-lts&package=jdk#zulu "Download Azul Zulu OpenJDK")
- [Saxon-HE 12.3](https://github.com/Saxonica/Saxon-HE/releases/tag/SaxonHE12-7 "Download SaxonHE12-7J")
- [MorganaXProc-IIIse 1.6.7](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.6.7/ "Donwload MorganaXProc-IIIse 1.6.7")

### Setting up the environment

- [ ] Install Java JDK 11
- [ ] Extract content of the [MorganaXProc-IIIse-1.6.7.zip](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.6.7/MorganaXProc-IIIse-1.6.7.zip/download "Donwload MorganaXProc-IIIse 1.6.7.zip file")
- [ ] Extract content of the [SaxonHE12-5J.zip](https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-7/SaxonHE12-7J.zip "Download SaxonHE12-7J") file
  - [ ] copy extracted `saxon-he-12.7.jar` and `saxon-he-xqj-12.7.jar` files to the `MorganaXProc-IIIse_lib` folder
- [ ] On your operating system, set environment `PATH` variable to point to the location of the `MorganaXProc-IIIse` folder
- for example on Windows:
  - (run command line as usual user): `setx PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`
  - (run command line as administrator): `setx /m PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`
    - [switch](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/setx) `/m`: Specifies to set the variable in the system environment. The default setting is the local environment.

#### MorganaXProc-IIIse configuration

Open `config.xml` file distributed with MorganaXProc-IIIse application.

Add following lines inside `<morgana-config>` element:

```xml
<xslt-connector>saxon12-3</xslt-connector>
<xquery-connector>saxon12-3</xquery-connector>
```

Save `config.xml` file.

For more details, please consult official [user manual](https://xml-project.com/manual/index.html).

### Runnig pipeline

Use pipelines stored in the [`run`](./run) directory in file with `.xpl` extension.

You can modify options. Frequently used options and their meaning:

- `debug-path`: directory used for storing temporary files (for debugging)
- `data-file-path`: file with metadata for file to be converted; data files are usualy stored in the [`data`](./data) directory
- `output-directory-path`: directory used for storing result files
- `output-file-name`: the name of the file stored in the output directory, withou extension

If use directory names `_debug`, `_output` or `_temp`, they will not be synchronized with the GitHub repository.

#### Running from command line

Run existing Xproc 3.0 pipeline from the command line using batch file.

Example of the batch file located in the [cmd](../cmd) directory that runs `docx2dracor.xpl` file with inputs or parameters. Path can be absolute, or relative. Please, use forward slashes in the file path, even in Windows.

```script
@echo off
Morgana.bat ^
-config=file:/D:/Programy/Xml/Morgana-run/config.xml ^
../run/docx2dracor.xpl ^
-input:source=../src/input/text/docx/dracor/Gnapheus-Acolastus_markup_v5.docx ^
-input:job-ticket=../data/translatin-ticket.xml ^
-option:data-file-path=../data/local.gnapheus-acolastus-data.xml ^
-option:output-directory-path=../_output ^
-option:output-file-name=Gnapheus-Acolastus ^
-option:debug-path=../_debug
```

Version for macOS:

```script
#!/bin/bash

# Spuštění Morgana s příslušnými parametry
./Morgana.sh \
  -config=file:$(pwd)/../Morgana-run/config.xml \
  ../run/docx2dracor.xpl \
  -input:source=../src/input/text/docx/dracor/Gnapheus-Acolastus_markup_v5.docx \
  -input:job-ticket=../data/translatin-ticket.xml \
  -option:data-file-path=../data/local.gnapheus-acolastus-data.xml \
  -option:output-directory-path=../_output \
  -option:output-file-name=Gnapheus-Acolastus \
  -option:debug-path=../_debug
```


### Available pipelines

#### hub2tei.xpl

Converts plays in [hub format](https://transpect.github.io) to XML according to [TEI](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html) and [DraCor](https://dracor.org/doc/odd) standards, and for [EVT Viewer](http://evt.labcd.unipi.it).

#### docx2tei.xpl

Converts critical editions in DOCX documents to XML according to the [TEI](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html) and [DraCor](https://dracor.org/doc/odd) standards, and for [EVT Viewer](http://evt.labcd.unipi.it).

#### docx2dracor.xpl

Converts editions in DOCX documents to XML according to the [DraCor](https://dracor.org/doc/odd) standard.

#### setup.xpl

Downloads and updates resources for the conversion and validation, like MorganaXProc-IIIse runtime, Saxon-HE libraries and RNG or XML schemas. 