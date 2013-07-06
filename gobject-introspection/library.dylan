module: dylan-user
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define library gobject-introspection
  use common-dylan;
  use c-ffi;

  export gobject-introspection;
end library;

define module gobject-introspection
  use common-dylan;
  use c-ffi;
  export
    $G-INVOKE-ERROR-ARGUMENT-MISMATCH,
    $G-INVOKE-ERROR-FAILED,
    $G-INVOKE-ERROR-SYMBOL-NOT-FOUND,
    $G-IREPOSITORY-ERROR-LIBRARY-NOT-FOUND,
    $G-IREPOSITORY-ERROR-NAMESPACE-MISMATCH,
    $G-IREPOSITORY-ERROR-NAMESPACE-VERSION-CONFLICT,
    $G-IREPOSITORY-ERROR-TYPELIB-NOT-FOUND,
    $G-IREPOSITORY-LOAD-FLAG-LAZY,
    $G-PARAM-CONSTRUCT,
    $G-PARAM-CONSTRUCT-ONLY,
    $G-PARAM-DEPRECATED,
    $G-PARAM-LAX-VALIDATION,
    $G-PARAM-PRIVATE,
    $G-PARAM-READABLE,
    $G-PARAM-STATIC-BLURB,
    $G-PARAM-STATIC-NAME,
    $G-PARAM-STATIC-NICK,
    $G-PARAM-WRITABLE,
    $G-SIGNAL-ACTION,
    $G-SIGNAL-DEPRECATED,
    $G-SIGNAL-DETAILED,
    $G-SIGNAL-MUST-COLLECT,
    $G-SIGNAL-NO-HOOKS,
    $G-SIGNAL-NO-RECURSE,
    $G-SIGNAL-RUN-CLEANUP,
    $G-SIGNAL-RUN-FIRST,
    $G-SIGNAL-RUN-LAST,
    $GI-ARRAY-TYPE-ARRAY,
    $GI-ARRAY-TYPE-BYTE-ARRAY,
    $GI-ARRAY-TYPE-C,
    $GI-ARRAY-TYPE-PTR-ARRAY,
    $GI-DIRECTION-IN,
    $GI-DIRECTION-INOUT,
    $GI-DIRECTION-OUT,
    $GI-FIELD-IS-READABLE,
    $GI-FIELD-IS-WRITABLE,
    $GI-FUNCTION-IS-CONSTRUCTOR,
    $GI-FUNCTION-IS-GETTER,
    $GI-FUNCTION-IS-METHOD,
    $GI-FUNCTION-IS-SETTER,
    $GI-FUNCTION-THROWS,
    $GI-FUNCTION-WRAPS-VFUNC,
    $GI-INFO-TYPE-ARG,
    $GI-INFO-TYPE-BOXED,
    $GI-INFO-TYPE-CALLBACK,
    $GI-INFO-TYPE-CONSTANT,
    $GI-INFO-TYPE-ENUM,
    $GI-INFO-TYPE-FIELD,
    $GI-INFO-TYPE-FLAGS,
    $GI-INFO-TYPE-FUNCTION,
    $GI-INFO-TYPE-INTERFACE,
    $GI-INFO-TYPE-INVALID,
    $GI-INFO-TYPE-INVALID-0,
    $GI-INFO-TYPE-OBJECT,
    $GI-INFO-TYPE-PROPERTY,
    $GI-INFO-TYPE-SIGNAL,
    $GI-INFO-TYPE-STRUCT,
    $GI-INFO-TYPE-TYPE,
    $GI-INFO-TYPE-UNION,
    $GI-INFO-TYPE-UNRESOLVED,
    $GI-INFO-TYPE-VALUE,
    $GI-INFO-TYPE-VFUNC,
    $GI-SCOPE-TYPE-ASYNC,
    $GI-SCOPE-TYPE-CALL,
    $GI-SCOPE-TYPE-INVALID,
    $GI-SCOPE-TYPE-NOTIFIED,
    $GI-TRANSFER-CONTAINER,
    $GI-TRANSFER-EVERYTHING,
    $GI-TRANSFER-NOTHING,
    $GI-TYPE-TAG-ARRAY,
    $GI-TYPE-TAG-BOOLEAN,
    $GI-TYPE-TAG-DOUBLE,
    $GI-TYPE-TAG-ERROR,
    $GI-TYPE-TAG-FILENAME,
    $GI-TYPE-TAG-FLOAT,
    $GI-TYPE-TAG-GHASH,
    $GI-TYPE-TAG-GLIST,
    $GI-TYPE-TAG-GSLIST,
    $GI-TYPE-TAG-GTYPE,
    $GI-TYPE-TAG-INT16,
    $GI-TYPE-TAG-INT32,
    $GI-TYPE-TAG-INT64,
    $GI-TYPE-TAG-INT8,
    $GI-TYPE-TAG-INTERFACE,
    $GI-TYPE-TAG-UINT16,
    $GI-TYPE-TAG-UINT32,
    $GI-TYPE-TAG-UINT64,
    $GI-TYPE-TAG-UINT8,
    $GI-TYPE-TAG-UNICHAR,
    $GI-TYPE-TAG-UTF8,
    $GI-TYPE-TAG-VOID,
    $GI-VFUNC-MUST-CHAIN-UP,
    $GI-VFUNC-MUST-NOT-OVERRIDE,
    $GI-VFUNC-MUST-OVERRIDE,
    $GI-VFUNC-THROWS,
    <GClosure*>,
    <GClosure>,
    <GClosureNotify>,
    <GClosureNotifyData*>,
    <GClosureNotifyData>,
    <GData>,
    <GError**>,
    <GError*>,
    <GError>,
    <GIArgInfo>,
    <GIArgument>,
    <GIArrayType>,
    <GIAttributeIter>,
    <GICallableInfo>,
    <GIConstantInfo>,
    <GIDirection>,
    <GIEnumInfo>,
    <GIFieldInfo>,
    <GIFieldInfoFlags>,
    <GIFunctionInfo>,
    <GIFunctionInfoFlags>,
    <GIInfoType>,
    <GIInterfaceInfo>,
    <GIObjectInfo*>,
    <GIObjectInfo>,
    <GIObjectInfoGetValueFunction>,
    <GIObjectInfoRefFunction>,
    <GIObjectInfoSetValueFunction>,
    <GIObjectInfoUnrefFunction>,
    <GIPropertyInfo>,
    <GIRegisteredTypeInfo>,
    <GIScopeType>,
    <GISignalInfo>,
    <GIStructInfo>,
    <GITransfer>,
    <GITypeInfo>,
    <GITypeTag>,
    <GIUnionInfo>,
    <GIVFuncInfo>,
    <GIVFuncInfoFlags>,
    <GIValueInfo>,
    <GInvokeError>,
    <GList>,
    <GObject>,
    <GObjectClass>,
    <GObjectConstructParam>,
    <GOptionGroup>,
    <GParamFlags>,
    <GParamSpec>,
    <GQuark>,
    <GSList>,
    <GSignalFlags>,
    <GType>,
    <GTypeClass>,
    <GTypeInstance>,
    <GValue>,
    <_GClosure>,
    <_GClosureNotifyData>,
    <_GData>,
    <_GError>,
    <_GIArgument>,
    <_GIBaseInfo>,
    <_GIBaseInfoStub>,
    <_GIRepository>,
    <_GIRepositoryClass>,
    <_GIRepositoryPrivate>,
    <_GITypelib>,
    <_GList>,
    <_GObject>,
    <_GObjectClass>,
    <_GObjectConstructParam>,
    <_GOptionGroup>,
    <_GParamSpec>,
    <_GSList>,
    <_GTypeClass>,
    <_GTypeInstance>,
    <_GValue>,
    <char**>,
    <gboolean>,
    <gchar**>,
    <gchar>,
    <gdouble>,
    <gfloat>,
    <gint16>,
    <gint32>,
    <gint64>,
    <gint8>,
    <gint>,
    <glong>,
    <gpointer*>,
    <gpointer>,
    <gshort>,
    <gsize>,
    <gssize>,
    <guint16>,
    <guint32>,
    <guint64>,
    <guint8>,
    <guint>,
    <gulong>,
    <gushort>,
    GIAttributeIter$data,
    GIAttributeIter$data-setter,
    GIAttributeIter$data2,
    GIAttributeIter$data2-setter,
    GIAttributeIter$data3,
    GIAttributeIter$data3-setter,
    GIAttributeIter$data4,
    GIAttributeIter$data4-setter,
    _GClosure$data,
    _GClosure$data-setter,
    _GClosure$derivative-flag,
    _GClosure$derivative-flag-setter,
    _GClosure$floating,
    _GClosure$floating-setter,
    _GClosure$in-inotify,
    _GClosure$in-inotify-setter,
    _GClosure$in-marshal,
    _GClosure$in-marshal-setter,
    _GClosure$is-invalid,
    _GClosure$is-invalid-setter,
    _GClosure$marshal,
    _GClosure$marshal-setter,
    _GClosure$meta-marshal-nouse,
    _GClosure$meta-marshal-nouse-setter,
    _GClosure$n-fnotifiers,
    _GClosure$n-fnotifiers-setter,
    _GClosure$n-guards,
    _GClosure$n-guards-setter,
    _GClosure$n-inotifiers,
    _GClosure$n-inotifiers-setter,
    _GClosure$notifiers,
    _GClosure$notifiers-setter,
    _GClosure$ref-count,
    _GClosure$ref-count-setter,
    _GClosureNotifyData$data,
    _GClosureNotifyData$data-setter,
    _GClosureNotifyData$notify,
    _GClosureNotifyData$notify-setter,
    _GError$code,
    _GError$code-setter,
    _GError$domain,
    _GError$domain-setter,
    _GError$message,
    _GError$message-setter,
    _GIArgument$v-boolean,
    _GIArgument$v-boolean-setter,
    _GIArgument$v-double,
    _GIArgument$v-double-setter,
    _GIArgument$v-float,
    _GIArgument$v-float-setter,
    _GIArgument$v-int,
    _GIArgument$v-int-setter,
    _GIArgument$v-int16,
    _GIArgument$v-int16-setter,
    _GIArgument$v-int32,
    _GIArgument$v-int32-setter,
    _GIArgument$v-int64,
    _GIArgument$v-int64-setter,
    _GIArgument$v-int8,
    _GIArgument$v-int8-setter,
    _GIArgument$v-long,
    _GIArgument$v-long-setter,
    _GIArgument$v-pointer,
    _GIArgument$v-pointer-setter,
    _GIArgument$v-short,
    _GIArgument$v-short-setter,
    _GIArgument$v-size,
    _GIArgument$v-size-setter,
    _GIArgument$v-ssize,
    _GIArgument$v-ssize-setter,
    _GIArgument$v-string,
    _GIArgument$v-string-setter,
    _GIArgument$v-uint,
    _GIArgument$v-uint-setter,
    _GIArgument$v-uint16,
    _GIArgument$v-uint16-setter,
    _GIArgument$v-uint32,
    _GIArgument$v-uint32-setter,
    _GIArgument$v-uint64,
    _GIArgument$v-uint64-setter,
    _GIArgument$v-uint8,
    _GIArgument$v-uint8-setter,
    _GIArgument$v-ulong,
    _GIArgument$v-ulong-setter,
    _GIArgument$v-ushort,
    _GIArgument$v-ushort-setter,
    _GIBaseInfoStub$dummy1,
    _GIBaseInfoStub$dummy1-setter,
    _GIBaseInfoStub$dummy2,
    _GIBaseInfoStub$dummy2-setter,
    _GIBaseInfoStub$dummy3,
    _GIBaseInfoStub$dummy3-setter,
    _GIBaseInfoStub$dummy4,
    _GIBaseInfoStub$dummy4-setter,
    _GIBaseInfoStub$dummy5,
    _GIBaseInfoStub$dummy5-setter,
    _GIBaseInfoStub$dummy6,
    _GIBaseInfoStub$dummy6-setter,
    _GIBaseInfoStub$dummy7,
    _GIBaseInfoStub$dummy7-setter,
    _GIBaseInfoStub$padding,
    _GIBaseInfoStub$padding-setter,
    _GIRepository$parent,
    _GIRepository$parent-setter,
    _GIRepository$priv,
    _GIRepository$priv-setter,
    _GIRepositoryClass$parent,
    _GIRepositoryClass$parent-setter,
    _GList$data,
    _GList$data-setter,
    _GList$next,
    _GList$next-setter,
    _GList$prev,
    _GList$prev-setter,
    _GObject$g-type-instance,
    _GObject$g-type-instance-setter,
    _GObject$qdata,
    _GObject$qdata-setter,
    _GObject$ref-count,
    _GObject$ref-count-setter,
    _GObjectClass$construct-properties,
    _GObjectClass$construct-properties-setter,
    _GObjectClass$constructed,
    _GObjectClass$constructed-setter,
    _GObjectClass$constructor,
    _GObjectClass$constructor-setter,
    _GObjectClass$dispatch-properties-changed,
    _GObjectClass$dispatch-properties-changed-setter,
    _GObjectClass$dispose,
    _GObjectClass$dispose-setter,
    _GObjectClass$finalize,
    _GObjectClass$finalize-setter,
    _GObjectClass$flags,
    _GObjectClass$flags-setter,
    _GObjectClass$g-type-class,
    _GObjectClass$g-type-class-setter,
    _GObjectClass$get-property,
    _GObjectClass$get-property-setter,
    _GObjectClass$notify,
    _GObjectClass$notify-setter,
    _GObjectClass$pdummy,
    _GObjectClass$pdummy-setter,
    _GObjectClass$set-property,
    _GObjectClass$set-property-setter,
    _GObjectConstructParam$pspec,
    _GObjectConstructParam$pspec-setter,
    _GObjectConstructParam$value,
    _GObjectConstructParam$value-setter,
    _GParamSpec$_blurb,
    _GParamSpec$_blurb-setter,
    _GParamSpec$_nick,
    _GParamSpec$_nick-setter,
    _GParamSpec$flags,
    _GParamSpec$flags-setter,
    _GParamSpec$g-type-instance,
    _GParamSpec$g-type-instance-setter,
    _GParamSpec$name,
    _GParamSpec$name-setter,
    _GParamSpec$owner-type,
    _GParamSpec$owner-type-setter,
    _GParamSpec$param-id,
    _GParamSpec$param-id-setter,
    _GParamSpec$qdata,
    _GParamSpec$qdata-setter,
    _GParamSpec$ref-count,
    _GParamSpec$ref-count-setter,
    _GParamSpec$value-type,
    _GParamSpec$value-type-setter,
    _GSList$data,
    _GSList$data-setter,
    _GSList$next,
    _GSList$next-setter,
    _GTypeClass$g-type,
    _GTypeClass$g-type-setter,
    _GTypeInstance$g-class,
    _GTypeInstance$g-class-setter,
    _GValue$data,
    _GValue$data-setter,
    _GValue$g-type,
    _GValue$g-type-setter,
    anonymous-2007$v-double,
    anonymous-2007$v-double-setter,
    anonymous-2007$v-float,
    anonymous-2007$v-float-setter,
    anonymous-2007$v-int,
    anonymous-2007$v-int-setter,
    anonymous-2007$v-int64,
    anonymous-2007$v-int64-setter,
    anonymous-2007$v-long,
    anonymous-2007$v-long-setter,
    anonymous-2007$v-pointer,
    anonymous-2007$v-pointer-setter,
    anonymous-2007$v-uint,
    anonymous-2007$v-uint-setter,
    anonymous-2007$v-uint64,
    anonymous-2007$v-uint64-setter,
    anonymous-2007$v-ulong,
    anonymous-2007$v-ulong-setter,
    g-arg-info-get-closure,
    g-arg-info-get-destroy,
    g-arg-info-get-direction,
    g-arg-info-get-ownership-transfer,
    g-arg-info-get-scope,
    g-arg-info-get-type,
    g-arg-info-is-caller-allocates,
    g-arg-info-is-optional,
    g-arg-info-is-return-value,
    g-arg-info-is-skip,
    g-arg-info-load-type,
    g-arg-info-may-be-null,
    g-callable-info-get-arg,
    g-callable-info-get-caller-owns,
    g-callable-info-get-n-args,
    g-callable-info-get-return-attribute,
    g-callable-info-get-return-type,
    g-callable-info-iterate-return-attributes,
    g-callable-info-load-arg,
    g-callable-info-load-return-type,
    g-callable-info-may-return-null,
    g-callable-info-skip-return,
    g-constant-info-free-value,
    g-constant-info-get-type,
    g-constant-info-get-value,
    g-enum-info-get-error-domain,
    g-enum-info-get-method,
    g-enum-info-get-n-methods,
    g-enum-info-get-n-values,
    g-enum-info-get-storage-type,
    g-enum-info-get-value,
    g-field-info-get-field,
    g-field-info-get-flags,
    g-field-info-get-offset,
    g-field-info-get-size,
    g-field-info-get-type,
    g-field-info-set-field,
    g-function-info-get-flags,
    g-function-info-get-property,
    g-function-info-get-symbol,
    g-function-info-get-vfunc,
    g-function-info-invoke,
    g-info-type-to-string,
    g-interface-info-find-method,
    g-interface-info-find-vfunc,
    g-interface-info-get-constant,
    g-interface-info-get-iface-struct,
    g-interface-info-get-method,
    g-interface-info-get-n-constants,
    g-interface-info-get-n-methods,
    g-interface-info-get-n-prerequisites,
    g-interface-info-get-n-properties,
    g-interface-info-get-n-signals,
    g-interface-info-get-n-vfuncs,
    g-interface-info-get-prerequisite,
    g-interface-info-get-property,
    g-interface-info-get-signal,
    g-interface-info-get-vfunc,
    g-invoke-error-quark,
    g-irepository-dump,
    g-irepository-enumerate-versions,
    g-irepository-error-quark,
    g-irepository-find-by-error-domain,
    g-irepository-find-by-gtype,
    g-irepository-find-by-name,
    g-irepository-get-c-prefix,
    g-irepository-get-default,
    g-irepository-get-dependencies,
    g-irepository-get-info,
    g-irepository-get-loaded-namespaces,
    g-irepository-get-n-infos,
    g-irepository-get-option-group,
    g-irepository-get-search-path,
    g-irepository-get-shared-library,
    g-irepository-get-type,
    g-irepository-get-typelib-path,
    g-irepository-get-version,
    g-irepository-is-registered,
    g-irepository-load-typelib,
    g-irepository-prepend-search-path,
    g-irepository-require,
    g-irepository-require-private,
    g-object-info-find-method,
    g-object-info-find-method-using-interfaces,
    g-object-info-find-signal,
    g-object-info-find-vfunc,
    g-object-info-find-vfunc-using-interfaces,
    g-object-info-get-abstract,
    g-object-info-get-class-struct,
    g-object-info-get-constant,
    g-object-info-get-field,
    g-object-info-get-fundamental,
    g-object-info-get-get-value-function,
    g-object-info-get-get-value-function-pointer,
    g-object-info-get-interface,
    g-object-info-get-method,
    g-object-info-get-n-constants,
    g-object-info-get-n-fields,
    g-object-info-get-n-interfaces,
    g-object-info-get-n-methods,
    g-object-info-get-n-properties,
    g-object-info-get-n-signals,
    g-object-info-get-n-vfuncs,
    g-object-info-get-parent,
    g-object-info-get-property,
    g-object-info-get-ref-function,
    g-object-info-get-ref-function-pointer,
    g-object-info-get-set-value-function,
    g-object-info-get-set-value-function-pointer,
    g-object-info-get-signal,
    g-object-info-get-type-init,
    g-object-info-get-type-name,
    g-object-info-get-unref-function,
    g-object-info-get-unref-function-pointer,
    g-object-info-get-vfunc,
    g-property-info-get-flags,
    g-property-info-get-ownership-transfer,
    g-property-info-get-type,
    g-registered-type-info-get-g-type,
    g-registered-type-info-get-type-init,
    g-registered-type-info-get-type-name,
    g-signal-info-get-class-closure,
    g-signal-info-get-flags,
    g-signal-info-true-stops-emit,
    g-struct-info-find-method,
    g-struct-info-get-alignment,
    g-struct-info-get-field,
    g-struct-info-get-method,
    g-struct-info-get-n-fields,
    g-struct-info-get-n-methods,
    g-struct-info-get-size,
    g-struct-info-is-foreign,
    g-struct-info-is-gtype-struct,
    g-type-info-get-array-fixed-size,
    g-type-info-get-array-length,
    g-type-info-get-array-type,
    g-type-info-get-interface,
    g-type-info-get-param-type,
    g-type-info-get-tag,
    g-type-info-is-pointer,
    g-type-info-is-zero-terminated,
    g-type-tag-to-string,
    g-union-info-find-method,
    g-union-info-get-alignment,
    g-union-info-get-discriminator,
    g-union-info-get-discriminator-offset,
    g-union-info-get-discriminator-type,
    g-union-info-get-field,
    g-union-info-get-method,
    g-union-info-get-n-fields,
    g-union-info-get-n-methods,
    g-union-info-get-size,
    g-union-info-is-discriminated,
    g-value-info-get-value,
    g-vfunc-info-get-address,
    g-vfunc-info-get-flags,
    g-vfunc-info-get-invoker,
    g-vfunc-info-get-offset,
    g-vfunc-info-get-signal,
    g-vfunc-info-invoke,
    gi-cclosure-marshal-generic;

  export <GIBaseInfo>,
    g-base-info-gtype-get-type,
    g-base-info-ref,
    g-base-info-unref,
    g-base-info-get-type,
    g-base-info-get-name,
    g-base-info-get-namespace,
    g-base-info-is-deprecated,
    g-base-info-get-attribute,
    g-base-info-iterate-attributes,
    g-base-info-get-container,
    g-base-info-get-typelib,
    g-base-info-equal,
    g-info-new;

  export <GIRepository>,
    <GIRepositoryClass>,
    <GIRepositoryError>,
    <GIRepositoryLoadFlags>,
    <GIRepositoryPrivate>;


  export <GITypelib>,
    g-typelib-new-from-memory,
    g-typelib-new-from-const-memory,
    g-typelib-new-from-mapped-file,
    g-typelib-free,
    g-typelib-symbol,
    g-typelib-get-namespace;

end module;
