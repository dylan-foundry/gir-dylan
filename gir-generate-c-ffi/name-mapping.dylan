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