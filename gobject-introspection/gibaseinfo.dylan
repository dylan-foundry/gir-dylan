module: gobject-introspection
synopsis: bindings for the gobject-introspection library
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define C-struct <GIAttributeIter>
  slot GIAttributeIter$data :: <C-void*>;
  slot GIAttributeIter$data2 :: <C-void*>;
  slot GIAttributeIter$data3 :: <C-void*>;
  slot GIAttributeIter$data4 :: <C-void*>;
end;
define C-pointer-type <GIAttributeIter*> => <GIAttributeIter>;

define C-function g-base-info-gtype-get-type
  result res :: <GType>;
  c-name: "g_base_info_gtype_get_type";
end;

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

define constant <_GIBaseInfo> = <_GIBaseInfoStub>;
define C-pointer-type <GIBaseInfo> => <_GIBaseInfo>;

define C-function g-base-info-ref
  input parameter info_ :: <GIBaseInfo>;
  result res :: <GIBaseInfo>;
  c-name: "g_base_info_ref";
end;

define C-function g-base-info-unref
  input parameter info_ :: <GIBaseInfo>;
  c-name: "g_base_info_unref";
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

define C-function g-base-info-get-type
  input parameter info_ :: <GIBaseInfo>;
  result res :: <GIInfoType>;
  c-name: "g_base_info_get_type";
end;

define C-function g-base-info-get-name
  input parameter info_ :: <GIBaseInfo>;
  result res :: <C-string>;
  c-name: "g_base_info_get_name";
end;

define C-function g-base-info-get-namespace
  input parameter info_ :: <GIBaseInfo>;
  result res :: <C-string>;
  c-name: "g_base_info_get_namespace";
end;

define C-function g-base-info-is-deprecated
  input parameter info_ :: <GIBaseInfo>;
  result res :: <C-boolean>;
  c-name: "g_base_info_is_deprecated";
end;

define C-function g-base-info-get-attribute
  input parameter info_ :: <GIBaseInfo>;
  input parameter name_ :: <C-string>;
  result res :: <C-string>;
  c-name: "g_base_info_get_attribute";
end;

define C-function g-base-info-iterate-attributes
  input parameter info_ :: <GIBaseInfo>;
  input parameter iterator_ :: <GIAttributeIter*>;
  input parameter name_ :: <char**>;
  input parameter value_ :: <char**>;
  result res :: <C-boolean>;
  c-name: "g_base_info_iterate_attributes";
end;

define C-function g-base-info-get-container
  input parameter info_ :: <GIBaseInfo>;
  result res :: <GIBaseInfo>;
  c-name: "g_base_info_get_container";
end;

define C-function g-base-info-get-typelib
  input parameter info_ :: <GIBaseInfo>;
  result res :: <GITypelib>;
  c-name: "g_base_info_get_typelib";
end;

define C-function g-base-info-equal
  input parameter info1_ :: <GIBaseInfo>;
  input parameter info2_ :: <GIBaseInfo>;
  result res :: <C-boolean>;
  c-name: "g_base_info_equal";
end;

define C-function g-info-new
  input parameter type_ :: <GIInfoType>;
  input parameter container_ :: <GIBaseInfo>;
  input parameter typelib_ :: <GITypelib>;
  input parameter offset_ :: <guint32>;
  result res :: <GIBaseInfo>;
  c-name: "g_info_new";
end;
