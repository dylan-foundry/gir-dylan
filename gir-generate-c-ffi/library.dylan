module: dylan-user
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define library gir-generate-c-ffi
  use common-dylan;
  use c-ffi;
  use gobject-introspection;
  use command-line-parser;
  use io;

  export gir-generate-c-ffi;
end library;

define module gir-generate-c-ffi
  use common-dylan, exclude: { format-to-string };
  use c-ffi;
  use gobject-introspection;
  use command-line-parser;
  use streams;
  use format;
  use format-out;
  use standard-io;

end module;
