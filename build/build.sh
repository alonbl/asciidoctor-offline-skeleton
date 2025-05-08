#!/bin/sh

NULL=

die() {
	local m="$1"
	echo "FATAL: ${m}" >&2
	exit 1
}

TMPDIR=
cleanup() {
	rm -fr "${TMPDIR}"
}

ASCIIDOCTORJ_HOME="${ASCIIDOCTORJ_HOME:-./tools/asciidoctorj}"
ASCIIDOCTORJ_JAVA_HOME="${ASCIIDOCTORJ_JAVA_HOME:-/usr/}"

. ./vars

[ -n "${PROJECT_NAME}" ] || die "Please set PROJECT_NAME"
[ -d "${ASCIIDOCTORJ_HOME}" ] || die "Please set ASCIIDOCTORJ_HOME"
[ -d "${ASCIIDOCTORJ_JAVA_HOME}" ] || die "Please set ASCIIDOCTORJ_JAVA_HOME"

ASCIIDOCTORJ_HOME="$(realpath "${ASCIIDOCTORJ_HOME}")"
ASCIIDOCTORJ_JAVA_HOME="$(realpath "${ASCIIDOCTORJ_JAVA_HOME}")"

export JAVA_HOME="${ASCIIDOCTORJ_JAVA_HOME}"

PROJECT_FQN="${PROJECT_NAME}-${PROJECT_VERSION}-${BUILD_NUMBER}"
BUILD_HASH="$(git rev-parse HEAD)"

TMPDIR="$(mktemp -d)"
OUTDIR="${TMPDIR}/out"

mkdir -p "${OUTDIR}"
HASH="$(git stash create)"
if [ -z "${HASH}" ]; then
	HASH="${HASH:-HEAD}"
else
	BUILD_HASH="${BUILD_HASH}-dirty"
fi
git archive "${HASH}" | tar -C "${OUTDIR}" -x

OLDDIR="$(pwd)"
cd "${OUTDIR}"
cat > metadata << __EOF__
PROJECT_PATH=${PROJECT_PATH}
PROJECT_NAME=${PROJECT_NAME}
PROJECT_VERSION=${PROJECT_VERSION}
BUILD_NUMBER=${BUILD_NUMBER}
BUILD_HASH=${BUILD_HASH}
__EOF__
for backend_info in html5:.html pdf:.pdf; do
	IFS=:
	set ${backend_info}
	backend="$1"
	extension="$2"
	echo "Generating '${backend}'"
	"${ASCIIDOCTORJ_HOME}/bin/asciidoctorj" \
		--backend "${backend}" \
		--require asciidoctor-diagram \
		-a "link_suffix=${extension}" \
		-a "PROJECT_FQN=${PROJECT_FQN}" \
		-a "PROJECT_NAME=${PROJECT_NAME}" \
		-a "PROJECT_VERSION=${PROJECT_VERSION}" \
		-a "BUILD_NUMBER=${BUILD_NUMBER}" \
		-a "BUILD_HASH=${BUILD_HASH}" \
		'**/*.adoc' \
		|| die "Cannot generate docs for backend '${backend}'"
done
cd "${OLDDIR}"

mkdir -p "${DISTDIR}"
tar \
	-C "${OUTDIR}" \
	--transform "s#^\.#${PROJECT_FQN}#" \
	--exclude "*.adoc" \
	--exclude "*.adoci" \
	--exclude "./.git*" \
	--exclude "./Makefile" \
	--exclude "./README.md" \
	--exclude "./build" \
	--exclude "./docinfo" \
	--exclude "./pdf-styles" \
	--exclude "./vars" \
	--exclude ".asciidoctor" \
	-czf "${DISTDIR}/${PROJECT_FQN}.tar.gz" \
	.
