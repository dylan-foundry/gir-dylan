module: dylan-user
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define library gobject-glue
  use common-dylan;
  use c-ffi;

  export gobject-glue;
end library;

define module gobject-glue
  use common-dylan;
  use c-ffi;

  export \with-gdk-lock,
    property-setter-definer,
    property-getter-definer;
end module;
