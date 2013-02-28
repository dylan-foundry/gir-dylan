gir-dylan
=========

These are Dylan bindings for the ``gobject-introspection`` library: https://live.gnome.org/GObjectIntrospection

To build them, you will need to build and install the gobject-introspection
library first. You will also need OpenDylan 2012.1 or later.

TODO
----

* Remove struct definitions. We don't need or want access to
  struct members.
* Rename class types so that ``<_GObject>`` is the raw struct (if we
  even have that) and ``<GObject>`` is the pointer to the struct.
  * Partially done.
* Modify how enumerations are handled so that they use ``one-of``.
* Add back bindings for ``GITypelib`` and ``GIBaseInfo``.
* Convenient wrappers / translations for things that return
  lists, etc.
* Add actual tests to the test suite.
* Map ``char*``, ``gchar*`` to ``<C-string>``.
* Hook up output parameters correctly (especially errors).
* Revisit what is exported. We probably don't need to export
  the structs, just the pointers to them. We probably don't need
  to export slot setters / getters.
* Function pointers need some love.
* Add something to make ``<GList>`` and ``<GSList>`` behave more
  like Dylan collections. Do we need to add bindings for the
  common functions for working with them?
