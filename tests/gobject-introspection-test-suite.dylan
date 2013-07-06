module: gobject-introspection-test-suite
synopsis: Test suite for the gobject-introspection library.
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define constant $glib-namespace = "GLib";
define constant $invalid-namespace = "InvalidNamespaceNameXXX";

define suite gobject-introspection-test-suite ()
  test inglib-namespace-yields-error;
  test inglib-namespace-is-not-registered;
  test can-load-glib;
end suite;

define test inglib-namespace-yields-error ()
  let repo = g-irepository-get-default();
  let (typelib, error) = g-irepository-require(repo, $invalid-namespace, "2.0", 0);
  check-true("typelib should be null", null-pointer?(typelib));
  check-false("error should not be null", null-pointer?(error));
end test;

define test inglib-namespace-is-not-registered ()
  let repo = g-irepository-get-default();
  check-false("Is registered?", g-irepository-is-registered(repo, $invalid-namespace, "283832.0"));
end test;

define test can-load-glib ()
  let repo = g-irepository-get-default();
  let (typelib, error) = g-irepository-require(repo, $glib-namespace, "2.0", 0);
  check-false("typelib is not null", null-pointer?(typelib));
  check-true("error is null", null-pointer?(error));
  check-equal("typelib has expected name", g-typelib-get-namespace(typelib), $glib-namespace);
  check-true("namespace is registered", g-irepository-is-registered(repo, $glib-namespace, "2.0"));
  check-true("namespace has info", g-irepository-get-n-infos(repo, $glib-namespace) > 0);
end test;
