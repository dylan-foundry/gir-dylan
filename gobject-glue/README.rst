GObject Glue
============

This module contains functions, definitions and macros to make working with
GObject libraries easier.

Usage
-----

1. Generate the bindings for GObject, using `gir-dylan`
2. Copy `gobject-glue.dylan`, `support.c`, `glue-module.dylan` into the
   `gobject-dylan` directory
3. Add `gobject-glue` and `'glue-module` to `gobject-dylan.lid`'s `files`
   section
4. Add `c-source-files: support.c` to `gobject-dylan.lid`
5. Optionally export `gobject-glue` from the `gobject` library
