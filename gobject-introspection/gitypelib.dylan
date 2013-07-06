module: gobject-introspection
synopsis: bindings for the gobject-introspection library
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.


define C-struct <_GITypelib>
end;
define C-pointer-type <GITypelib> => <_GITypelib>;

define C-function g-typelib-new-from-memory
  input parameter memory_ :: <guint8*>;
  input parameter len_ :: <gsize>;
  input parameter error_ :: <GError**>;
  result res :: <GITypelib>;
  c-name: "g_typelib_new_from_memory";
end;

define C-function g-typelib-new-from-const-memory
  input parameter memory_ :: <guint8*>;
  input parameter len_ :: <gsize>;
  input parameter error_ :: <GError**>;
  result res :: <GITypelib>;
  c-name: "g_typelib_new_from_const_memory";
end;

define C-struct <_GMappedFile>
end;
define C-pointer-type <GMappedFile> => <_GMappedFile>;

define C-function g-typelib-new-from-mapped-file
  input parameter mfile_ :: <GMappedFile>;
  input parameter error_ :: <GError**>;
  result res :: <GITypelib>;
  c-name: "g_typelib_new_from_mapped_file";
end;

define C-function g-typelib-free
  input parameter typelib_ :: <GITypelib>;
  c-name: "g_typelib_free";
end;

define C-function g-typelib-symbol
  input parameter typelib_ :: <GITypelib>;
  input parameter symbol-name_ :: <gchar*>;
  input parameter symbol_ :: <gpointer*>;
  result res :: <gboolean>;
  c-name: "g_typelib_symbol";
end;

define C-function g-typelib-get-namespace
  input parameter typelib_ :: <GITypelib>;
  result res :: <gchar*>;
  c-name: "g_typelib_get_namespace";
end;

