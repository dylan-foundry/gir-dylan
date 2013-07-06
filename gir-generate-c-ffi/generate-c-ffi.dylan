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

define method write-c-ffi (info, type == $GI-INFO-TYPE-FUNCTION)
 => ()
  let name = g-base-info-get-name(info);
  let dylan-name = name;
  format-out("define C-function %s\n", dylan-name);
  let num-args = g-callable-info-get-n-args(info);
  for (i from 0 below num-args)
    let arg = g-callable-info-get-arg(info, i);
    let name = g-base-info-get-name(arg);
    let type = "<object>";
    if (g-arg-info-is-return-value(arg))
      format-out("  result %s :: %s;\n", name, type);
    else
      let direction = direction-to-string(g-arg-info-get-direction(arg));
      format-out("  %s parameter %s :: %s;\n", direction, name, type);
    end if;
    g-base-info-unref(arg);
  end for;
  format-out("  c-name: \"%s\";\n", name);
  format-out("end;\n\n");
end method;
