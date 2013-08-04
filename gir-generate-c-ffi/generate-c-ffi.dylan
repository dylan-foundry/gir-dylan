module: gir-generate-c-ffi
synopsis: generate c-ffi bindings using gobject-introspection
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define class <context> (<object>)
  slot exported-bindings = #();
  constant slot exported-bindings-index = make(<set>);
  slot properties = #();
  constant slot output-stream :: <stream>,
    required-init-keyword: stream:;
end class;

define class <property> (<object>)
  constant slot property-name :: <string>,
    init-keyword: name:;
  constant slot property-type :: <string>,
    init-keyword: type:;
  constant slot property-class :: <string>,
    init-keyword: class:;
end class;

define class <property-getter> (<property>) end;
define class <property-setter> (<property>) end;

define method \= (p1 :: <property>, p2 :: <property>) => (equal? :: <boolean>)
  property-method-name(p1) = property-method-name(p2)
end method \=;

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

define function add-property
    (context :: <context>, property :: <property>)
 => ()
  context.properties := add(context.properties, property);
end function add-property;

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
  let (context, dependencies)
    = generate-dylan-file(project-dir, namespace, version);
  generate-properties-file(project-dir, namespace, context.properties);
  generate-library-file(project-dir,
                        namespace,
                        version,
                        context.exported-bindings,
                        context.properties,
                        dependencies);
  generate-lid-file(project-dir, namespace, version,
                    properties?: ~empty?(context.properties));
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
 => (context :: <context>, dependencies :: <sequence>)
  let project-name = make-project-name(namespace, version);
  let target-path = make-target-path(project-dir, project-name, ".dylan");
  with-open-file (stream = target-path, direction: #"output",
                  if-does-not-exist: #"create")
    format(stream, "module: %s\n", lowercase(namespace));
    format(stream, "synopsis: generated bindings for the %s library\n", namespace);
    format(stream, "copyright: See LICENSE file in this distribution.\n\n");
    let repo = g-irepository-get-default();

    let dependencies = dependencies-for-namespace(namespace, recursive: #t);

    format(stream, "\ndefine C-pointer-type <C-void**> => <C-void*>;\n");
    format(stream, "ignore(<C-void**>);\n\n");

    let context = make(<context>, stream: stream);
    let count = g-irepository-get-n-infos(repo, namespace);
    for (i from 0 below count)
      let info = g-irepository-get-info(repo, namespace, i);
      if (~g-base-info-is-deprecated(info))
        let type = g-base-info-get-type(info);
        write-c-ffi(context, info, type);
        force-output(context.output-stream);
      end if;
    end for;
    values(context, dependencies)
  end with-open-file
end function;

define method write-property
    (property :: <property-setter>, stream)
 => ()
  format(stream, "define property-setter %s :: %s on %s end;\n",
         property.property-name,
         property.property-type,
         property.property-class);
end method write-property;

define method write-property
    (property :: <property-getter>, stream)
 => ()
  format(stream, "define property-getter %s :: %s on %s end;\n",
         property.property-name,
         property.property-type,
         property.property-class);
end method write-property;

define function generate-properties-file
    (project-dir :: <directory-locator>,
     namespace :: <string>,
     properties :: <sequence>)
 => ()
  let target-path = make-target-path(project-dir,  "properties.dylan");
  with-open-file (stream = target-path, direction: #"output",
                  if-does-not-exist: #"create")
    format(stream, "module: %s-properties\n", lowercase(namespace));
    format(stream, "synopsis: generated bindings for the %s library\n", namespace);
    format(stream, "copyright: See LICENSE file in this distribution.\n\n");

    for (property in properties)
      write-property(property, stream);
    end for;
  end with-open-file;
end function generate-properties-file;

define function library-name-from-dependency
    (dependency :: <pair>)
 => (library-name :: <string>)
  let library-name = head(dependency);
  lowercase(as(<byte-string>, library-name))
end function library-name-from-dependency;

define method property-method-name
    (property :: <property-setter>)
 => (name :: <string>)
  concatenate("@", property.property-name, "-setter");
end method property-method-name;

define method property-method-name
    (property :: <property-getter>)
 => (name :: <string>)
  concatenate("@", property.property-name);
end method property-method-name;

define function generate-library-file
    (project-dir :: <directory-locator>,
     namespace :: <string>,
     version :: <string>,
     exported-bindings :: <sequence>,
     properties :: <sequence>,
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
    if (~empty?(properties))
      format(stream, "  export %s-properties;\n", lower-namespace);
    end if;
    format(stream, "end library;\n");
    format(stream, "\n");

    format(stream, "define module %s\n", lower-namespace);
    format(stream, "  use dylan;\n");
    format(stream, "  use common-dylan;\n");
    format(stream, "  use c-ffi;\n");
    format(stream, "  use gobject-glue;\n");
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

    if (~empty?(properties))
    format(stream, "\n");
      format(stream, "define module %s-properties\n", lower-namespace);
      format(stream, "  use %s;\n", lower-namespace);
      format(stream, "  use gobject-glue;\n");
      format(stream, "\n");
      format(stream, "  export");
      for (property in remove-duplicates(properties, test: \=),
           first? = #t then #f)
        if (~first?) format(stream, ","); end if;
        format(stream, "\n    %s", property-method-name(property));
      finally
        format(stream, ";\n");
      end for;
      format(stream, "end module;\n");
    end if;
  end with-open-file;
end function;

define function generate-lid-file
    (project-dir :: <directory-locator>,
     namespace :: <string>,
     version :: <string>,
     #key properties? :: <boolean> = #f)
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
    if (properties?)
      format(stream, "       properties\n");
    end if;
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

    let complete-name = select (lower-namespace by \=)
                          "atk" => "atk";
                          "cairo" => "cairo";
                          "xlib" => "x11";
                          "pango" => "pango";
                          otherwise => concatenate(lower-namespace, "-", version);
                        end select;

    format(stream, "LINKLIBS += `pkg-config --libs %s` ;\n", complete-name);
    format(stream, "CCFLAGS += `pkg-config --cflags %s` ;\n", complete-name);
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
  let dylan-name = dylanize(concatenate("$", g-base-info-get-name(constant-info)));
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
  let dylan-enum-name = get-type-name(#"enum", enum-info);
  if (~binding-already-exported?(context, dylan-enum-name))
    let dylan-enum-pointer-name = get-type-name(#"enum-pointer", enum-info);
    add-exported-binding(context, dylan-enum-name);
    add-exported-binding(context, dylan-enum-pointer-name);
    // We use <C-int> rather than one-of because one-of isn't a C-FFI designator class
    format(context.output-stream, "define constant %s = <C-int>;\n", dylan-enum-name);
    format(context.output-stream, "define C-pointer-type %s => %s;\n\n",
           dylan-enum-pointer-name,
           dylan-enum-name);
  end if;
end method;

define method write-c-ffi (context, flags-info, type == $GI-INFO-TYPE-FLAGS)
 => ()
  write-c-ffi-values(context, flags-info);
  let dylan-flags-name = get-type-name(#"enum", flags-info);
  let dylan-flags-pointer-name = get-type-name(#"enum-pointer", flags-info);
  add-exported-binding(context, dylan-flags-name);
  add-exported-binding(context, dylan-flags-pointer-name);
  format(context.output-stream, "define constant %s = <C-int>;\n", dylan-flags-name);
  format(context.output-stream, "define C-pointer-type %s => %s;\n\n",
         dylan-flags-pointer-name,
         dylan-flags-name);
end method;

define method write-c-ffi (context, function-info, type == $GI-INFO-TYPE-FUNCTION)
 => ()
  write-c-ffi-function(context, function-info, #f);
end method;

define method write-c-ffi (context, interface-info, type == $GI-INFO-TYPE-INTERFACE)
 => ()
  let dylan-name = get-type-name(#"type", interface-info);
  let dylan-pointer-name = get-type-name(#"type-pointer", interface-info);
  if (~binding-already-exported?(context, dylan-pointer-name))
    add-exported-binding(context, dylan-pointer-name);

    let num-prerequisites = g-interface-info-get-n-prerequisites(interface-info);
    format(context.output-stream, "// Interface\n");
    let prerequisites-name = #[];
    if (num-prerequisites = 0)
      prerequisites-name := add!(prerequisites-name, "<C-void*>");
    else
      for (i from 0 below num-prerequisites)
        let prerequisite = g-interface-info-get-prerequisite(interface-info, i);
        let prerequisite-dylan-name = get-type-name(#"type-pointer", prerequisite);
        prerequisites-name := add!(prerequisites-name, prerequisite-dylan-name);
      end for;
    end;
    let joined-names = join(prerequisites-name, ", ");
    format(context.output-stream, "define open C-subtype %s (%s)\n", dylan-pointer-name, joined-names);
    format(context.output-stream, "end C-subtype;\n\n");
    let dylan-pointer-pointer-name = get-type-name(#"type-pointer-pointer", interface-info);
    add-exported-binding(context, dylan-pointer-pointer-name);
    format(context.output-stream, "define C-pointer-type %s => %s;\n\n",
           dylan-pointer-pointer-name,
           dylan-pointer-name);

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
  let dylan-name = get-type-name(#"type", object-info);
  let dylan-pointer-name = get-type-name(#"type-pointer", object-info);
  if (~binding-already-exported?(context, dylan-pointer-name))
    add-exported-binding(context, dylan-pointer-name);

    let parent-info = g-object-info-get-parent(object-info);
    if (null-pointer?(parent-info))
      // This is the root object
      format(context.output-stream, "define open C-subtype %s (<C-void*>)\n", dylan-pointer-name);
    else
      let parent-dylan-name = get-type-name(#"type-pointer", parent-info);
      format(context.output-stream, "define open C-subtype %s (%s)\n", dylan-pointer-name, parent-dylan-name);
      g-base-info-unref(parent-info);
    end if;

    let num-fields = g-object-info-get-n-fields(object-info);
    for (i from 0 below num-fields)
      let field = g-object-info-get-field(object-info, i);
      write-c-ffi-field(context, field, name);
    end for;
    format(context.output-stream, "end C-subtype;\n\n");
    let dylan-pointer-pointer-name = get-type-name(#"type-pointer-pointer", object-info);
    add-exported-binding(context, dylan-pointer-pointer-name);
    format(context.output-stream, "define C-pointer-type %s => %s;\n\n",
           dylan-pointer-pointer-name,
           dylan-pointer-name);
    let num-properties = g-object-info-get-n-properties(object-info);
    for (i from 0 below num-properties)
      let property-info = g-object-info-get-property(object-info, i);
      let property-flags = g-property-info-get-flags(property-info);
      let property-name = dylanize(g-base-info-get-name(property-info));
      let property-type = map-to-dylan-type(context, g-property-info-get-type(property-info));
      if (logand(property-flags, $G-PARAM-READABLE) ~= 0)
        add-property(context, make(<property-getter>,
                                   name: property-name,
                                   type: property-type,
                                   class: dylan-pointer-name));
      end if;
      if (logand(property-flags, $G-PARAM-WRITABLE) ~= 0)
        add-property(context, make(<property-setter>,
                                   name: property-name,
                                   type: property-type,
                                   class: dylan-pointer-name));
      end if;
      g-base-info-unref(property-info);
    end for;
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
  let dylan-name = get-type-name(#"type", struct-info);
  let dylan-pointer-name = get-type-name(#"type-pointer", struct-info);
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
  let dylan-name = get-type-name(#"union", union-info);
  let dylan-pointer-name = get-type-name(#"union-pointer", union-info);
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
  let repo = g-irepository-get-default();
  let namespace = g-base-info-get-namespace(field);
  let prefix = g-irepository-get-c-prefix(repo, namespace);
  let field-name = concatenate(dylanize(prefix), "-",
                               dylanize(container-name), "-",
                               dylanize(g-base-info-get-name(field)));
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
  let dylan-name = dylanize(g-function-info-get-symbol(function-info));
  if (~binding-already-exported?(context, dylan-name))
    add-exported-binding(context, dylan-name);
    format(context.output-stream, "define C-function %s\n", dylan-name);
    let function-flags = g-function-info-get-flags(function-info);
    if (logand(function-flags, $GI-FUNCTION-IS-METHOD) ~= 0)
      format(context.output-stream, "  input parameter self :: %s;\n", container-name);
    end if;
    let num-args = g-callable-info-get-n-args(function-info);
    for (i from 0 below num-args)
      let arg = g-callable-info-get-arg(function-info, i);
      let arg-name = g-base-info-get-name(arg);
      if (g-arg-info-is-return-value(arg))
        // XXX: We don't handle this. When does this happen?
      else
        let direction = direction-to-string(g-arg-info-get-direction(arg));
        let arg-type = map-to-dylan-type(context, g-arg-info-get-type(arg), direction: direction);
        format(context.output-stream, "  %s parameter %s_ :: %s;\n", direction, arg-name, arg-type);
      end if;
      g-base-info-unref(arg);
    end for;
    if (logand(function-flags, $GI-FUNCTION-THROWS) ~= 0)
      format(context.output-stream, "  output parameter error_ :: <GError*>;\n");
    end if;
    let result-type = g-callable-info-get-return-type(function-info);
    let result-tag = g-type-info-get-tag(result-type);
    if ((result-tag ~= $GI-TYPE-TAG-VOID) |
        (result-tag = $GI-TYPE-TAG-VOID & g-type-info-is-pointer(result-type)))
      let dylan-result-type = map-to-dylan-type(context, result-type);
      // HACK: avoid the compiler creating a wrapper object around <GObject>,
      // sometimes causing an infinite loop.
      if (dylan-name = "g-object-ref-sink")
        dylan-result-type := "<C-void*>";
      end if;
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
    let dylan-name = dylanize(concatenate("$", name));
    if (~binding-already-exported?(context, dylan-name))
      add-exported-binding(context, dylan-name);
      value-names := add!(value-names, dylan-name);
      let integer-value = g-value-info-get-value(value);
      // We use %= here as the value may be an <integer> or a <machine-word>
      // depending on the value.
      format(context.output-stream, "define constant %s = %=;\n", dylan-name, integer-value);
    end if;
    g-base-info-unref(value);
  end for;
  value-names
end function write-c-ffi-values;
