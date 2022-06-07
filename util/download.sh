#!/bin/sh

mkdir downloads
cd downloads

# Windows
wget --continue https://github.com/asciidocfx/AsciidocFX/releases/download/v1.7.5/AsciidocFX_Windows.exe
wget --continue https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/2.50.0/windows_10_cmake_Release_graphviz-install-2.50.0-win64.exe

# Linux
wget --continue https://github.com/asciidocfx/AsciidocFX/releases/download/v1.7.5/AsciidocFX_Linux.tar.gz
# apt install graphviz


# Generic
wget --continue https://repo1.maven.org/maven2/org/asciidoctor/asciidoctorj/2.5.5/asciidoctorj-2.5.5-bin.zip
wget --continue https://downloads.sourceforge.net/project/plantuml/1.2022.6/plantuml-jar-mit-1.2022.6.zip
wget --continue https://pdf.plantuml.net/PlantUML_Language_Reference_Guide_en.pdf
wget --continue https://repo1.maven.org/maven2/org/scilab/forge/jlatexmath/1.0.7/jlatexmath-1.0.7.jar
