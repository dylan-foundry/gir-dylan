gir-dylan
=========

These are Dylan bindings for the `gobject-introspection`_ library.

To build them, you will need to build and install the gobject-introspection
library first. On Ubuntu, this can be done by installing the
libgirepository-1.0-dev package.

You will also need OpenDylan 2026.1 or later.

This project also contains ``gir-generate-c-ffi`` which takes the
gobject-introspection metadata and generates the appropriate `C-FFI`_
bindings for consumption by the Open Dylan compiler.

GIR metadata comes in two forms, XML files ending in ``.gir``, and
binary files compiled from the XML ending in ``.typelib``. After
installing the `gobject-introspection`_ library, you may need to
install additional packages to have the compiled type libraries
available. Compiled type libraries are typically found in
``/usr/lib/girepository-1.0/`` or
``/usr/lib/x86_64-linux-gnu/girepository-1.0`` or
``/usr/local/lib/girepository-1.0/``.  GIR files, which we do not use,
are found in ``/usr/share/gir-1.0/`` or ``/usr/local/share/gir-1.0/``.

On Ubuntu, the packages for installing this metadata typically begin
with the prefix ``gir1.2-``.

.. _gobject-introspection: https://gi.readthedocs.io/en/latest/
.. _C-FFI: https://opendylan.org/library-reference/c-ffi/index.html
