#!/bin/sh

set -e

mkdir -p highlightjs/styles
ln -sf ../downloads/highlight.min.js highlightjs/highlight.min.js
ln -sf ../../downloads/github.min.css highlightjs/styles/github.min.css

mkdir -p tools
( cd tools && unzip -o ../downloads/asciidoctorj-*-bin.zip )

cd tools
ln -sf asciidoctorj* asciidoctorj
ln -sf ../downloads/plantuml-*.jar plantuml.jar
ln -sf ../downloads/jlatexmath-*.jar jlatexmath.jar
cd ..

if [ "$(uname)" = "Linux" ]; then
	INSTALL=""
	command -v dot > /dev/null || INSTALL="${INSTALL} graphviz"
	command -v java > /dev/null || INSTALL="${INSTALL} openjdk-21-jre-headless"
	[ -z "${INSTALL}" ] || sudo apt install ${INSTALL}
fi
