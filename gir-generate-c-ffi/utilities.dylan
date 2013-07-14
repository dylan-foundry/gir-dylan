module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

/* This is borrowed from code in melange */
define method map-name
    (category :: <symbol>, prefix :: <string>, name :: <string>)
 => (result :: <string>);
  let buffer = make(<stretchy-vector>);

  if (category == #"type")
    add!(buffer, '<');
    add!(buffer, '_');
  elseif (category == #"type-pointer")
    add!(buffer, '<');
  elseif (category == #"union")
    add!(buffer, '<');
  elseif (category == #"enum")
    add!(buffer, '<');
  elseif (category == #"constant")
    add!(buffer, '$');
  end if;

  buffer := concatenate(buffer, prefix);

  for (non-underline = #f then non-underline | char ~= '_',
       char in name)
    add!(buffer, if (non-underline & char == '_') '-' else char end if);
  end for;

  if (category == #"type" | category == #"type-pointer" | category == #"union" |
      category == #"enum")
    add!(buffer, '>');
  end if;
  as(<byte-string>, buffer);
end method map-name;

define function direction-to-string (direction) => (dir :: <string>)
  select (direction)
    $GI-DIRECTION-IN => "input";
    $GI-DIRECTION-OUT => "output";
    $GI-DIRECTION-INOUT => "input output";
  end select;
end function;

define function map-interface-to-dylan-type (context, typeinfo) => (str :: <string>)
  let interface-info = g-type-info-get-interface(typeinfo);
  let type-tag = g-base-info-get-type(interface-info);
  let repo = g-irepository-get-default();
  let namespace = g-base-info-get-namespace(interface-info);
  let prefix = g-irepository-get-c-prefix(repo, namespace);
  case (type-tag = $GI-INFO-TYPE-CALLBACK)
         => "<C-function-pointer>";
       (type-tag = $GI-INFO-TYPE-BOXED |
        type-tag = $GI-INFO-TYPE-STRUCT)
         => map-name(#"type-pointer", prefix, g-base-info-get-name(interface-info));
       (type-tag = $GI-INFO-TYPE-UNION)
         => map-name(#"union", prefix, g-base-info-get-name(interface-info));
       (type-tag = $GI-INFO-TYPE-ENUM |
        type-tag = $GI-INFO-TYPE-FLAGS)
         => map-name(#"enum", prefix, g-base-info-get-name(interface-info));
       (type-tag = $GI-INFO-TYPE-INTERFACE |
        type-tag = $GI-INFO-TYPE-OBJECT)
         => map-name(#"type-pointer", prefix, g-base-info-get-name(interface-info));
       otherwise
         => "<object> /* <C-XXX-interface> */";
  end case
end function map-interface-to-dylan-type;

define function map-to-dylan-type (context, typeinfo) => (str :: <string>)
  select (g-type-info-get-tag(typeinfo))
    $GI-TYPE-TAG-VOID => if (g-type-info-is-pointer(typeinfo)) "<C-void*>" else "XXX" end if;
    $GI-TYPE-TAG-BOOLEAN => "<C-boolean>";
    $GI-TYPE-TAG-INT8 => "<C-signed-char>";
    $GI-TYPE-TAG-UINT8 => "<C-unsigned-char>";
    $GI-TYPE-TAG-INT16 => "<C-signed-short>";
    $GI-TYPE-TAG-UINT16 => "<C-unsigned-short>";
    $GI-TYPE-TAG-INT32 => "<C-signed-int>";
    $GI-TYPE-TAG-UINT32 => "<C-unsigned-int>";
    $GI-TYPE-TAG-INT64 => "<C-signed-long>";
    $GI-TYPE-TAG-UINT64 => "<C-unsigned-long>";
    $GI-TYPE-TAG-FLOAT => "<C-float>";
    $GI-TYPE-TAG-DOUBLE => "<C-double>";
    $GI-TYPE-TAG-GTYPE => "<C-long>";
    $GI-TYPE-TAG-UTF8 => "<C-string>";
    $GI-TYPE-TAG-FILENAME => "<C-string>";
    $GI-TYPE-TAG-ARRAY => "<object> /* <C-XXX-array> */";
    $GI-TYPE-TAG-INTERFACE => map-interface-to-dylan-type(context, typeinfo);
    $GI-TYPE-TAG-GLIST => "<GList> /* <C-XXX-glist> */";
    $GI-TYPE-TAG-GSLIST => "<GSList> /* <C-XXX-gslist> */";
    $GI-TYPE-TAG-GHASH => "<GHashTable> /* <C-XXX-ghash> */";
    $GI-TYPE-TAG-ERROR => "<object> /* <C-XXX-error> */";
    $GI-TYPE-TAG-UNICHAR => "<object> /* <C-XXX-unichar> */";
  end select
end function;

define function escape-string (input-str :: <string>) => (result :: <string>)
  let buffer = make(<stretchy-vector>);
  add!(buffer, '"');
  for (ch in input-str)
    if (ch = '\\')
      add!(buffer, '\\');
      add!(buffer, '\\');
    else
      add!(buffer, ch);
    end;
  end for;
  add!(buffer, '"');
  as(<byte-string>, buffer)
end function escape-string;

define function convert-gi-argument (argument, type) => (value)
  select (type)
    $GI-TYPE-TAG-VOID => "XXX";
    $GI-TYPE-TAG-BOOLEAN => argument._GIArgument$v-boolean;
    $GI-TYPE-TAG-INT8 => argument._GIArgument$v-int8;
    $GI-TYPE-TAG-UINT8 => argument._GIArgument$v-uint8;
    $GI-TYPE-TAG-INT16 => argument._GIArgument$v-int16;
    $GI-TYPE-TAG-UINT16 => argument._GIArgument$v-uint16;
    $GI-TYPE-TAG-INT32 => argument._GIArgument$v-int32;
    $GI-TYPE-TAG-UINT32 => argument._GIArgument$v-uint32;
    $GI-TYPE-TAG-INT64 => argument._GIArgument$v-int64;
    $GI-TYPE-TAG-UINT64 => argument._GIArgument$v-uint64;
    $GI-TYPE-TAG-FLOAT => argument._GIArgument$v-float;
    $GI-TYPE-TAG-DOUBLE => argument._GIArgument$v-double;
    $GI-TYPE-TAG-GTYPE => "XXX";
    $GI-TYPE-TAG-UTF8 => escape-string(argument._GIArgument$v-string);
    $GI-TYPE-TAG-FILENAME => escape-string(argument._GIArgument$v-string);
    $GI-TYPE-TAG-ARRAY => "XXX";
    $GI-TYPE-TAG-INTERFACE => "XXX";
    $GI-TYPE-TAG-GLIST => "XXX";
    $GI-TYPE-TAG-GSLIST => "XXX";
    $GI-TYPE-TAG-GHASH => "XXX";
    $GI-TYPE-TAG-ERROR => "XXX";
    $GI-TYPE-TAG-UNICHAR => "XXX>";
  end select
end function convert-gi-argument;
