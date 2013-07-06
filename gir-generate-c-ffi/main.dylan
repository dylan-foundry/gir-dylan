module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define function main (arguments :: <sequence>)
  // XXX: Check arguments, we want to be able to
  // add to the search path, list the search
  // path, get help, and say what namespace
  // and version to load and generate bindings
  // for.
  // But for now:
  let namespace = "GLib";
  let version = "2.0";
  load-typelib(namespace, version);
  generate-c-ffi(namespace, version);
end function;

define function load-typelib
    (namespace :: <string>, version :: <string>)
 => ()
  let repo = g-irepository-get-default();
  let (typelib, error) = g-irepository-require(repo, namespace, version, 0);
  if (~null-pointer?(error) | null-pointer?(typelib))
    // XXX: signal an error
  end if;
end function;

main(application-arguments());
