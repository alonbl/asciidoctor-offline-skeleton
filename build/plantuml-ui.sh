#!/bin/sh

TOOLSDIR="${TOOLSDIR:-$(dirname "$0")/../tools}"
PLANTUML_JAR="${PLANTUML_JAR:-${TOOLSDIR}/plantuml.jar}"
JLATEXMATH_JAR="${JLATEXMATH_JAR:-${TOOLSDIR}/jlatexmath.jar}"

java -Dfile.encoding=UTF-8 -cp "${PLANTUML_JAR}:${JLATEXMATH_JAR}" net.sourceforge.plantuml.Run -gui &
