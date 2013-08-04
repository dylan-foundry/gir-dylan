module: dylan-user

define module gobject-glue
  use common-dylan;
  use c-ffi;
  use dylan;
  use finalization;
  use dylan-primitives;
  use dylan-extensions, import: { debug-name, integer-as-raw, raw-as-integer };

  export \with-gdk-lock,
    <GError*>,
    g-signal-connect,
    g-value-nullify,
    g-value-set-value,
    g-value-to-dylan,
    g-value-to-dylan-helper,
    all-subclasses,
    property-setter-definer,
    property-getter-definer;
end module;
