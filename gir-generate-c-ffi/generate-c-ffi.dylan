module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define function generate-c-ffi
    (namespace :: <string>, version :: <string>)
 => ()
  let repo = g-irepository-get-default();
  let count = g-irepository-get-n-infos(repo, namespace);
  for (i from 0 below count)
    let info = g-irepository-get-info(repo, namespace, i);
    format-out("%d -> %s\n", i, g-base-info-get-name(info));
    force-output(*standard-output*);
  end for;
end function;
