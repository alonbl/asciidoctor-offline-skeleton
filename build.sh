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

cd "$(dirname "$0")"

. ./vars

[ -n "${PROJECT_NAME}" ] || die "Please set PROJECT_NAME"
[ -n "${ASCIIDOCTORJ_HOME}" ] || die "Please set ASCIIDOCTORJ_HOME"
[ -n "${ASCIIDOCTORJ_JAVA_HOME}" ] || die "Please set ASCIIDOCTORJ_JAVA_HOME"

export JAVA_HOME="${ASCIIDOCTORJ_JAVA_HOME}"

TMPDIR="$(mktemp -d)"
OUTDIR="${TMPDIR}/out"

mkdir -p "${OUTDIR}"
HASH="$(git stash create)"
HASH="${HASH:-HEAD}"
git archive "${HASH}" | tar -C "${OUTDIR}" -x

OLDDIR="$(pwd)"
cd "${OUTDIR}"
for backend_info in html5:.html pdf:.pdf; do
	IFS=:
	set ${backend_info}
	backend="$1"
	extension="$2"
	echo "Generating '${backend}'"
	"${ASCIIDOCTORJ_HOME}/bin/asciidoctorj" \
		--backend "${backend}" \
		--require asciidoctor-diagram \
		-a "webfonts!" \
		-a "link_suffix=${extension}" \
		'**/*.adoc' \
		|| die "Cannot generate docs for backend '${backend}'"
done
cd "${OLDDIR}"

tar \
	-C "${OUTDIR}" \
	--transform "s#^\.#${PROJECT_NAME}#" \
	--exclude "*.adoc" \
	--exclude "*.adoci" \
	--exclude "./.git*" \
	--exclude "./README.md" \
	--exclude "./build.sh" \
	--exclude "./docinfo" \
	--exclude "./pdf-styles" \
	--exclude "./util" \
	--exclude "./vars" \
	--exclude ".asciidoctor" \
	-czf "${PROJECT_NAME}.tar.gz" \
	.
