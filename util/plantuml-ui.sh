#!/bin/sh

PLANTUML_JAR="${PLANTUML_JAR:-plantuml.jar}"
JLATEXMATH_JAR="${JLATEXMATH_JAR:-jlatexmath.jar}"

SCRIPTDIR="$(dirname "$0")"

java -Dfile.encoding=UTF-8 -cp "${SCRIPTDIR}/${PLANTUML_JAR}:${SCRIPTDIR}/${JLATEXMATH_JAR}" net.sourceforge.plantuml.Run -gui &
