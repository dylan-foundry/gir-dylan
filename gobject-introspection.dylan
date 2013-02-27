module: gobject-introspection

define constant <gsize> = <C-unsigned-long>;

define constant <GType> = <gsize>;

define C-struct <_GTypeClass>
  slot _GTypeClass$g-type :: <C-unsigned-long>;
end;

define constant <GTypeClass> = <_GTypeClass>;

define C-pointer-type <GTypeClass*> => <GTypeClass>;
define C-struct <_GTypeInstance>
  slot _GTypeInstance$g-class :: <GTypeClass*>;
end;

define constant <GTypeInstance> = <_GTypeInstance>;

define constant <guint> = <C-unsigned-int>;

define C-struct <_GData>
end;

define constant <GData> = <_GData>;

define C-pointer-type <GData*> => <GData>;
define C-struct <_GObject>
  slot _GObject$g-type-instance :: <_GTypeInstance>;
  slot _GObject$ref-count :: <C-unsigned-int>;
  slot _GObject$qdata :: <GData*>;
end;

define constant <GObject> = <_GObject>;

define C-struct <_GIRepositoryPrivate>
end;

define constant <GIRepositoryPrivate> = <_GIRepositoryPrivate>;

define C-pointer-type <GIRepositoryPrivate*> => <GIRepositoryPrivate>;
define C-struct <_GIRepository>
  slot _GIRepository$parent :: <_GObject>;
  slot _GIRepository$priv :: <GIRepositoryPrivate*>;
end;

define constant <GIRepository> = <_GIRepository>;

define constant <gpointer> = <C-void*>;

define C-struct <_GSList>
  slot _GSList$data :: <C-void*>;
  slot _GSList$next :: <GSList*>;
end;

define constant <GSList> = <_GSList>;

define C-pointer-type <GSList*> => <GSList>;
define C-pointer-type <GObject*> => <GObject>;
define constant <gchar> = <C-signed-char>;

define C-pointer-type <gchar*> => <gchar>;
define constant <GParamFlags> = <C-int>;
define constant $G-PARAM-READABLE = 1;
define constant $G-PARAM-WRITABLE = 2;
define constant $G-PARAM-CONSTRUCT = 4;
define constant $G-PARAM-CONSTRUCT-ONLY = 8;
define constant $G-PARAM-LAX-VALIDATION = 16;
define constant $G-PARAM-STATIC-NAME = 32;
define constant $G-PARAM-PRIVATE = 32;
define constant $G-PARAM-STATIC-NICK = 64;
define constant $G-PARAM-STATIC-BLURB = 128;
define constant $G-PARAM-DEPRECATED = 2147483648;

define C-struct <_GParamSpec>
  slot _GParamSpec$g-type-instance :: <_GTypeInstance>;
  slot _GParamSpec$name :: <gchar*>;
  slot _GParamSpec$flags :: <GParamFlags>;
  slot _GParamSpec$value-type :: <C-unsigned-long>;
  slot _GParamSpec$owner-type :: <C-unsigned-long>;
  slot _GParamSpec$_nick :: <gchar*>;
  slot _GParamSpec$_blurb :: <gchar*>;
  slot _GParamSpec$qdata :: <GData*>;
  slot _GParamSpec$ref-count :: <C-unsigned-int>;
  slot _GParamSpec$param-id :: <C-unsigned-int>;
end;

define constant <GParamSpec> = <_GParamSpec>;

define C-pointer-type <GParamSpec*> => <GParamSpec>;
define constant <gint> = <C-signed-int>;

define constant <glong> = <C-signed-long>;

define constant <gulong> = <C-unsigned-long>;

define constant <gint64> = <C-signed-long>;

define constant <guint64> = <C-unsigned-long>;

define constant <gfloat> = <C-float>;

define constant <gdouble> = <C-double>;

define C-union <anonymous-2007>
  slot anonymous-2007$v-int :: <C-signed-int>;
  slot anonymous-2007$v-uint :: <C-unsigned-int>;
  slot anonymous-2007$v-long :: <C-signed-long>;
  slot anonymous-2007$v-ulong :: <C-unsigned-long>;
  slot anonymous-2007$v-int64 :: <C-signed-long>;
  slot anonymous-2007$v-uint64 :: <C-unsigned-long>;
  slot anonymous-2007$v-float :: <C-float>;
  slot anonymous-2007$v-double :: <C-double>;
  slot anonymous-2007$v-pointer :: <C-void*>;
end;

define C-pointer-type <anonymous-2007*> => <anonymous-2007>;
define constant <anonymous-2007<@2>> = <anonymous-2007*>;
define C-struct <_GValue>
  slot _GValue$g-type :: <C-unsigned-long>;
  array slot _GValue$data :: <anonymous-2007>, length: 2;
end;

define constant <GValue> = <_GValue>;

define C-pointer-type <GValue*> => <GValue>;
define C-struct <_GObjectConstructParam>
  slot _GObjectConstructParam$pspec :: <GParamSpec*>;
  slot _GObjectConstructParam$value :: <GValue*>;
end;

define constant <GObjectConstructParam> = <_GObjectConstructParam>;

define C-pointer-type <GObjectConstructParam*> => <GObjectConstructParam>;
define constant <anonymous-2185> = <C-function-pointer>;
define C-pointer-type <anonymous-2185*> => <anonymous-2185>;
define constant <anonymous-2186> = <C-function-pointer>;
define C-pointer-type <anonymous-2186*> => <anonymous-2186>;
define constant <anonymous-2187> = <C-function-pointer>;
define C-pointer-type <anonymous-2187*> => <anonymous-2187>;
define constant <anonymous-2188> = <C-function-pointer>;
define C-pointer-type <anonymous-2188*> => <anonymous-2188>;
define constant <anonymous-2189> = <C-function-pointer>;
define C-pointer-type <anonymous-2189*> => <anonymous-2189>;
define C-pointer-type <GParamSpec**> => <GParamSpec*>;
define constant <anonymous-2190> = <C-function-pointer>;
define C-pointer-type <anonymous-2190*> => <anonymous-2190>;
define constant <anonymous-2191> = <C-function-pointer>;
define C-pointer-type <anonymous-2191*> => <anonymous-2191>;
define constant <anonymous-2192> = <C-function-pointer>;
define C-pointer-type <anonymous-2192*> => <anonymous-2192>;
define C-pointer-type <gpointer*> => <gpointer>;
define constant <gpointer<@6>> = <gpointer*>;
define C-struct <_GObjectClass>
  slot _GObjectClass$g-type-class :: <_GTypeClass>;
  slot _GObjectClass$construct-properties :: <GSList*>;
  slot _GObjectClass$constructor :: <anonymous-2185*>;
  slot _GObjectClass$set-property :: <anonymous-2186*>;
  slot _GObjectClass$get-property :: <anonymous-2187*>;
  slot _GObjectClass$dispose :: <anonymous-2188*>;
  slot _GObjectClass$finalize :: <anonymous-2189*>;
  slot _GObjectClass$dispatch-properties-changed :: <anonymous-2190*>;
  slot _GObjectClass$notify :: <anonymous-2191*>;
  slot _GObjectClass$constructed :: <anonymous-2192*>;
  slot _GObjectClass$flags :: <C-unsigned-long>;
  array slot _GObjectClass$pdummy :: <gpointer>, length: 6;
end;

define constant <GObjectClass> = <_GObjectClass>;

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

define C-pointer-type <GIRepository*> => <GIRepository>;
define C-function g-irepository-get-default
  result res :: <GIRepository*>;
  c-name: "g_irepository_get_default";
end;

define C-pointer-type <char*> => <C-signed-char>;
define C-function g-irepository-prepend-search-path
  input parameter directory :: <char*>;
  c-name: "g_irepository_prepend_search_path";
end;

define C-function g-irepository-get-search-path
  result res :: <GSList*>;
  c-name: "g_irepository_get_search_path";
end;

define C-struct <_GITypelib>
end;

define constant <GITypelib> = <_GITypelib>;

define C-pointer-type <GITypelib*> => <GITypelib>;
define constant <guint32> = <C-unsigned-int>;

define constant <GQuark> = <guint32>;

define C-struct <_GError>
  slot _GError$domain :: <C-unsigned-int>;
  slot _GError$code :: <C-signed-int>;
  slot _GError$message :: <gchar*>;
end;

define constant <GError> = <_GError>;

define C-pointer-type <GError*> => <GError>;
define C-pointer-type <GError**> => <GError*>;
define C-function g-irepository-load-typelib
  input parameter repository :: <GIRepository*>;
  input parameter typelib :: <GITypelib*>;
  input parameter flags :: <GIRepositoryLoadFlags>;
  input parameter error :: <GError**>;
  result res :: <char*>;
  c-name: "g_irepository_load_typelib";
end;

define constant <gboolean> = <gint>;

define C-function g-irepository-is-registered
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  input parameter version :: <gchar*>;
  result res :: <gboolean>;
  c-name: "g_irepository_is_registered";
end;

define constant <gint32> = <C-signed-int>;

define constant <gpointer<@4>> = <gpointer*>;
define C-struct <_GIBaseInfoStub>
  slot _GIBaseInfoStub$dummy1 :: <C-signed-int>;
  slot _GIBaseInfoStub$dummy2 :: <C-signed-int>;
  slot _GIBaseInfoStub$dummy3 :: <C-void*>;
  slot _GIBaseInfoStub$dummy4 :: <C-void*>;
  slot _GIBaseInfoStub$dummy5 :: <C-void*>;
  slot _GIBaseInfoStub$dummy6 :: <C-unsigned-int>;
  slot _GIBaseInfoStub$dummy7 :: <C-unsigned-int>;
  array slot _GIBaseInfoStub$padding :: <gpointer>, length: 4;
end;

define constant <GIBaseInfo> = <_GIBaseInfoStub>;

define C-pointer-type <GIBaseInfo*> => <GIBaseInfo>;
define C-function g-irepository-find-by-name
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  input parameter name :: <gchar*>;
  result res :: <GIBaseInfo*>;
  c-name: "g_irepository_find_by_name";
end;

define C-struct <_GList>
  slot _GList$data :: <C-void*>;
  slot _GList$next :: <GList*>;
  slot _GList$prev :: <GList*>;
end;

define constant <GList> = <_GList>;

define C-pointer-type <GList*> => <GList>;
define C-function g-irepository-enumerate-versions
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  result res :: <GList*>;
  c-name: "g_irepository_enumerate_versions";
end;

define C-function g-irepository-require
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  input parameter version :: <gchar*>;
  input parameter flags :: <GIRepositoryLoadFlags>;
  input parameter error :: <GError**>;
  result res :: <GITypelib*>;
  c-name: "g_irepository_require";
end;

define C-function g-irepository-require-private
  input parameter repository :: <GIRepository*>;
  input parameter typelib-dir :: <gchar*>;
  input parameter namespace- :: <gchar*>;
  input parameter version :: <gchar*>;
  input parameter flags :: <GIRepositoryLoadFlags>;
  input parameter error :: <GError**>;
  result res :: <GITypelib*>;
  c-name: "g_irepository_require_private";
end;

define C-pointer-type <gchar**> => <gchar*>;
define C-function g-irepository-get-dependencies
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar**>;
  c-name: "g_irepository_get_dependencies";
end;

define C-function g-irepository-get-loaded-namespaces
  input parameter repository :: <GIRepository*>;
  result res :: <gchar**>;
  c-name: "g_irepository_get_loaded_namespaces";
end;

define C-function g-irepository-find-by-gtype
  input parameter repository :: <GIRepository*>;
  input parameter gtype :: <GType>;
  result res :: <GIBaseInfo*>;
  c-name: "g_irepository_find_by_gtype";
end;

define C-function g-irepository-get-n-infos
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  result res :: <gint>;
  c-name: "g_irepository_get_n_infos";
end;

define C-function g-irepository-get-info
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  input parameter index :: <gint>;
  result res :: <GIBaseInfo*>;
  c-name: "g_irepository_get_info";
end;

define constant <GIEnumInfo> = <GIBaseInfo>;

define C-pointer-type <GIEnumInfo*> => <GIEnumInfo>;
define C-function g-irepository-find-by-error-domain
  input parameter repository :: <GIRepository*>;
  input parameter domain :: <GQuark>;
  result res :: <GIEnumInfo*>;
  c-name: "g_irepository_find_by_error_domain";
end;

define C-function g-irepository-get-typelib-path
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_typelib_path";
end;

define C-function g-irepository-get-shared-library
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_shared_library";
end;

define C-function g-irepository-get-c-prefix
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_c_prefix";
end;

define C-function g-irepository-get-version
  input parameter repository :: <GIRepository*>;
  input parameter namespace- :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_irepository_get_version";
end;

define C-struct <_GOptionGroup>
end;

define constant <GOptionGroup> = <_GOptionGroup>;

define C-pointer-type <GOptionGroup*> => <GOptionGroup>;
define C-function g-irepository-get-option-group
  result res :: <GOptionGroup*>;
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

define constant <anonymous-2074> = <C-function-pointer>;
define C-pointer-type <anonymous-2074*> => <anonymous-2074>;
define constant <anonymous-2061> = <C-function-pointer>;
define C-pointer-type <anonymous-2061*> => <anonymous-2061>;
define constant <GClosureNotify> = <anonymous-2061*>;

define C-struct <_GClosureNotifyData>
  slot _GClosureNotifyData$data :: <C-void*>;
  slot _GClosureNotifyData$notify :: <anonymous-2061*>;
end;

define constant <GClosureNotifyData> = <_GClosureNotifyData>;

define C-pointer-type <GClosureNotifyData*> => <GClosureNotifyData>;
define C-struct <_GClosure>
  bitfield slot _GClosure$ref-count :: <C-int>, width: 15;
  bitfield slot _GClosure$meta-marshal-nouse :: <C-int>, width: 1;
  bitfield slot _GClosure$n-guards :: <C-int>, width: 1;
  bitfield slot _GClosure$n-fnotifiers :: <C-int>, width: 2;
  bitfield slot _GClosure$n-inotifiers :: <C-int>, width: 8;
  bitfield slot _GClosure$in-inotify :: <C-int>, width: 1;
  bitfield slot _GClosure$floating :: <C-int>, width: 1;
  bitfield slot _GClosure$derivative-flag :: <C-int>, width: 1;
  bitfield slot _GClosure$in-marshal :: <C-int>, width: 1;
  bitfield slot _GClosure$is-invalid :: <C-int>, width: 1;
  slot _GClosure$marshal :: <anonymous-2074*>;
  slot _GClosure$data :: <C-void*>;
  slot _GClosure$notifiers :: <GClosureNotifyData*>;
end;

define constant <GClosure> = <_GClosure>;

define C-pointer-type <GClosure*> => <GClosure>;
define C-function gi-cclosure-marshal-generic
  input parameter closure :: <GClosure*>;
  input parameter return-gvalue :: <GValue*>;
  input parameter n-param-values :: <guint>;
  input parameter param-values :: <GValue*>;
  input parameter invocation-hint :: <gpointer>;
  input parameter marshal-data :: <gpointer>;
  c-name: "gi_cclosure_marshal_generic";
end;

define constant <GIDirection> = <C-int>;
define constant $GI-DIRECTION-IN = 0;
define constant $GI-DIRECTION-OUT = 1;
define constant $GI-DIRECTION-INOUT = 2;

define constant <GIArgInfo> = <GIBaseInfo>;

define C-pointer-type <GIArgInfo*> => <GIArgInfo>;
define C-function g-arg-info-get-direction
  input parameter info :: <GIArgInfo*>;
  result res :: <GIDirection>;
  c-name: "g_arg_info_get_direction";
end;

define C-function g-arg-info-is-return-value
  input parameter info :: <GIArgInfo*>;
  result res :: <gboolean>;
  c-name: "g_arg_info_is_return_value";
end;

define C-function g-arg-info-is-optional
  input parameter info :: <GIArgInfo*>;
  result res :: <gboolean>;
  c-name: "g_arg_info_is_optional";
end;

define C-function g-arg-info-is-caller-allocates
  input parameter info :: <GIArgInfo*>;
  result res :: <gboolean>;
  c-name: "g_arg_info_is_caller_allocates";
end;

define C-function g-arg-info-may-be-null
  input parameter info :: <GIArgInfo*>;
  result res :: <gboolean>;
  c-name: "g_arg_info_may_be_null";
end;

define C-function g-arg-info-is-skip
  input parameter info :: <GIArgInfo*>;
  result res :: <gboolean>;
  c-name: "g_arg_info_is_skip";
end;

define constant <GITransfer> = <C-int>;
define constant $GI-TRANSFER-NOTHING = 0;
define constant $GI-TRANSFER-CONTAINER = 1;
define constant $GI-TRANSFER-EVERYTHING = 2;

define C-function g-arg-info-get-ownership-transfer
  input parameter info :: <GIArgInfo*>;
  result res :: <GITransfer>;
  c-name: "g_arg_info_get_ownership_transfer";
end;

define constant <GIScopeType> = <C-int>;
define constant $GI-SCOPE-TYPE-INVALID = 0;
define constant $GI-SCOPE-TYPE-CALL = 1;
define constant $GI-SCOPE-TYPE-ASYNC = 2;
define constant $GI-SCOPE-TYPE-NOTIFIED = 3;

define C-function g-arg-info-get-scope
  input parameter info :: <GIArgInfo*>;
  result res :: <GIScopeType>;
  c-name: "g_arg_info_get_scope";
end;

define C-function g-arg-info-get-closure
  input parameter info :: <GIArgInfo*>;
  result res :: <gint>;
  c-name: "g_arg_info_get_closure";
end;

define C-function g-arg-info-get-destroy
  input parameter info :: <GIArgInfo*>;
  result res :: <gint>;
  c-name: "g_arg_info_get_destroy";
end;

define constant <GITypeInfo> = <GIBaseInfo>;

define C-pointer-type <GITypeInfo*> => <GITypeInfo>;
define C-function g-arg-info-get-type
  input parameter info :: <GIArgInfo*>;
  result res :: <GITypeInfo*>;
  c-name: "g_arg_info_get_type";
end;

define C-function g-arg-info-load-type
  input parameter info :: <GIArgInfo*>;
  input parameter type :: <GITypeInfo*>;
  c-name: "g_arg_info_load_type";
end;

define constant <GICallableInfo> = <GIBaseInfo>;

define C-pointer-type <GICallableInfo*> => <GICallableInfo>;
define C-function g-callable-info-get-return-type
  input parameter info :: <GICallableInfo*>;
  result res :: <GITypeInfo*>;
  c-name: "g_callable_info_get_return_type";
end;

define C-function g-callable-info-load-return-type
  input parameter info :: <GICallableInfo*>;
  input parameter type :: <GITypeInfo*>;
  c-name: "g_callable_info_load_return_type";
end;

define C-function g-callable-info-get-return-attribute
  input parameter info :: <GICallableInfo*>;
  input parameter name :: <gchar*>;
  result res :: <gchar*>;
  c-name: "g_callable_info_get_return_attribute";
end;

define C-struct <GIAttributeIter>
  slot GIAttributeIter$data :: <C-void*>;
  slot GIAttributeIter$data2 :: <C-void*>;
  slot GIAttributeIter$data3 :: <C-void*>;
  slot GIAttributeIter$data4 :: <C-void*>;
end;

define C-pointer-type <GIAttributeIter*> => <GIAttributeIter>;
define C-pointer-type <char**> => <char*>;
define C-function g-callable-info-iterate-return-attributes
  input parameter info :: <GICallableInfo*>;
  input parameter iterator :: <GIAttributeIter*>;
  input parameter name :: <char**>;
  input parameter value :: <char**>;
  result res :: <gboolean>;
  c-name: "g_callable_info_iterate_return_attributes";
end;

define C-function g-callable-info-get-caller-owns
  input parameter info :: <GICallableInfo*>;
  result res :: <GITransfer>;
  c-name: "g_callable_info_get_caller_owns";
end;

define C-function g-callable-info-may-return-null
  input parameter info :: <GICallableInfo*>;
  result res :: <gboolean>;
  c-name: "g_callable_info_may_return_null";
end;

define C-function g-callable-info-skip-return
  input parameter info :: <GICallableInfo*>;
  result res :: <gboolean>;
  c-name: "g_callable_info_skip_return";
end;

define C-function g-callable-info-get-n-args
  input parameter info :: <GICallableInfo*>;
  result res :: <gint>;
  c-name: "g_callable_info_get_n_args";
end;

define C-function g-callable-info-get-arg
  input parameter info :: <GICallableInfo*>;
  input parameter n :: <gint>;
  result res :: <GIArgInfo*>;
  c-name: "g_callable_info_get_arg";
end;

define C-function g-callable-info-load-arg
  input parameter info :: <GICallableInfo*>;
  input parameter n :: <gint>;
  input parameter arg :: <GIArgInfo*>;
  c-name: "g_callable_info_load_arg";
end;

define constant <GIConstantInfo> = <GIBaseInfo>;

define C-pointer-type <GIConstantInfo*> => <GIConstantInfo>;
define C-function g-constant-info-get-type
  input parameter info :: <GIConstantInfo*>;
  result res :: <GITypeInfo*>;
  c-name: "g_constant_info_get_type";
end;

define constant <gint8> = <C-signed-char>;

define constant <guint8> = <C-unsigned-char>;

define constant <gint16> = <C-signed-short>;

define constant <guint16> = <C-unsigned-short>;

define constant <gshort> = <C-signed-short>;

define constant <gushort> = <C-unsigned-short>;

define constant <gssize> = <C-signed-long>;

define C-union <_GIArgument>
  slot _GIArgument$v-boolean :: <C-signed-int>;
  slot _GIArgument$v-int8 :: <C-signed-char>;
  slot _GIArgument$v-uint8 :: <C-unsigned-char>;
  slot _GIArgument$v-int16 :: <C-signed-short>;
  slot _GIArgument$v-uint16 :: <C-unsigned-short>;
  slot _GIArgument$v-int32 :: <C-signed-int>;
  slot _GIArgument$v-uint32 :: <C-unsigned-int>;
  slot _GIArgument$v-int64 :: <C-signed-long>;
  slot _GIArgument$v-uint64 :: <C-unsigned-long>;
  slot _GIArgument$v-float :: <C-float>;
  slot _GIArgument$v-double :: <C-double>;
  slot _GIArgument$v-short :: <C-signed-short>;
  slot _GIArgument$v-ushort :: <C-unsigned-short>;
  slot _GIArgument$v-int :: <C-signed-int>;
  slot _GIArgument$v-uint :: <C-unsigned-int>;
  slot _GIArgument$v-long :: <C-signed-long>;
  slot _GIArgument$v-ulong :: <C-unsigned-long>;
  slot _GIArgument$v-ssize :: <C-signed-long>;
  slot _GIArgument$v-size :: <C-unsigned-long>;
  slot _GIArgument$v-string :: <gchar*>;
  slot _GIArgument$v-pointer :: <C-void*>;
end;

define constant <GIArgument> = <_GIArgument>;

define C-pointer-type <GIArgument*> => <GIArgument>;
define C-function g-constant-info-free-value
  input parameter info :: <GIConstantInfo*>;
  input parameter value :: <GIArgument*>;
  c-name: "g_constant_info_free_value";
end;

define C-function g-constant-info-get-value
  input parameter info :: <GIConstantInfo*>;
  input parameter value :: <GIArgument*>;
  result res :: <gint>;
  c-name: "g_constant_info_get_value";
end;

define C-function g-enum-info-get-n-values
  input parameter info :: <GIEnumInfo*>;
  result res :: <gint>;
  c-name: "g_enum_info_get_n_values";
end;

define constant <GIValueInfo> = <GIBaseInfo>;

define C-pointer-type <GIValueInfo*> => <GIValueInfo>;
define C-function g-enum-info-get-value
  input parameter info :: <GIEnumInfo*>;
  input parameter n :: <gint>;
  result res :: <GIValueInfo*>;
  c-name: "g_enum_info_get_value";
end;

define C-function g-enum-info-get-n-methods
  input parameter info :: <GIEnumInfo*>;
  result res :: <gint>;
  c-name: "g_enum_info_get_n_methods";
end;

define constant <GIFunctionInfo> = <GIBaseInfo>;

define C-pointer-type <GIFunctionInfo*> => <GIFunctionInfo>;
define C-function g-enum-info-get-method
  input parameter info :: <GIEnumInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_enum_info_get_method";
end;

define constant <GITypeTag> = <C-int>;
define constant $GI-TYPE-TAG-VOID = 0;
define constant $GI-TYPE-TAG-BOOLEAN = 1;
define constant $GI-TYPE-TAG-INT8 = 2;
define constant $GI-TYPE-TAG-UINT8 = 3;
define constant $GI-TYPE-TAG-INT16 = 4;
define constant $GI-TYPE-TAG-UINT16 = 5;
define constant $GI-TYPE-TAG-INT32 = 6;
define constant $GI-TYPE-TAG-UINT32 = 7;
define constant $GI-TYPE-TAG-INT64 = 8;
define constant $GI-TYPE-TAG-UINT64 = 9;
define constant $GI-TYPE-TAG-FLOAT = 10;
define constant $GI-TYPE-TAG-DOUBLE = 11;
define constant $GI-TYPE-TAG-GTYPE = 12;
define constant $GI-TYPE-TAG-UTF8 = 13;
define constant $GI-TYPE-TAG-FILENAME = 14;
define constant $GI-TYPE-TAG-ARRAY = 15;
define constant $GI-TYPE-TAG-INTERFACE = 16;
define constant $GI-TYPE-TAG-GLIST = 17;
define constant $GI-TYPE-TAG-GSLIST = 18;
define constant $GI-TYPE-TAG-GHASH = 19;
define constant $GI-TYPE-TAG-ERROR = 20;
define constant $GI-TYPE-TAG-UNICHAR = 21;

define C-function g-enum-info-get-storage-type
  input parameter info :: <GIEnumInfo*>;
  result res :: <GITypeTag>;
  c-name: "g_enum_info_get_storage_type";
end;

define C-function g-enum-info-get-error-domain
  input parameter info :: <GIEnumInfo*>;
  result res :: <gchar*>;
  c-name: "g_enum_info_get_error_domain";
end;

define C-function g-value-info-get-value
  input parameter info :: <GIValueInfo*>;
  result res :: <gint64>;
  c-name: "g_value_info_get_value";
end;

define constant <GIFieldInfoFlags> = <C-int>;
define constant $GI-FIELD-IS-READABLE = 1;
define constant $GI-FIELD-IS-WRITABLE = 2;

define constant <GIFieldInfo> = <GIBaseInfo>;

define C-pointer-type <GIFieldInfo*> => <GIFieldInfo>;
define C-function g-field-info-get-flags
  input parameter info :: <GIFieldInfo*>;
  result res :: <GIFieldInfoFlags>;
  c-name: "g_field_info_get_flags";
end;

define C-function g-field-info-get-size
  input parameter info :: <GIFieldInfo*>;
  result res :: <gint>;
  c-name: "g_field_info_get_size";
end;

define C-function g-field-info-get-offset
  input parameter info :: <GIFieldInfo*>;
  result res :: <gint>;
  c-name: "g_field_info_get_offset";
end;

define C-function g-field-info-get-type
  input parameter info :: <GIFieldInfo*>;
  result res :: <GITypeInfo*>;
  c-name: "g_field_info_get_type";
end;

define C-function g-field-info-get-field
  input parameter field-info :: <GIFieldInfo*>;
  input parameter mem :: <gpointer>;
  input parameter value :: <GIArgument*>;
  result res :: <gboolean>;
  c-name: "g_field_info_get_field";
end;

define C-function g-field-info-set-field
  input parameter field-info :: <GIFieldInfo*>;
  input parameter mem :: <gpointer>;
  input parameter value :: <GIArgument*>;
  result res :: <gboolean>;
  c-name: "g_field_info_set_field";
end;

define C-function g-function-info-get-symbol
  input parameter info :: <GIFunctionInfo*>;
  result res :: <gchar*>;
  c-name: "g_function_info_get_symbol";
end;

define constant <GIFunctionInfoFlags> = <C-int>;
define constant $GI-FUNCTION-IS-METHOD = 1;
define constant $GI-FUNCTION-IS-CONSTRUCTOR = 2;
define constant $GI-FUNCTION-IS-GETTER = 4;
define constant $GI-FUNCTION-IS-SETTER = 8;
define constant $GI-FUNCTION-WRAPS-VFUNC = 16;
define constant $GI-FUNCTION-THROWS = 32;

define C-function g-function-info-get-flags
  input parameter info :: <GIFunctionInfo*>;
  result res :: <GIFunctionInfoFlags>;
  c-name: "g_function_info_get_flags";
end;

define constant <GIPropertyInfo> = <GIBaseInfo>;

define C-pointer-type <GIPropertyInfo*> => <GIPropertyInfo>;
define C-function g-function-info-get-property
  input parameter info :: <GIFunctionInfo*>;
  result res :: <GIPropertyInfo*>;
  c-name: "g_function_info_get_property";
end;

define constant <GIVFuncInfo> = <GIBaseInfo>;

define C-pointer-type <GIVFuncInfo*> => <GIVFuncInfo>;
define C-function g-function-info-get-vfunc
  input parameter info :: <GIFunctionInfo*>;
  result res :: <GIVFuncInfo*>;
  c-name: "g_function_info_get_vfunc";
end;

define C-function g-invoke-error-quark
  result res :: <GQuark>;
  c-name: "g_invoke_error_quark";
end;

define constant <GInvokeError> = <C-int>;
define constant $G-INVOKE-ERROR-FAILED = 0;
define constant $G-INVOKE-ERROR-SYMBOL-NOT-FOUND = 1;
define constant $G-INVOKE-ERROR-ARGUMENT-MISMATCH = 2;

define C-function g-function-info-invoke
  input parameter info :: <GIFunctionInfo*>;
  input parameter in-args :: <GIArgument*>;
  input parameter n-in-args :: <C-signed-int>;
  input parameter out-args :: <GIArgument*>;
  input parameter n-out-args :: <C-signed-int>;
  input parameter return-value :: <GIArgument*>;
  input parameter error :: <GError**>;
  result res :: <gboolean>;
  c-name: "g_function_info_invoke";
end;

define constant <GIInterfaceInfo> = <GIBaseInfo>;

define C-pointer-type <GIInterfaceInfo*> => <GIInterfaceInfo>;
define C-function g-interface-info-get-n-prerequisites
  input parameter info :: <GIInterfaceInfo*>;
  result res :: <gint>;
  c-name: "g_interface_info_get_n_prerequisites";
end;

define C-function g-interface-info-get-prerequisite
  input parameter info :: <GIInterfaceInfo*>;
  input parameter n :: <gint>;
  result res :: <GIBaseInfo*>;
  c-name: "g_interface_info_get_prerequisite";
end;

define C-function g-interface-info-get-n-properties
  input parameter info :: <GIInterfaceInfo*>;
  result res :: <gint>;
  c-name: "g_interface_info_get_n_properties";
end;

define C-function g-interface-info-get-property
  input parameter info :: <GIInterfaceInfo*>;
  input parameter n :: <gint>;
  result res :: <GIPropertyInfo*>;
  c-name: "g_interface_info_get_property";
end;

define C-function g-interface-info-get-n-methods
  input parameter info :: <GIInterfaceInfo*>;
  result res :: <gint>;
  c-name: "g_interface_info_get_n_methods";
end;

define C-function g-interface-info-get-method
  input parameter info :: <GIInterfaceInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_interface_info_get_method";
end;

define C-function g-interface-info-find-method
  input parameter info :: <GIInterfaceInfo*>;
  input parameter name :: <gchar*>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_interface_info_find_method";
end;

define C-function g-interface-info-get-n-signals
  input parameter info :: <GIInterfaceInfo*>;
  result res :: <gint>;
  c-name: "g_interface_info_get_n_signals";
end;

define constant <GISignalInfo> = <GIBaseInfo>;

define C-pointer-type <GISignalInfo*> => <GISignalInfo>;
define C-function g-interface-info-get-signal
  input parameter info :: <GIInterfaceInfo*>;
  input parameter n :: <gint>;
  result res :: <GISignalInfo*>;
  c-name: "g_interface_info_get_signal";
end;

define C-function g-interface-info-get-n-vfuncs
  input parameter info :: <GIInterfaceInfo*>;
  result res :: <gint>;
  c-name: "g_interface_info_get_n_vfuncs";
end;

define C-function g-interface-info-get-vfunc
  input parameter info :: <GIInterfaceInfo*>;
  input parameter n :: <gint>;
  result res :: <GIVFuncInfo*>;
  c-name: "g_interface_info_get_vfunc";
end;

define C-function g-interface-info-find-vfunc
  input parameter info :: <GIInterfaceInfo*>;
  input parameter name :: <gchar*>;
  result res :: <GIVFuncInfo*>;
  c-name: "g_interface_info_find_vfunc";
end;

define C-function g-interface-info-get-n-constants
  input parameter info :: <GIInterfaceInfo*>;
  result res :: <gint>;
  c-name: "g_interface_info_get_n_constants";
end;

define C-function g-interface-info-get-constant
  input parameter info :: <GIInterfaceInfo*>;
  input parameter n :: <gint>;
  result res :: <GIConstantInfo*>;
  c-name: "g_interface_info_get_constant";
end;

define constant <GIStructInfo> = <GIBaseInfo>;

define C-pointer-type <GIStructInfo*> => <GIStructInfo>;
define C-function g-interface-info-get-iface-struct
  input parameter info :: <GIInterfaceInfo*>;
  result res :: <GIStructInfo*>;
  c-name: "g_interface_info_get_iface_struct";
end;

define constant <anonymous-2545> = <C-function-pointer>;
define C-pointer-type <anonymous-2545*> => <anonymous-2545>;
define constant <GIObjectInfoRefFunction> = <anonymous-2545*>;

define constant <anonymous-2546> = <C-function-pointer>;
define C-pointer-type <anonymous-2546*> => <anonymous-2546>;
define constant <GIObjectInfoUnrefFunction> = <anonymous-2546*>;

define constant <anonymous-2547> = <C-function-pointer>;
define C-pointer-type <anonymous-2547*> => <anonymous-2547>;
define constant <GIObjectInfoSetValueFunction> = <anonymous-2547*>;

define constant <anonymous-2548> = <C-function-pointer>;
define C-pointer-type <anonymous-2548*> => <anonymous-2548>;
define constant <GIObjectInfoGetValueFunction> = <anonymous-2548*>;

define constant <GIObjectInfo> = <GIBaseInfo>;

define C-pointer-type <GIObjectInfo*> => <GIObjectInfo>;
define C-function g-object-info-get-type-name
  input parameter info :: <GIObjectInfo*>;
  result res :: <gchar*>;
  c-name: "g_object_info_get_type_name";
end;

define C-function g-object-info-get-type-init
  input parameter info :: <GIObjectInfo*>;
  result res :: <gchar*>;
  c-name: "g_object_info_get_type_init";
end;

define C-function g-object-info-get-abstract
  input parameter info :: <GIObjectInfo*>;
  result res :: <gboolean>;
  c-name: "g_object_info_get_abstract";
end;

define C-function g-object-info-get-fundamental
  input parameter info :: <GIObjectInfo*>;
  result res :: <gboolean>;
  c-name: "g_object_info_get_fundamental";
end;

define C-function g-object-info-get-parent
  input parameter info :: <GIObjectInfo*>;
  result res :: <GIObjectInfo*>;
  c-name: "g_object_info_get_parent";
end;

define C-function g-object-info-get-n-interfaces
  input parameter info :: <GIObjectInfo*>;
  result res :: <gint>;
  c-name: "g_object_info_get_n_interfaces";
end;

define C-function g-object-info-get-interface
  input parameter info :: <GIObjectInfo*>;
  input parameter n :: <gint>;
  result res :: <GIInterfaceInfo*>;
  c-name: "g_object_info_get_interface";
end;

define C-function g-object-info-get-n-fields
  input parameter info :: <GIObjectInfo*>;
  result res :: <gint>;
  c-name: "g_object_info_get_n_fields";
end;

define C-function g-object-info-get-field
  input parameter info :: <GIObjectInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFieldInfo*>;
  c-name: "g_object_info_get_field";
end;

define C-function g-object-info-get-n-properties
  input parameter info :: <GIObjectInfo*>;
  result res :: <gint>;
  c-name: "g_object_info_get_n_properties";
end;

define C-function g-object-info-get-property
  input parameter info :: <GIObjectInfo*>;
  input parameter n :: <gint>;
  result res :: <GIPropertyInfo*>;
  c-name: "g_object_info_get_property";
end;

define C-function g-object-info-get-n-methods
  input parameter info :: <GIObjectInfo*>;
  result res :: <gint>;
  c-name: "g_object_info_get_n_methods";
end;

define C-function g-object-info-get-method
  input parameter info :: <GIObjectInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_object_info_get_method";
end;

define C-function g-object-info-find-method
  input parameter info :: <GIObjectInfo*>;
  input parameter name :: <gchar*>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_object_info_find_method";
end;

define C-pointer-type <GIObjectInfo**> => <GIObjectInfo*>;
define C-function g-object-info-find-method-using-interfaces
  input parameter info :: <GIObjectInfo*>;
  input parameter name :: <gchar*>;
  input parameter implementor :: <GIObjectInfo**>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_object_info_find_method_using_interfaces";
end;

define C-function g-object-info-get-n-signals
  input parameter info :: <GIObjectInfo*>;
  result res :: <gint>;
  c-name: "g_object_info_get_n_signals";
end;

define C-function g-object-info-get-signal
  input parameter info :: <GIObjectInfo*>;
  input parameter n :: <gint>;
  result res :: <GISignalInfo*>;
  c-name: "g_object_info_get_signal";
end;

define C-function g-object-info-find-signal
  input parameter info :: <GIObjectInfo*>;
  input parameter name :: <gchar*>;
  result res :: <GISignalInfo*>;
  c-name: "g_object_info_find_signal";
end;

define C-function g-object-info-get-n-vfuncs
  input parameter info :: <GIObjectInfo*>;
  result res :: <gint>;
  c-name: "g_object_info_get_n_vfuncs";
end;

define C-function g-object-info-get-vfunc
  input parameter info :: <GIObjectInfo*>;
  input parameter n :: <gint>;
  result res :: <GIVFuncInfo*>;
  c-name: "g_object_info_get_vfunc";
end;

define C-function g-object-info-find-vfunc
  input parameter info :: <GIObjectInfo*>;
  input parameter name :: <gchar*>;
  result res :: <GIVFuncInfo*>;
  c-name: "g_object_info_find_vfunc";
end;

define C-function g-object-info-find-vfunc-using-interfaces
  input parameter info :: <GIObjectInfo*>;
  input parameter name :: <gchar*>;
  input parameter implementor :: <GIObjectInfo**>;
  result res :: <GIVFuncInfo*>;
  c-name: "g_object_info_find_vfunc_using_interfaces";
end;

define C-function g-object-info-get-n-constants
  input parameter info :: <GIObjectInfo*>;
  result res :: <gint>;
  c-name: "g_object_info_get_n_constants";
end;

define C-function g-object-info-get-constant
  input parameter info :: <GIObjectInfo*>;
  input parameter n :: <gint>;
  result res :: <GIConstantInfo*>;
  c-name: "g_object_info_get_constant";
end;

define C-function g-object-info-get-class-struct
  input parameter info :: <GIObjectInfo*>;
  result res :: <GIStructInfo*>;
  c-name: "g_object_info_get_class_struct";
end;

define C-function g-object-info-get-ref-function
  input parameter info :: <GIObjectInfo*>;
  result res :: <char*>;
  c-name: "g_object_info_get_ref_function";
end;

define C-function g-object-info-get-ref-function-pointer
  input parameter info :: <GIObjectInfo*>;
  result res :: <GIObjectInfoRefFunction>;
  c-name: "g_object_info_get_ref_function_pointer";
end;

define C-function g-object-info-get-unref-function
  input parameter info :: <GIObjectInfo*>;
  result res :: <char*>;
  c-name: "g_object_info_get_unref_function";
end;

define C-function g-object-info-get-unref-function-pointer
  input parameter info :: <GIObjectInfo*>;
  result res :: <GIObjectInfoUnrefFunction>;
  c-name: "g_object_info_get_unref_function_pointer";
end;

define C-function g-object-info-get-set-value-function
  input parameter info :: <GIObjectInfo*>;
  result res :: <char*>;
  c-name: "g_object_info_get_set_value_function";
end;

define C-function g-object-info-get-set-value-function-pointer
  input parameter info :: <GIObjectInfo*>;
  result res :: <GIObjectInfoSetValueFunction>;
  c-name: "g_object_info_get_set_value_function_pointer";
end;

define C-function g-object-info-get-get-value-function
  input parameter info :: <GIObjectInfo*>;
  result res :: <char*>;
  c-name: "g_object_info_get_get_value_function";
end;

define C-function g-object-info-get-get-value-function-pointer
  input parameter info :: <GIObjectInfo*>;
  result res :: <GIObjectInfoGetValueFunction>;
  c-name: "g_object_info_get_get_value_function_pointer";
end;

define C-function g-property-info-get-flags
  input parameter info :: <GIPropertyInfo*>;
  result res :: <GParamFlags>;
  c-name: "g_property_info_get_flags";
end;

define C-function g-property-info-get-type
  input parameter info :: <GIPropertyInfo*>;
  result res :: <GITypeInfo*>;
  c-name: "g_property_info_get_type";
end;

define C-function g-property-info-get-ownership-transfer
  input parameter info :: <GIPropertyInfo*>;
  result res :: <GITransfer>;
  c-name: "g_property_info_get_ownership_transfer";
end;

define constant <GIRegisteredTypeInfo> = <GIBaseInfo>;

define C-pointer-type <GIRegisteredTypeInfo*> => <GIRegisteredTypeInfo>;
define C-function g-registered-type-info-get-type-name
  input parameter info :: <GIRegisteredTypeInfo*>;
  result res :: <gchar*>;
  c-name: "g_registered_type_info_get_type_name";
end;

define C-function g-registered-type-info-get-type-init
  input parameter info :: <GIRegisteredTypeInfo*>;
  result res :: <gchar*>;
  c-name: "g_registered_type_info_get_type_init";
end;

define C-function g-registered-type-info-get-g-type
  input parameter info :: <GIRegisteredTypeInfo*>;
  result res :: <GType>;
  c-name: "g_registered_type_info_get_g_type";
end;

define constant <GSignalFlags> = <C-int>;
define constant $G-SIGNAL-RUN-FIRST = 1;
define constant $G-SIGNAL-RUN-LAST = 2;
define constant $G-SIGNAL-RUN-CLEANUP = 4;
define constant $G-SIGNAL-NO-RECURSE = 8;
define constant $G-SIGNAL-DETAILED = 16;
define constant $G-SIGNAL-ACTION = 32;
define constant $G-SIGNAL-NO-HOOKS = 64;
define constant $G-SIGNAL-MUST-COLLECT = 128;
define constant $G-SIGNAL-DEPRECATED = 256;

define C-function g-signal-info-get-flags
  input parameter info :: <GISignalInfo*>;
  result res :: <GSignalFlags>;
  c-name: "g_signal_info_get_flags";
end;

define C-function g-signal-info-get-class-closure
  input parameter info :: <GISignalInfo*>;
  result res :: <GIVFuncInfo*>;
  c-name: "g_signal_info_get_class_closure";
end;

define C-function g-signal-info-true-stops-emit
  input parameter info :: <GISignalInfo*>;
  result res :: <gboolean>;
  c-name: "g_signal_info_true_stops_emit";
end;

define C-function g-struct-info-get-n-fields
  input parameter info :: <GIStructInfo*>;
  result res :: <gint>;
  c-name: "g_struct_info_get_n_fields";
end;

define C-function g-struct-info-get-field
  input parameter info :: <GIStructInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFieldInfo*>;
  c-name: "g_struct_info_get_field";
end;

define C-function g-struct-info-get-n-methods
  input parameter info :: <GIStructInfo*>;
  result res :: <gint>;
  c-name: "g_struct_info_get_n_methods";
end;

define C-function g-struct-info-get-method
  input parameter info :: <GIStructInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_struct_info_get_method";
end;

define C-function g-struct-info-find-method
  input parameter info :: <GIStructInfo*>;
  input parameter name :: <gchar*>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_struct_info_find_method";
end;

define C-function g-struct-info-get-size
  input parameter info :: <GIStructInfo*>;
  result res :: <gsize>;
  c-name: "g_struct_info_get_size";
end;

define C-function g-struct-info-get-alignment
  input parameter info :: <GIStructInfo*>;
  result res :: <gsize>;
  c-name: "g_struct_info_get_alignment";
end;

define C-function g-struct-info-is-gtype-struct
  input parameter info :: <GIStructInfo*>;
  result res :: <gboolean>;
  c-name: "g_struct_info_is_gtype_struct";
end;

define C-function g-struct-info-is-foreign
  input parameter info :: <GIStructInfo*>;
  result res :: <gboolean>;
  c-name: "g_struct_info_is_foreign";
end;

define C-function g-type-tag-to-string
  input parameter type :: <GITypeTag>;
  result res :: <gchar*>;
  c-name: "g_type_tag_to_string";
end;

define constant <GIInfoType> = <C-int>;
define constant $GI-INFO-TYPE-INVALID = 0;
define constant $GI-INFO-TYPE-FUNCTION = 1;
define constant $GI-INFO-TYPE-CALLBACK = 2;
define constant $GI-INFO-TYPE-STRUCT = 3;
define constant $GI-INFO-TYPE-BOXED = 4;
define constant $GI-INFO-TYPE-ENUM = 5;
define constant $GI-INFO-TYPE-FLAGS = 6;
define constant $GI-INFO-TYPE-OBJECT = 7;
define constant $GI-INFO-TYPE-INTERFACE = 8;
define constant $GI-INFO-TYPE-CONSTANT = 9;
define constant $GI-INFO-TYPE-INVALID-0 = 10;
define constant $GI-INFO-TYPE-UNION = 11;
define constant $GI-INFO-TYPE-VALUE = 12;
define constant $GI-INFO-TYPE-SIGNAL = 13;
define constant $GI-INFO-TYPE-VFUNC = 14;
define constant $GI-INFO-TYPE-PROPERTY = 15;
define constant $GI-INFO-TYPE-FIELD = 16;
define constant $GI-INFO-TYPE-ARG = 17;
define constant $GI-INFO-TYPE-TYPE = 18;
define constant $GI-INFO-TYPE-UNRESOLVED = 19;

define C-function g-info-type-to-string
  input parameter type :: <GIInfoType>;
  result res :: <gchar*>;
  c-name: "g_info_type_to_string";
end;

define C-function g-type-info-is-pointer
  input parameter info :: <GITypeInfo*>;
  result res :: <gboolean>;
  c-name: "g_type_info_is_pointer";
end;

define C-function g-type-info-get-tag
  input parameter info :: <GITypeInfo*>;
  result res :: <GITypeTag>;
  c-name: "g_type_info_get_tag";
end;

define C-function g-type-info-get-param-type
  input parameter info :: <GITypeInfo*>;
  input parameter n :: <gint>;
  result res :: <GITypeInfo*>;
  c-name: "g_type_info_get_param_type";
end;

define C-function g-type-info-get-interface
  input parameter info :: <GITypeInfo*>;
  result res :: <GIBaseInfo*>;
  c-name: "g_type_info_get_interface";
end;

define C-function g-type-info-get-array-length
  input parameter info :: <GITypeInfo*>;
  result res :: <gint>;
  c-name: "g_type_info_get_array_length";
end;

define C-function g-type-info-get-array-fixed-size
  input parameter info :: <GITypeInfo*>;
  result res :: <gint>;
  c-name: "g_type_info_get_array_fixed_size";
end;

define C-function g-type-info-is-zero-terminated
  input parameter info :: <GITypeInfo*>;
  result res :: <gboolean>;
  c-name: "g_type_info_is_zero_terminated";
end;

define constant <GIArrayType> = <C-int>;
define constant $GI-ARRAY-TYPE-C = 0;
define constant $GI-ARRAY-TYPE-ARRAY = 1;
define constant $GI-ARRAY-TYPE-PTR-ARRAY = 2;
define constant $GI-ARRAY-TYPE-BYTE-ARRAY = 3;

define C-function g-type-info-get-array-type
  input parameter info :: <GITypeInfo*>;
  result res :: <GIArrayType>;
  c-name: "g_type_info_get_array_type";
end;

define constant <GIUnionInfo> = <GIBaseInfo>;

define C-pointer-type <GIUnionInfo*> => <GIUnionInfo>;
define C-function g-union-info-get-n-fields
  input parameter info :: <GIUnionInfo*>;
  result res :: <gint>;
  c-name: "g_union_info_get_n_fields";
end;

define C-function g-union-info-get-field
  input parameter info :: <GIUnionInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFieldInfo*>;
  c-name: "g_union_info_get_field";
end;

define C-function g-union-info-get-n-methods
  input parameter info :: <GIUnionInfo*>;
  result res :: <gint>;
  c-name: "g_union_info_get_n_methods";
end;

define C-function g-union-info-get-method
  input parameter info :: <GIUnionInfo*>;
  input parameter n :: <gint>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_union_info_get_method";
end;

define C-function g-union-info-is-discriminated
  input parameter info :: <GIUnionInfo*>;
  result res :: <gboolean>;
  c-name: "g_union_info_is_discriminated";
end;

define C-function g-union-info-get-discriminator-offset
  input parameter info :: <GIUnionInfo*>;
  result res :: <gint>;
  c-name: "g_union_info_get_discriminator_offset";
end;

define C-function g-union-info-get-discriminator-type
  input parameter info :: <GIUnionInfo*>;
  result res :: <GITypeInfo*>;
  c-name: "g_union_info_get_discriminator_type";
end;

define C-function g-union-info-get-discriminator
  input parameter info :: <GIUnionInfo*>;
  input parameter n :: <gint>;
  result res :: <GIConstantInfo*>;
  c-name: "g_union_info_get_discriminator";
end;

define C-function g-union-info-find-method
  input parameter info :: <GIUnionInfo*>;
  input parameter name :: <gchar*>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_union_info_find_method";
end;

define C-function g-union-info-get-size
  input parameter info :: <GIUnionInfo*>;
  result res :: <gsize>;
  c-name: "g_union_info_get_size";
end;

define C-function g-union-info-get-alignment
  input parameter info :: <GIUnionInfo*>;
  result res :: <gsize>;
  c-name: "g_union_info_get_alignment";
end;

define constant <GIVFuncInfoFlags> = <C-int>;
define constant $GI-VFUNC-MUST-CHAIN-UP = 1;
define constant $GI-VFUNC-MUST-OVERRIDE = 2;
define constant $GI-VFUNC-MUST-NOT-OVERRIDE = 4;
define constant $GI-VFUNC-THROWS = 8;

define C-function g-vfunc-info-get-flags
  input parameter info :: <GIVFuncInfo*>;
  result res :: <GIVFuncInfoFlags>;
  c-name: "g_vfunc_info_get_flags";
end;

define C-function g-vfunc-info-get-offset
  input parameter info :: <GIVFuncInfo*>;
  result res :: <gint>;
  c-name: "g_vfunc_info_get_offset";
end;

define C-function g-vfunc-info-get-signal
  input parameter info :: <GIVFuncInfo*>;
  result res :: <GISignalInfo*>;
  c-name: "g_vfunc_info_get_signal";
end;

define C-function g-vfunc-info-get-invoker
  input parameter info :: <GIVFuncInfo*>;
  result res :: <GIFunctionInfo*>;
  c-name: "g_vfunc_info_get_invoker";
end;

define C-function g-vfunc-info-get-address
  input parameter info :: <GIVFuncInfo*>;
  input parameter implementor-gtype :: <GType>;
  input parameter error :: <GError**>;
  result res :: <gpointer>;
  c-name: "g_vfunc_info_get_address";
end;

define C-function g-vfunc-info-invoke
  input parameter info :: <GIVFuncInfo*>;
  input parameter implementor :: <GType>;
  input parameter in-args :: <GIArgument*>;
  input parameter n-in-args :: <C-signed-int>;
  input parameter out-args :: <GIArgument*>;
  input parameter n-out-args :: <C-signed-int>;
  input parameter return-value :: <GIArgument*>;
  input parameter error :: <GError**>;
  result res :: <gboolean>;
  c-name: "g_vfunc_info_invoke";
end;

