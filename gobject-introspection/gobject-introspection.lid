library: gobject-introspection
executable: gir-dylan
target-type: dll
files: library
       gibaseinfo
       girepository
       gitypelib
       gobject-introspection
c-libraries: -lgirepository-1.0
             -lgobject-2.0
             -lgmodule-2.0
             -lgthread-2.0
             -lglib-2.0
