module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define class <context> (<object>)
  slot exported-bindings = #();
  constant slot exported-bindings-index = make(<set>);
  constant slot output-stream :: <stream>,
    required-init-keyword: stream:;
  constant slot prefix, required-init-keyword: prefix:;
end class;

define function add-exported-binding
    (context :: <context>, binding-name :: <string>)
 => ()
  context.exported-bindings := add(context.exported-bindings, binding-name);
  add!(context.exported-bindings-index, as(<symbol>, lowercase(binding-name)));
end function;

define function binding-already-exported?
    (context :: <context>, binding-name :: <string>)
 => (exported? :: <boolean>)
  member?(as(<symbol>, lowercase(binding-name)),
          context.exported-bindings-index)
end function binding-already-exported?;

define function make-target-path (project-dir, #rest args) => (target)
  merge-locators(as(<file-locator>, apply(concatenate, args)),
                 project-dir);
end function;

define function make-project-name
    (workspace :: <string>, version :: <string>,
     #key include-dylan = #f)
 => (name :: <string>)
  if (include-dylan)
    concatenate(lowercase(workspace), "-dylan")
  else
    lowercase(workspace)
  end if
end function;

define function generate-c-ffi
    (namespace :: <string>, version :: <string>)
 => ()
  let project-dir = generate-directory(namespace, version);
  let (exported-bindings, dependencies)
    = generate-dylan-file(project-dir, namespace, version);
  generate-library-file(project-dir,
                        namespace,
                        version,
                        exported-bindings,
                        dependencies);
  generate-lid-file(project-dir, namespace, version);
  generate-jam-file(project-dir, namespace);
end function;

define function generate-directory
    (namespace :: <string>, version :: <string>)
 => (project-dir :: <directory-locator>)
  let project-dir = subdirectory-locator(working-directory(),
                                         make-project-name(namespace, version, include-dylan: #t));
  ensure-directories-exist(project-dir);
  project-dir
end function;

define function generate-dylan-file
    (project-dir :: <directory-locator>,
     namespace :: <string>,
     version :: <string>)
 => (exported-bindings :: <sequence>, dependencies :: <sequence>)
  let project-name = make-project-name(namespace, version);
  let target-path = make-target-path(project-dir, project-name, ".dylan");
  with-open-file (stream = target-path, direction: #"output",
                  if-does-not-exist: #"create")
    format(stream, "module: %s\n", lowercase(namespace));
    format(stream, "synopsis: generated bindings for the %s library\n", namespace);
    format(stream, "copyright: See LICENSE file in this distribution.\n\n");
    let repo = g-irepository-get-default();

    let dependencies-c-array = g-irepository-get-dependencies(repo, namespace);
    let dependencies = #[];
    if (~null-pointer?(dependencies-c-array))
      block (exit)
        for (i from 0)
          let dependency = element(dependencies-c-array, i);
          if (null-pointer?(dependency)) exit() end if;
          dependencies := add(dependencies, dependency);
          format(*standard-error*, "Detected dependency: %s\n", dependency);
          force-output(*standard-error*);
        end for;
      end block;
    end if;

    let prefix = g-irepository-get-c-prefix(repo, namespace);
    let context = make(<context>, stream: stream, prefix: prefix);
    let count = g-irepository-get-n-infos(repo, namespace);
    for (i from 0 below count)
      let info = g-irepository-get-info(repo, namespace, i);
      if (~g-base-info-is-deprecated(info))
        let type = g-base-info-get-type(info);
        write-c-ffi(context, info, type);
        force-output(context.output-stream);
      end if;
    end for;
    values(context.exported-bindings, dependencies)
  end with-open-file
end function;

define function library-name-from-dependency
    (dependency :: <string>)
 => (library-name :: <string>)
  let library-name = make(<stretchy-vector>);
  // The library name is the first part of the string, before the '-'
  block (exit)
    for (ch in dependency)
      if (ch = '-') exit() end if;
      add!(library-name, ch);
    end for;
  end block;
  lowercase(as(<byte-string>, library-name))
end function library-name-from-dependency;

define function generate-library-file
    (project-dir :: <directory-locator>,
     namespace :: <string>,
     version :: <string>,
     exported-bindings :: <sequence>,
     dependencies :: <sequence>)
 => ()
  let target-path = make-target-path(project-dir, "library.dylan");
  with-open-file (stream = target-path, direction: #"output",
                  if-does-not-exist: #"create")
    let lower-namespace = lowercase(namespace);
    format(stream, "module: dylan-user\n");
    format(stream, "copyright: See LICENSE file in this distribution.\n");
    format(stream, "\n");
    format(stream, "define library %s\n", lower-namespace);
    format(stream, "  use dylan;\n");
    format(stream, "  use common-dylan;\n");
    format(stream, "  use c-ffi;\n");
    for (dependency in dependencies)
      format(stream, "  use %s;\n", library-name-from-dependency(dependency));
    end for;
    format(stream, "\n");
    format(stream, "  export %s;\n", lower-namespace);
    format(stream, "end library;\n");
    format(stream, "\n");
    format(stream, "define module %s\n", lower-namespace);
    format(stream, "  use dylan;\n");
    format(stream, "  use common-dylan;\n");
    format(stream, "  use c-ffi;\n");
    for (dependency in dependencies)
      format(stream, "  use %s;\n", library-name-from-dependency(dependency));
    end for;
    format(stream, "\n");
    format(stream, "  export");
    for (binding in exported-bindings,
         first? = #t then #f)
      if (~first?) format(stream, ","); end if;
      format(stream, "\n    %s", binding);
    finally
      format(stream, ";\n");
    end for;
    format(stream, "end module;\n");
  end with-open-file;
end function;

define function generate-lid-file
    (project-dir :: <directory-locator>,
     namespace :: <string>,
     version :: <string>)
 => ()
  let project-name = make-project-name(namespace, version, include-dylan: #t);
  let target-path = make-target-path(project-dir, project-name, ".lid");
  with-open-file (stream = target-path, direction: #"output",
                  if-does-not-exist: #"create")
    let lower-namespace = lowercase(namespace);
    format(stream, "library: %s\n", lower-namespace);
    format(stream, "target-type: dll\n");
    format(stream, "executable: %s\n", project-name);
    format(stream, "files: library\n");
    format(stream, "       %s\n", lower-namespace);
    format(stream, "jam-includes: %s.jam\n", project-name);
    // XXX: Need to output C-libraries here.
  end with-open-file;
end function;

define function  generate-jam-file
    (project-dir :: <directory-locator>,
     namespace :: <string>)
 => ()
  let repo = g-irepository-get-default();
  let version = g-irepository-get-version(repo, namespace);
  let project-name = make-project-name(namespace, version, include-dylan: #t);
  let target-path = make-target-path(project-dir, project-name, ".jam");
  with-open-file (stream = target-path, direction: #"output",
                  if-does-not-exist: #"create")
    let lower-namespace = lowercase(namespace);

    // Handle gtk namespace being different from the pkg-config name
    if (lower-namespace = "gtk")
      lower-namespace := "gtk+";
    end if;

    format(stream, "LINKLIBS += `pkg-config --libs %s-%s` ;\n",
           lower-namespace,
           version);
    format(stream, "CCFLAGS += `pkg-config --cflags %s-%s` ;\n",
           lower-namespace,
           version);
  end with-open-file;
end function generate-jam-file;

define function name-for-type (type) => (name :: <string>)
  select (type)
    $GI-INFO-TYPE-ARG => "arg";
    $GI-INFO-TYPE-BOXED => "boxed";
    $GI-INFO-TYPE-CALLBACK => "callback";
    $GI-INFO-TYPE-CONSTANT => "constant";
    $GI-INFO-TYPE-ENUM => "enum";
    $GI-INFO-TYPE-FIELD => "field";
    $GI-INFO-TYPE-FLAGS => "flags";
    $GI-INFO-TYPE-FUNCTION => "function";
    $GI-INFO-TYPE-INTERFACE => "interface";
    $GI-INFO-TYPE-INVALID => "invalid";
    $GI-INFO-TYPE-INVALID-0 => "invalid-0";
    $GI-INFO-TYPE-OBJECT => "object";
    $GI-INFO-TYPE-PROPERTY => "property";
    $GI-INFO-TYPE-SIGNAL => "signal";
    $GI-INFO-TYPE-STRUCT => "struct";
    $GI-INFO-TYPE-TYPE => "type";
    $GI-INFO-TYPE-UNION => "union";
    $GI-INFO-TYPE-UNRESOLVED => "unresolved";
    $GI-INFO-TYPE-VALUE => "value";
    $GI-INFO-TYPE-VFUNC => "vfunc";
    otherwise => "Unknown type";
  end select
end function;

define method write-c-ffi (context, info, type)
 => ()
  let name = g-base-info-get-name(info);
  let type-name = name-for-type(type);
  format(context.output-stream, "// Not set up yet for %s %s\n\n", type-name, name);
end method;

define method write-c-ffi (context, boxed-info, type == $GI-INFO-TYPE-BOXED)
 => ()
  // This is the same as a struct
  write-c-ffi(context, boxed-info, $GI-INFO-TYPE-STRUCT);
end method;

define method write-c-ffi (context, callback-info, type == $GI-INFO-TYPE-CALLBACK)
 => ()
  // We don't need to do anything for a callback. I think.
end method;

define method write-c-ffi (context, constant-info, type == $GI-INFO-TYPE-CONSTANT)
 => ()
  let name = g-base-info-get-name(constant-info);
  let dylan-name = map-name(#"constant", "", name);
  if (~binding-already-exported?(context, dylan-name))
    add-exported-binding(context, dylan-name);
    let arg = make(<GIArgument>);
    let type = g-constant-info-get-type(constant-info);
    let type-tag = g-type-info-get-tag(type);
    g-constant-info-get-value(constant-info, arg);
    let value = convert-gi-argument(arg, type-tag);
    format(context.output-stream, "define constant %s = %s;\n\n", dylan-name, value);
  end if;
end method;

define method write-c-ffi (context, enum-info, type == $GI-INFO-TYPE-ENUM)
 => ()
  let value-names = write-c-ffi-values(context, enum-info);
  let enum-name  = g-base-info-get-name(enum-info);
  let dylan-enum-name = map-name(#"enum", context.prefix, enum-name);
  if (~binding-already-exported?(context, dylan-enum-name))
    add-exported-binding(context, dylan-enum-name);
    // We use <C-int> rather than one-of because one-of isn't a C-FFI designator class
    format(context.output-stream, "define constant %s = <C-int>;\n\n", dylan-enum-name);
  end if;
end method;

define method write-c-ffi (context, flags-info, type == $GI-INFO-TYPE-FLAGS)
 => ()
  write-c-ffi-values(context, flags-info);
  let flags-name  = g-base-info-get-name(flags-info);
  let dylan-flags-name = map-name(#"enum", context.prefix, flags-name);
  add-exported-binding(context, dylan-flags-name);
  format(context.output-stream, "define constant %s = <C-int>;\n\n", dylan-flags-name);
end method;

define method write-c-ffi (context, function-info, type == $GI-INFO-TYPE-FUNCTION)
 => ()
  write-c-ffi-function(context, function-info, #f);
end method;

define method write-c-ffi (context, interface-info, type == $GI-INFO-TYPE-INTERFACE)
 => ()
  let name = g-base-info-get-name(interface-info);
  let dylan-name = map-name(#"type", context.prefix, name);
  let dylan-pointer-name = map-name(#"type-pointer", context.prefix, name);
  if (~binding-already-exported?(context, dylan-pointer-name))
    let num-prerequisites = g-interface-info-get-n-prerequisites(interface-info);
    format(context.output-stream, "// Interface\n");
    if (num-prerequisites = 0)
      format(context.output-stream, "define C-struct %s\n", dylan-name);
      format(context.output-stream, "  pointer-type-name: %s;\n", dylan-pointer-name);
      format(context.output-stream, "end C-struct;\n\n");
    else
      let prerequisites-name = #[];
      for (i from 0 below num-prerequisites)
        let prerequisite = g-interface-info-get-prerequisite(interface-info, i);
        let prerequisite-name = g-base-info-get-name(prerequisite);
        let prerequisite-dylan-name = map-name(#"type", context.prefix, prerequisite-name);
        prerequisites-name := add!(prerequisites-name, prerequisite-dylan-name);
      end for;
      let joined-names = join(prerequisites-name, ", ");
      format(context.output-stream, "define C-subtype %s (%s)\n", dylan-name, joined-names);
      format(context.output-stream, "  pointer-type-name: %s;\n", dylan-pointer-name);
      format(context.output-stream, "end C-subtype;\n\n");
    end;

    let num-methods = g-interface-info-get-n-methods(interface-info);
    for (i from 0 below num-methods)
      let function-info = g-interface-info-get-method(interface-info, i);
      write-c-ffi-function(context, function-info, dylan-pointer-name);
    end for;
  end if;
end method;

define method write-c-ffi (context, object-info, type == $GI-INFO-TYPE-OBJECT)
 => ()
  let name = g-base-info-get-name(object-info);
  let dylan-name = map-name(#"type", context.prefix, name);
  let dylan-pointer-name = map-name(#"type-pointer", context.prefix, name);
  if (~binding-already-exported?(context, dylan-pointer-name))
    add-exported-binding(context, dylan-pointer-name);

    let parent-info = g-object-info-get-parent(object-info);
    let c-definer = "subtype";
    if (null-pointer?(parent-info))
      // This is the root object
      format(context.output-stream, "define C-struct %s\n", dylan-name);
      c-definer := "struct";
    else
      let parent-name = g-base-info-get-name(parent-info);
      let parent-dylan-name = map-name(#"type", context.prefix, parent-name);
      format(context.output-stream, "define C-subtype %s (%s)\n", dylan-name, parent-dylan-name);
      g-base-info-unref(parent-info);
    end if;

    let num-fields = g-object-info-get-n-fields(object-info);
    for (i from 0 below num-fields)
      let field = g-object-info-get-field(object-info, i);
      write-c-ffi-field(context, field, name);
    end for;
    format(context.output-stream, "  pointer-type-name: %s;\n", dylan-pointer-name);
    format(context.output-stream, "end C-%s;\n\n", c-definer);
    let num-methods = g-object-info-get-n-methods(object-info);
    for (i from 0 below num-methods)
      let function-info = g-object-info-get-method(object-info, i);
      write-c-ffi-function(context, function-info, dylan-pointer-name);
    end for;
  end if;
end method;

define method write-c-ffi (context, struct-info, type == $GI-INFO-TYPE-STRUCT)
 => ()
  let name = g-base-info-get-name(struct-info);
  let dylan-name = map-name(#"type", context.prefix, name);
  let dylan-pointer-name = map-name(#"type-pointer", context.prefix, name);
  if (~binding-already-exported?(context, dylan-pointer-name))
    add-exported-binding(context, dylan-pointer-name);
    format(context.output-stream, "define C-struct %s\n", dylan-name);
    let num-fields = g-struct-info-get-n-fields(struct-info);
    for (i from 0 below num-fields)
      let field = g-struct-info-get-field(struct-info, i);
      write-c-ffi-field(context, field, name);
    end for;
    format(context.output-stream, "  pointer-type-name: %s;\n", dylan-pointer-name);
    format(context.output-stream, "end C-struct;\n\n");
    let num-methods = g-struct-info-get-n-methods(struct-info);
    for (i from 0 below num-methods)
      let function-info = g-struct-info-get-method(struct-info, i);
      write-c-ffi-function(context, function-info, dylan-pointer-name);
    end for;
  end if;
end method;

define method write-c-ffi (context, union-info, type == $GI-INFO-TYPE-UNION)
 => ()
  let name = g-base-info-get-name(union-info);
  let dylan-name = map-name(#"union", context.prefix, name);
  let dylan-pointer-name = map-name(#"union-pointer", context.prefix, name);
  if (~binding-already-exported?(context, dylan-name))
    add-exported-binding(context, dylan-name);
    add-exported-binding(context, dylan-pointer-name);
    format(context.output-stream, "define C-union %s\n", dylan-name);
    let num-fields = g-union-info-get-n-fields(union-info);
    for (i from 0 below num-fields)
      let field = g-union-info-get-field(union-info, i);
      write-c-ffi-field(context, field, name);
    end for;
    format(context.output-stream, "  pointer-type-name: %s;\n", dylan-pointer-name);
    format(context.output-stream, "end C-union;\n\n");
    let num-methods = g-union-info-get-n-methods(union-info);
    for (i from 0 below num-methods)
      let function-info = g-union-info-get-method(union-info, i);
      write-c-ffi-function(context, function-info, dylan-pointer-name);
    end for;
  end if;
end method;

define function field-is-writable? (field) => (writable? :: <boolean>)
  let field-flags = g-field-info-get-flags(field);
  logand(field-flags, $GI-FIELD-IS-WRITABLE) ~= 0
end function field-is-writable?;

define function field-is-readable? (field) => (readable? :: <boolean>)
  let field-flags = g-field-info-get-flags(field);
  logand(field-flags, $GI-FIELD-IS-READABLE) ~= 0
end function field-is-readable?;

define function write-c-ffi-field (context, field, container-name) => ()
  let prefix = lowercase(concatenate(context.prefix, container-name, "-"));
  let field-name = map-name(#"field", prefix, g-base-info-get-name(field));
  let field-type = map-to-dylan-type(context, g-field-info-get-type(field));
  let writable? = field-is-writable?(field);
  let readable? = field-is-readable?(field);
  // XXX: Consider prefixing the name with the struct name.
  if (readable?)
    add-exported-binding(context, field-name);
  end;
  if (writable?)
    let setter-name = concatenate(field-name, "-setter");
    add-exported-binding(context, setter-name);
  end;

  format(context.output-stream, "  %sslot %s :: %s;\n",
         if (writable?) "" else "constant " end if,
         field-name,
         field-type);
end function;

define function write-c-ffi-function (context, function-info, container-name) => ()
  let symbol = g-function-info-get-symbol(function-info);
  let dylan-name = map-name(#"function", "", symbol);
  if (~binding-already-exported?(context, dylan-name))
    add-exported-binding(context, dylan-name);
    format(context.output-stream, "define C-function %s\n", dylan-name);
    if (logand(g-function-info-get-flags(function-info), $GI-FUNCTION-IS-METHOD) ~= 0)
      format(context.output-stream, "  input parameter self :: %s;\n", container-name);
    end if;
    let num-args = g-callable-info-get-n-args(function-info);
    for (i from 0 below num-args)
      let arg = g-callable-info-get-arg(function-info, i);
      let arg-name = g-base-info-get-name(arg);
      let arg-type = map-to-dylan-type(context, g-arg-info-get-type(arg));
      if (g-arg-info-is-return-value(arg))
        // XXX: We don't handle this. When does this happen?
      else
        let direction = direction-to-string(g-arg-info-get-direction(arg));
        format(context.output-stream, "  %s parameter %s_ :: %s;\n", direction, arg-name, arg-type);
      end if;
      g-base-info-unref(arg);
    end for;
    let result-type = g-callable-info-get-return-type(function-info);
    if ((g-type-info-get-tag(result-type) ~= $GI-TYPE-TAG-VOID) & ~g-type-info-is-pointer(result-type))
      let dylan-result-type = map-to-dylan-type(context, result-type);
      format(context.output-stream, "  result res :: %s;\n", dylan-result-type);
    end if;
    let symbol = g-function-info-get-symbol(function-info);
    format(context.output-stream, "  c-name: \"%s\";\n", symbol);
    format(context.output-stream, "end;\n\n");
  end if;
end function;

define function write-c-ffi-values (context, info) => (value-names :: <sequence>)
  let value-names = #[];
  let num-values = g-enum-info-get-n-values(info);
  for (i from 0 below num-values)
    let value = g-enum-info-get-value(info, i);
    let name = g-base-info-get-attribute(value, "c:identifier");
    let dylan-name = map-name(#"constant", "", name);
    if (~binding-already-exported?(context, dylan-name))
      add-exported-binding(context, dylan-name);
      value-names := add!(value-names, dylan-name);
      let integer-value = g-value-info-get-value(value);
      format(context.output-stream, "define constant %s :: <integer> = %d;\n", dylan-name, integer-value);
    end if;
    g-base-info-unref(value);
  end for;
  value-names
end function write-c-ffi-values;
