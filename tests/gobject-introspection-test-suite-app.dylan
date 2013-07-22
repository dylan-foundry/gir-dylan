module: gobject-introspection-test-suite-app
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

// This is required on some older versions of GLib.
g-type-init();

run-test-application(gobject-introspection-test-suite);
