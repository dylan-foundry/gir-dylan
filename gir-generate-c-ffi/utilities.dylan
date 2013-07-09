module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

/* This is borrowed from code in melange */
define method map-name
    (category :: <symbol>, prefix :: <string>, name :: <string>,
     sequence-of-classes :: <sequence>)
 => (result :: <string>);
  let buffer = make(<stretchy-vector>);

  if (category == #"type")
    add!(buffer, '<')
  elseif (category == #"constant")
    add!(buffer, '$');
  end if;

  buffer := concatenate(buffer, prefix);
  for (cls in sequence-of-classes)
    buffer := concatenate(buffer, copy-sequence(cls, start: 1));
    add!(buffer, '-');
  end for;

  for (non-underline = #f then non-underline | char ~= '_',
       char in name)
    add!(buffer, if (non-underline & char == '_') '-' else char end if);
  end for;

  if (category == #"type") add!(buffer, '>') end if;
  as(<byte-string>, buffer);
end method map-name;

define function direction-to-string (direction) => (dir :: <string>)
  select (direction)
    $GI-DIRECTION-IN => "input";
    $GI-DIRECTION-OUT => "output";
    $GI-DIRECTION-INOUT => "input output";
  end select;
end function;

define function map-to-dylan-type (typeinfo) => (str :: <string>)
  select (g-type-info-get-tag(typeinfo))
    $GI-TYPE-TAG-VOID => "<C-void>";
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
    $GI-TYPE-TAG-GTYPE => "<C-XXX-gtype>";
    $GI-TYPE-TAG-UTF8 => "<C-string>";
    $GI-TYPE-TAG-FILENAME => "<C-string>";
    $GI-TYPE-TAG-ARRAY => "<C-XXX-array>";
    $GI-TYPE-TAG-INTERFACE => "<C-XXX-interface>";
    $GI-TYPE-TAG-GLIST => "<C-XXX-glist>";
    $GI-TYPE-TAG-GSLIST => "<C-XXX-gslist>";
    $GI-TYPE-TAG-GHASH => "<C-XXX-ghash>";
    $GI-TYPE-TAG-ERROR => "<C-XXX-error>";
    $GI-TYPE-TAG-UNICHAR => "<C-XXX-unichar>";
  end select
end function;
