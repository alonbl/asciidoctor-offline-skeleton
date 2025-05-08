#!/bin/sh

set -e

ASCIIDOCFX_VERSION="1.8.10"
ASCIIDOCTORJ_VERSION="3.0.0"
JLATEXMATH_VERSION="1.0.7"
HIGHLIGHT_VERSION="11.11.1"
PLANTUML_VERSION="1.2025.2"
GRAPHVIZ_WIN_VERSION="12.2.1"

mkdir -p downloads
cd downloads

if [ "${DOWNLOAD_FULL}" -ne 0 ]; then

	# Windows
	wget --continue "https://github.com/asciidocfx/AsciidocFX/releases/download/v${ASCIIDOCFX_VERSION}/AsciidocFX_Windows.exe"
	wget --continue "https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/${GRAPHVIZ_WIN_VERSION}/windows_10_cmake_Release_graphviz-install-${GRAPHVIZ_WIN_VERSION}-win64.exe"

	# Linux
	wget --continue "https://github.com/asciidocfx/AsciidocFX/releases/download/v${ASCIIDOCFX_VERSION}/AsciidocFX_Linux.tar.gz"
	# apt install graphviz

	wget --continue "https://pdf.plantuml.net/PlantUML_Language_Reference_Guide_en.pdf"
fi

# Generic
wget --continue -O "asciidoctorj-${ASCIIDOCTORJ_VERSION}-bin.zip" "http://search.maven.org/remotecontent?filepath=org/asciidoctor/asciidoctorj/${ASCIIDOCTORJ_VERSION}/asciidoctorj-${ASCIIDOCTORJ_VERSION}-bin.zip"
wget --continue "https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-mit-${PLANTUML_VERSION}.jar"
wget --continue "https://repo1.maven.org/maven2/org/scilab/forge/jlatexmath/${JLATEXMATH_VERSION}/jlatexmath-${JLATEXMATH_VERSION}.jar"

# Offline
wget --continue "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/${HIGHLIGHT_VERSION}/highlight.min.js"
wget --continue "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/${HIGHLIGHT_VERSION}/styles/github.min.css"
