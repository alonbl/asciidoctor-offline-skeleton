# Asciidoctor Skeleton Project

## Prerequisites

Refer to `util/download.sh` for download hints.

### Mandatory

* [asciidoctorj](https://github.com/asciidoctor/asciidoctorj): binary distribution used to generate the docs.
* >=Java-11: for asciidoctorj
  * ubuntu: use distribution JRE
  * windows: use [Microsoft](https://docs.microsoft.com/en-us/java/openjdk/download).

### Optional

* [AsciidocFX](https://github.com/asciidocfx/AsciidocFX): visual editor.
* [plantuml](https://plantuml.com/) (mit licensed): design diagrams as standalone.
  * [graphviz](https://www.graphviz.org/)
     * ubuntu: use distribution graphviz
     * windows: https://www.graphviz.org/download/#windows
  * [jlatexmath](https://github.com/opencollab/jlatexmath): optional, math statements.

## Installation

Set the following environment variables in your `~/.bash_profile`:

* `ASCIIDOCTORJ_JAVA_HOME`: Java Home to use.
* `ASCIIDOCTORJ_HOME`: The directory you extracted asciidoctorj archive.

## Build

```sh
./build
```
