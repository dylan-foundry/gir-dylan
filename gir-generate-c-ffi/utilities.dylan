module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

/* Some of this is borrowed from code in melange */
define method get-type-name
    (category :: <symbol>, type-info)
 => (result :: <string>)
  // Prepare some information ...
  let repo = g-irepository-get-default();
  let namespace = g-base-info-get-namespace(type-info);
  let prefix = g-irepository-get-c-prefix(repo, namespace);
  let name = g-base-info-get-name(type-info);

  let buffer = make(<stretchy-vector>);

  add!(buffer, '<');

  if ((category == #"type") |
      (category == #"union"))
    add!(buffer, '_');
  end if;

  buffer := concatenate(buffer, prefix);

  for (non-underline = #f then non-underline | char ~= '_',
       char in name)
    add!(buffer, if (non-underline & char == '_') '-' else char end if);
  end for;

  if ((category == #"type-pointer-pointer") |
      (category == #"enum-pointer"))
    add!(buffer, '*');
  end if;
  add!(buffer, '>');

  as(<byte-string>, buffer);
end method get-type-name;

/* Some of this is borrowed from code in melange */
define function dylanize (name :: <string>) => (dylan-name :: <string>)
  let buffer = make(<stretchy-vector>);

  for (non-underline = #f then non-underline | char ~= '_',
       char in name)
    add!(buffer, if (non-underline & char == '_') '-' else char end if);
  end for;

  as(<byte-string>, buffer);
end function dylanize;

define function direction-to-string (direction) => (dir :: <string>)
  select (direction)
    $GI-DIRECTION-IN => "input";
    $GI-DIRECTION-OUT => "output";
    $GI-DIRECTION-INOUT => "input output";
  end select;
end function;

define function map-interface-to-dylan-type
    (context, type-info, #key direction = "input")
 => (str :: <string>)
  let interface-info = g-type-info-get-interface(type-info);
  let type-tag = g-base-info-get-type(interface-info);
  case (type-tag = $GI-INFO-TYPE-CALLBACK)
         => "<C-function-pointer>";
       (type-tag = $GI-INFO-TYPE-BOXED |
        type-tag = $GI-INFO-TYPE-STRUCT)
         => get-type-name(#"type-pointer", interface-info);
       (type-tag = $GI-INFO-TYPE-UNION)
         => if (g-type-info-is-pointer(type-info))
              get-type-name(#"union-pointer", interface-info);
            else
              get-type-name(#"union", interface-info);
            end if;
       (type-tag = $GI-INFO-TYPE-ENUM |
        type-tag = $GI-INFO-TYPE-FLAGS)
         => if (direction ~= "input")
              get-type-name(#"enum-pointer", interface-info);
            else
              get-type-name(#"enum", interface-info);
            end if;
       (type-tag = $GI-INFO-TYPE-INTERFACE |
        type-tag = $GI-INFO-TYPE-OBJECT)
       => if (direction ~= "input")
            get-type-name(#"type-pointer-pointer", interface-info);
          else
            get-type-name(#"type-pointer", interface-info);
          end if;
       otherwise
         => "<object> /* <C-XXX-interface> */";
  end case
end function map-interface-to-dylan-type;

define function map-array-to-dylan-type (context, type-info) => (str :: <string>)
  let array-type = g-type-info-get-array-type(type-info);
  let param-type-info = g-type-info-get-param-type(type-info, 0);
  let param-type-tag = g-type-info-get-tag(param-type-info);
  if (array-type = $GI-ARRAY-TYPE-C)
    select (param-type-tag)
      // This should never happen, and if it happens it won't work.
      $GI-TYPE-TAG-VOID => if (g-type-info-is-pointer(param-type-info)) "<C-void*>" else "XXX" end if;
      $GI-TYPE-TAG-BOOLEAN => "<C-int*>"; // gboolean is defined as int
      $GI-TYPE-TAG-INT8 => "<C-signed-char*>";
      $GI-TYPE-TAG-UINT8 => "<C-unsigned-char*>";
      $GI-TYPE-TAG-INT16 => "<C-signed-short*>";
      $GI-TYPE-TAG-UINT16 => "<C-unsigned-short*>";
      $GI-TYPE-TAG-INT32 => "<C-signed-int*>";
      $GI-TYPE-TAG-UINT32 => "<C-unsigned-int*>";
      $GI-TYPE-TAG-INT64 => "<C-signed-long*>";
      $GI-TYPE-TAG-UINT64 => "<C-unsigned-long*>";
      $GI-TYPE-TAG-FLOAT => "<C-float*>";
      $GI-TYPE-TAG-DOUBLE => "<C-double*>";
      $GI-TYPE-TAG-GTYPE => "<C-long*>";
      $GI-TYPE-TAG-UTF8 => "<C-string*>";
      $GI-TYPE-TAG-FILENAME => "<C-string*>";
      // map this parameters to unsigned char so we can compile
      $GI-TYPE-TAG-ARRAY => "<C-unsigned-char*> /* Not supported */";
      $GI-TYPE-TAG-INTERFACE => "<C-unsigned-char*> /* Not supported */";
      $GI-TYPE-TAG-GLIST => "<GList>";
      $GI-TYPE-TAG-GSLIST => "<GSList>";
      $GI-TYPE-TAG-GHASH => "<GHashTable>";
      $GI-TYPE-TAG-ERROR => "<GError>";
      $GI-TYPE-TAG-UNICHAR => "<C-unsigned-int*>";
    end select;
  elseif (array-type = $GI-ARRAY-TYPE-ARRAY)
    // Not sure about this
    "<GArray>";
  elseif (array-type = $GI-ARRAY-TYPE-PTR-ARRAY)
    // Not sure about this
    "<GPtrArray>";
  elseif (array-type = $GI-ARRAY-TYPE-BYTE-ARRAY)
    // Not sure about this
    "<GByteArray>";
  else
    // Unknown ...
    "<C-void*>";
  end if
end function map-array-to-dylan-type;

define function map-to-dylan-type
    (context, type-info, #key direction = "input")
 => (str :: <string>)
  // Some output parameters are not marked as pointers even if they are
  let is-pointer? = g-type-info-is-pointer(type-info) | direction ~= "input";
  select (g-type-info-get-tag(type-info))
    $GI-TYPE-TAG-VOID
      => if (is-pointer?)
           if (direction ~= "input")
             "<C-void**>";
           else
             "<C-void*>";
           end if;
         else
           "XXX"
         end if;
    $GI-TYPE-TAG-BOOLEAN
      => if (is-pointer?)"<C-int*>" else "<C-boolean>" end if;
    $GI-TYPE-TAG-INT8
      => if (is-pointer?) "<C-signed-char*>" else "<C-signed-char>" end if;
    $GI-TYPE-TAG-UINT8
      => if (is-pointer?) "<C-unsigned-char*>" else "<C-unsigned-char>" end if;
    $GI-TYPE-TAG-INT16
      => if (is-pointer?) "<C-signed-short*>" else "<C-signed-short>" end if;
    $GI-TYPE-TAG-UINT16
      => if (is-pointer?) "<C-unsigned-short*>" else "<C-unsigned-short>" end if;
    $GI-TYPE-TAG-INT32
      => if (is-pointer?) "<C-signed-int*>" else "<C-signed-int>" end if;
    $GI-TYPE-TAG-UINT32
      => if (is-pointer?) "<C-unsigned-int*>" else "<C-unsigned-int>" end if;
    $GI-TYPE-TAG-INT64
      => if (is-pointer?) "<C-signed-long*>" else "<C-signed-long>" end if;
    $GI-TYPE-TAG-UINT64
      => if (is-pointer?) "<C-unsigned-long*>" else "<C-unsigned-long>" end if;
    $GI-TYPE-TAG-FLOAT
      => if (is-pointer?) "<C-float*>" else "<C-float>" end if;
    $GI-TYPE-TAG-DOUBLE
      => if (is-pointer?) "<C-double*>" else "<C-double>" end if;
    $GI-TYPE-TAG-GTYPE
      => if (is-pointer?) "<C-long*>" else "<C-long>" end if;
    $GI-TYPE-TAG-UTF8
      => "<C-string>";
    $GI-TYPE-TAG-FILENAME
      => "<C-string>";
    $GI-TYPE-TAG-ARRAY
      => map-array-to-dylan-type(context, type-info);
    $GI-TYPE-TAG-INTERFACE
      => map-interface-to-dylan-type(context, type-info, direction: direction);
    $GI-TYPE-TAG-GLIST
      => "<GList>";
    $GI-TYPE-TAG-GSLIST
      => "<GSList>";
    $GI-TYPE-TAG-GHASH
      => "<GHashTable>";
    $GI-TYPE-TAG-ERROR
      => "<GError>";
    $GI-TYPE-TAG-UNICHAR
      => if (is-pointer?) "<C-unsigned-int*>" else "<C-unsigned-int>" end if;
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
