all: build

.PHONY: build test

build:
	dylan-compiler -build gobject-introspection
	dylan-compiler -build gir-generate-c-ffi

test:
	dylan-compiler -build gobject-introspection-test-suite-app
	_build/bin/gobject-introspection-test-suite-app

clean:
	rm -rf _build/bin/gobject-introspection*
	rm -rf _build/lib/*gobject-introspection*
	rm -rf _build/build/gobject-introspection*
