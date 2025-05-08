#!/bin/sh

die() {
	local m="$1"
	echo "FATAL: ${m}" >&2
}

metadata_field() {
	cat "${METADATA}" | grep "^$1" | sed 's/[^=]*=//'
}


[ -n "${DESTDIR}" ] || die "Please specify DESTDIR environment"

MYTMP=
cleanup() {
	rm -fr "${MYTMP}"
}
trap cleanup 0

MYTMP="$(mktemp -d)"
METADATA="${MYTMP}/metadata"

while [ -n "$1" ]; do
	DIST="$1"
	shift
	echo "Installing '${DIST}' to '${DESTDIR}'"

	tar -C "${MYTMP}" -xf "${DIST}" --wildcards --strip-components=1 '*/metadata' || die "Cannot extract metadata"

	PROJECT_PATH="$(metadata_field PROJECT_PATH)"
	PROJECT_NAME="$(metadata_field PROJECT_NAME)"
	PROJECT_VERSION="$(metadata_field PROJECT_VERSION)"

	TARGET="${DESTDIR}/${PROJECT_PATH}/${PROJECT_NAME}/${PROJECT_VERSION}"
	TARGET_OLD="${TARGET}.old"
	TARGET_NEW="${TARGET}.new"

	rm -fr "${TARGET_NEW}"
	mkdir -p "${TARGET_NEW}"
	tar -C "${TARGET_NEW}" -xf "${DIST}" --strip-components=1 || die "Canont extract package"
	if [ -d "${TARGET}" ]; then
		mv "${TARGET}" "${TARGET_OLD}" || die "Cannot rename '${TARGET}->${TARGET_OLD}'"
	fi
	mv "${TARGET_NEW}" "${TARGET}" || die "Cannot rename '${TARGET_NEW}->${TARGET}'"
	rm -fr "${TARGET_OLD}"
done
