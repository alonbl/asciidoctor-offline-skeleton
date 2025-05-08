DOWNLOAD_FULL = 0
DISTDIR = dist
DESTDIR = dest
NULL =

all:		build

.PHONY: clean
clean:
	rm -fr *.stamp highlightjs/ tools/ downloads/

download:		download.stamp

.PHONY: _prepare-force
_prepare-force:
	rm -f prepare.stamp

_prepare:		\
			download \
			prepare.stamp \
			$(NULL)

prepare:		\
			_prepare-force \
			_prepare \
			$(NULL)

.PHONY: build
build:		_prepare
	DISTDIR="$(DISTDIR)" ./build/build.sh

.PHONY: install
install:
	DESTDIR="$(DESTDIR)" ./build/install.sh "$(DISTDIR)"/*.tar.gz

download.stamp:
	rm -f download.stamp
	DOWNLOAD_FULL="$(DOWNLOAD_FULL)" ./build/download.sh
	touch download.stamp

prepare.stamp:
	rm -f prepare.stamp
	./build/prepare.sh
	touch prepare.stamp
