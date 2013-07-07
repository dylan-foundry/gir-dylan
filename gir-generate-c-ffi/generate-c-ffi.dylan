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
    let type = g-base-info-get-type(info);
    write-c-ffi(info, type);
    force-output(*standard-output*);
  end for;
end function;

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

define method write-c-ffi (info, type)
 => ()
  let name = g-base-info-get-name(info);
  let type-name = name-for-type(type);
  format-out("// Not set up yet for %s %s\n\n", type-name, name);
end method;

define function direction-to-string (direction) => (dir :: <string>)
  select (direction)
    $GI-DIRECTION-IN => "input";
    $GI-DIRECTION-OUT => "output";
    $GI-DIRECTION-INOUT => "input output";
  end select;
end function;

define method write-c-ffi (function-info, type == $GI-INFO-TYPE-FUNCTION)
 => ()
  let name = g-base-info-get-name(function-info);
  let dylan-name = map-name(#"function", "", name, #[]);
  format-out("define C-function %s\n", dylan-name);
  let num-args = g-callable-info-get-n-args(function-info);
  for (i from 0 below num-args)
    let arg = g-callable-info-get-arg(function-info, i);
    let arg-name = g-base-info-get-name(arg);
    let arg-type = map-to-dylan-type(g-arg-info-get-type(arg));
    if (g-arg-info-is-return-value(arg))
      // XXX: We don't handle this. When does this happen?
    else
      let direction = direction-to-string(g-arg-info-get-direction(arg));
      format-out("  %s parameter %s :: %s;\n", direction, arg-name, arg-type);
    end if;
    g-base-info-unref(arg);
  end for;
  let result-type = g-callable-info-get-return-type(function-info);
  let dylan-result-type = map-to-dylan-type(result-type);
  format-out("  result res :: %s;\n", dylan-result-type);
  let symbol = g-function-info-get-symbol(function-info);
  format-out("  c-name: \"%s\";\n", symbol);
  format-out("end;\n\n");
end method;

define function map-to-dylan-type (typeinfo) => (str :: <string>)
  // XXX: This is clearly an incorrect implementation.
  g-type-tag-to-string(g-type-info-get-tag(typeinfo));
end function;

define method write-c-ffi (constant-info, type == $GI-INFO-TYPE-CONSTANT)
 => ()
  let name = g-base-info-get-name(constant-info);
  let dylan-name = map-name(#"constant", "", name, #[]);
  let type = g-constant-info-get-type(constant-info);
  let dylan-type = map-to-dylan-type(type);
  let value = "XXX";
  format-out("define constant %s :: %s = %s;\n\n", dylan-name,
             dylan-type, value);
end method;

define method write-c-ffi (enum-info, type == $GI-INFO-TYPE-ENUM)
 => ()
  let value-names = #[];
  let num-values = g-enum-info-get-n-values(enum-info);
  for (i from 0 below num-values)
    let value = g-enum-info-get-value(enum-info, i);
    let name = g-base-info-get-attribute(value, "c:identifier");
    let dylan-name = map-name(#"constant", "", name, #[]);
    value-names := add!(value-names, dylan-name);
    let integer-value = g-value-info-get-value(value);
    format-out("define constant %s :: <integer> = %d\n", dylan-name, integer-value);
    g-base-info-unref(value);
  end for;
  let enum-name  = g-base-info-get-name(enum-info);
  let dylan-enum-name = map-name(#"type", "", enum-name, #[]);
  let joined-value-names = join(value-names, ", ");
  format-out("define constant %s = one-of(%s);\n\n", dylan-enum-name, joined-value-names);
end method;
