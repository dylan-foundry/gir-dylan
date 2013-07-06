TODO
----

* Remove struct definitions. We don't need or want access to
  struct members.
* Modify how enumerations are handled so that they use ``one-of``.
* Add back bindings for ``GIBaseInfo``.
* Convenient wrappers / translations for things that return
  lists, etc.
* Add actual tests to the test suite.
* Map ``char*``, ``gchar*`` to ``<C-string>``.
* Hook up output parameters correctly (especially errors).
* Revisit what is exported. We probably don't need to export
  the structs, just the pointers to them. We probably don't need
  to export slot setters / getters.
* Add something to make ``<GList>`` and ``<GSList>`` behave more
  like Dylan collections. Do we need to add bindings for the
  common functions for working with them?
