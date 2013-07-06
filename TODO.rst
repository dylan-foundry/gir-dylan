TODO
----

* Remove struct definitions. We don't need or want access to
  struct members.
* Modify how enumerations are handled so that they use ``one-of``.
* Convenient wrappers / translations for things that return
  lists, etc.
* Add actual tests to the test suite.
* Revisit what is exported. We probably don't need to export
  the structs, just the pointers to them. We probably don't need
  to export slot setters / getters.
* Add something to make ``<GList>`` and ``<GSList>`` behave more
  like Dylan collections. Do we need to add bindings for the
  common functions for working with them?
* Add a couple of helper methods for working with errors to
  access the data on them.
* Move more sets of functions to their own files like I did
  with gibaseinfo, girepository and gitypelib.
