module: gobject-introspection
synopsis: bindings for the gobject-introspection library
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define C-struct <_GIRepositoryPrivate>
end;
define C-pointer-type <GIRepositoryPrivate> => <_GIRepositoryPrivate>;

define C-struct <_GIRepository>
  slot _GIRepository$parent :: <_GObject>;
  slot _GIRepository$priv :: <GIRepositoryPrivate>;
end;
define C-pointer-type <GIRepository> => <_GIRepository>;

define C-struct <_GIRepositoryClass>
  slot _GIRepositoryClass$parent :: <_GObjectClass>;
end;
define constant <GIRepositoryClass> = <_GIRepositoryClass>;


define constant <GIRepositoryLoadFlags> = <C-int>;
define constant $G-IREPOSITORY-LOAD-FLAG-LAZY = 1;


define C-function g-irepository-get-type
  result res :: <GType>;
  c-name: "g_irepository_get_type";
end;

define C-function g-irepository-get-default
  result res :: <GIRepository>;
  c-name: "g_irepository_get_default";
end;

define C-function g-irepository-prepend-search-path
  input parameter directory :: <char*>;
  c-name: "g_irepository_prepend_search_path";
end;

define C-function g-irepository-get-search-path
  result res :: <GSList>;
  c-name: "g_irepository_get_search_path";
end;

define C-function g-irepository-load-typelib
  input parameter repository :: <GIRepository>;
  input parameter typelib :: <GITypelib>;
  input parameter flags :: <GIRepositoryLoadFlags>;
  input parameter error :: <GError**>;
  result res :: <char*>;
  c-name: "g_irepository_load_typelib";
end;

define C-function g-irepository-is-registered
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  input parameter version :: <gchar*>;
  result res :: <gboolean>;
  c-name: "g_irepository_is_registered";
end;

define C-function g-irepository-find-by-name
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  input parameter name :: <gchar*>;
  result res :: <GIBaseInfo>;
  c-name: "g_irepository_find_by_name";
end;

define C-function g-irepository-enumerate-versions
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  result res :: <GList>;
  c-name: "g_irepository_enumerate_versions";
end;

define C-function g-irepository-require
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  input parameter version :: <gchar*>;
  input parameter flags :: <GIRepositoryLoadFlags>;
  input parameter error :: <GError**>;
  result res :: <GITypelib>;
  c-name: "g_irepository_require";
end;

define C-function g-irepository-require-private
  input parameter repository :: <GIRepository>;
  input parameter typelib-dir :: <gchar*>;
  input parameter namespace- :: <gchar*>;
  input parameter version :: <gchar*>;
  input parameter flags :: <GIRepositoryLoadFlags>;
  input parameter error :: <GError**>;
  result res :: <GITypelib>;
  c-name: "g_irepository_require_private";
end;

define C-function g-irepository-get-dependencies
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar**>;
  c-name: "g_irepository_get_dependencies";
end;

define C-function g-irepository-get-loaded-namespaces
  input parameter repository :: <GIRepository>;
  result res :: <gchar**>;
  c-name: "g_irepository_get_loaded_namespaces";
end;

define C-function g-irepository-find-by-gtype
  input parameter repository :: <GIRepository>;
  input parameter gtype :: <GType>;
  result res :: <GIBaseInfo>;
  c-name: "g_irepository_find_by_gtype";
end;

define C-function g-irepository-get-n-infos
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  result res :: <gint>;
  c-name: "g_irepository_get_n_infos";
end;

define C-function g-irepository-get-info
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  input parameter index :: <gint>;
  result res :: <GIBaseInfo>;
  c-name: "g_irepository_get_info";
end;

define C-function g-irepository-find-by-error-domain
  input parameter repository :: <GIRepository>;
  input parameter domain :: <GQuark>;
  result res :: <GIEnumInfo>;
  c-name: "g_irepository_find_by_error_domain";
end;

define C-function g-irepository-get-typelib-path
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_typelib_path";
end;

define C-function g-irepository-get-shared-library
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_shared_library";
end;

define C-function g-irepository-get-c-prefix
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_c_prefix";
end;

define C-function g-irepository-get-version
  input parameter repository :: <GIRepository>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_version";
end;

define C-struct <_GOptionGroup>
end;
define C-pointer-type <GOptionGroup> => <_GOptionGroup>;


define C-function g-irepository-get-option-group
  result res :: <GOptionGroup>;
  c-name: "g_irepository_get_option_group";
end;

define C-function g-irepository-dump
  input parameter arg :: <char*>;
  input parameter error :: <GError**>;
  result res :: <gboolean>;
  c-name: "g_irepository_dump";
end;

define constant <GIRepositoryError> = <C-int>;
define constant $G-IREPOSITORY-ERROR-TYPELIB-NOT-FOUND = 0;
define constant $G-IREPOSITORY-ERROR-NAMESPACE-MISMATCH = 1;
define constant $G-IREPOSITORY-ERROR-NAMESPACE-VERSION-CONFLICT = 2;
define constant $G-IREPOSITORY-ERROR-LIBRARY-NOT-FOUND = 3;

define C-function g-irepository-error-quark
  result res :: <GQuark>;
  c-name: "g_irepository_error_quark";
end;
