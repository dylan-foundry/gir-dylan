module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define command-line <ggcf-command-line> ()
  option ggcf-version :: <string>,
    kind: <parameter-option>,
    names: #("version"),
    help: "Version of the library to generate bindings for. Defaults to most recent.";

  option ggcf-dependencies :: <boolean>,
    kind: <flag-option>,
    names: #("dependencies"),
    default: #f,
    help: "Generate the bindings for the namespace's dependencies.";

  // XXX: Should add a repeated-option-parameter for the search path.

  option ggcf-namespaces :: <string>,
    names: #("namespaces"),
    kind: <positional-option>,
    repeated?: #t,
    help: "One or more namespaces";

end command-line;

define function parse-args
    (args :: <sequence>)
 => (parser :: <command-line-parser>)
  let parser
    = make(<ggcf-command-line>,
           help: "Generates C-FFI bindings from gobject-introspection data");
  block ()
    parse-command-line(parser, args);
  exception (err :: <abort-command-error>)
    // This condition is signaled by parse-command-line and also if
    // your own code calls abort-command().
    format-err("%s\n", err);
    exit-application(err.exit-status);
  end;
  parser
end;

define function main (arguments :: <sequence>)
  // Older versions of glib require this.
  g-type-init();
  let parser = parse-args(arguments);
  let namespaces = parser.ggcf-namespaces;
  let version = parser.ggcf-version;
  let version
    = if (version)
        as(<C-string>, version)
      else
        null-pointer(<C-string>)
      end;
  let dependencies? = parser.ggcf-dependencies;
  // XXX: Fail nicely if no namespaces.
  // XXX: Fail if they specify a version and more than one namespace.
  for (namespace in namespaces)
    if (load-typelib(namespace, version))
      generate-c-ffi(namespace, version);
      if (dependencies?)
        let dependencies = dependencies-for-namespace(namespace, recursive: #t);
        for (dependency in dependencies)
          let name = head(dependency);
          let version = tail(dependency);
          if (load-typelib(name, version))
            generate-c-ffi(name, version);
          end if;
        end for;
      end if;
    end if;
  end for;
end function;

define function load-typelib
    (namespace :: <string>, version :: <C-string>)
 => (loaded? :: <boolean>)
  let repo = g-irepository-get-default();
  let (typelib, error) = g-irepository-require(repo, namespace, version, 0);
  if (~null-pointer?(error) | null-pointer?(typelib))
    if (null-pointer?(version))
      format(*standard-error*, "No versions of %s are available.\n", namespace);
    else
      format(*standard-error*, "Version %s of %s is not available.\n", version, namespace);
    end if;
    force-output(*standard-error*);
    #f
  else
    #t
  end if
end function;

main(application-arguments());
