gir-dylan
=========

These are Dylan bindings for the ``gobject-introspection`` library: https://github.com/250bpm/nanomsg

To build them, you will need to build and install the gobject-introspection
library first. You will also need OpenDylan 2012.1 or later.

TODO
----

* Remove struct definitions. We don't need or want access to
  struct members.
* Rename class types so that ``<_GObject>`` is the raw struct (if we
  even have that) and ``<GObject>`` is the pointer to the struct.
* Modify how enumerations are handled so that they use ``one-of``.
* Add back bindings for ``GITypelib`` and ``GIBaseInfo``.
