module: dylan-user
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define library gobject-introspection-test-suite
  use common-dylan;
  use io;
  use gobject-introspection;
  use testworks;

  export gobject-introspection-test-suite;
end library;

define module gobject-introspection-test-suite
  use common-dylan, exclude: { format-to-string };
  use format;
  use gobject-introspection;
  use streams, import: { <buffer> };
  use testworks;

  export gobject-introspection-test-suite;
end module;
