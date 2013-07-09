gir-dylan
=========

These are Dylan bindings for the `gobject-introspection`_ library
(`reference documentation`_).

To build them, you will need to build and install the gobject-introspection
library first. You will also need OpenDylan 2012.1 or later.

This project also contains ``gir-generate-c-ffi`` which takes the
gobject-introspection metadata and generates the appropriate `C-FFI`_
bindings for consumption by the Open Dylan compiler.

.. _gobject-introspection: https://live.gnome.org/GObjectIntrospection
.. _reference documentation: https://developer.gnome.org/gi/stable/
.. _C-FFI: http://opendylan.org/documentation/library-reference/c-ffi/index.html
