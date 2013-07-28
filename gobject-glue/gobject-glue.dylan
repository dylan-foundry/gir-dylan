module: gobject-glue
copyright: See LICENSE file in this distribution.

define constant <gsize> = <C-unsigned-long>;
define constant <GType> = <gsize>;

define constant $G-TYPE-INVALID = 0;
define constant $G-TYPE-NONE = 4;
define constant $G-TYPE-CHAR = 12;
define constant $G-TYPE-UCHAR = 16;
define constant $G-TYPE-BOOLEAN = 20;
define constant $G-TYPE-INT = 24;
define constant $G-TYPE-UINT = 28;
define constant $G-TYPE-LONG = 32;
define constant $G-TYPE-ULONG = 36;
define constant $G-TYPE-INT64 = 40;
define constant $G-TYPE-UINT64 = 44;
define constant $G-TYPE-ENUM = 48;
define constant $G-TYPE-FLAGS = 52;
define constant $G-TYPE-FLOAT = 56;
define constant $G-TYPE-DOUBLE = 60;
define constant $G-TYPE-STRING = 64;
define constant $G-TYPE-POINTER = 68;
define constant $G-TYPE-BOXED = 72;
define constant $G-TYPE-PARAM = 76;
define constant $G-TYPE-OBJECT = 80;


define C-struct <_GValue>
  constant slot gvalue-g-type :: <C-long>;
  slot gvalue-data :: <C-unsigned-char*> /* Not supported */;
  pointer-type-name: <GValue>;
end C-struct;

define C-struct <_GTypeClass>
  constant slot gtypeclass-g-type :: <C-long>;
  pointer-type-name: <GTypeClass>;
end C-struct;

define C-struct <_GTypeInstance>
  constant slot gtypeinstance-g-class :: <GTypeClass>;
  pointer-type-name: <GTypeInstance>;
end C-struct;

define C-struct <_GData>
  pointer-type-name: <GData>;
end C-struct;

define open C-subtype <GObject> (<C-void*>)
  constant slot gobject-g-type-instance :: <GTypeInstance>;
  constant slot gobject-ref-count :: <C-unsigned-int>;
  constant slot gobject-qdata :: <GData>;
end C-subtype;

define C-function g-type-from-instance
  input parameter instance :: <GTypeInstance>;
  result type :: <GType>;
  c-name: "g_type_from_instance";
end;

define C-function g-value-init
  input parameter self :: <GValue>;
  input parameter g_type_ :: <C-long>;
  result res :: <GValue>;
  c-name: "g_value_init";
end;
define C-function g-value-set-double
  input parameter self :: <GValue>;
  input parameter v_double_ :: <C-double>;
  c-name: "g_value_set_double";
end;
define C-function g-value-set-float
  input parameter self :: <GValue>;
  input parameter v_float_ :: <C-float>;
  c-name: "g_value_set_float";
end;
define C-function g-value-set-int
  input parameter self :: <GValue>;
  input parameter v_int_ :: <C-signed-int>;
  c-name: "g_value_set_int";
end;
define C-function g-value-set-boolean
  input parameter self :: <GValue>;
  input parameter v_boolean_ :: <C-boolean>;
  c-name: "g_value_set_boolean";
end;
define C-function g-value-set-object
  input parameter self :: <GValue>;
  input parameter v_object_ :: <GObject>;
  c-name: "g_value_set_object";
end;
define C-function g-value-set-string
  input parameter self :: <GValue>;
  input parameter v_string_ :: <C-string>;
  c-name: "g_value_set_string";
end;

define method g-value-set-value (gvalue :: <GValue>, value :: <double-float>)
  g-value-init(gvalue, $G-TYPE-DOUBLE);
  g-value-set-double(gvalue, value);
end;
define method g-value-set-value (gvalue :: <GValue>, value :: <single-float>)
  g-value-init(gvalue, $G-TYPE-FLOAT);
  g-value-set-float(gvalue, value);
end;
define method g-value-set-value (gvalue :: <GValue>, value :: <integer>)
  g-value-init(gvalue, $G-TYPE-INT);
  g-value-set-int(gvalue, value);
end;
define method g-value-set-value (gvalue :: <GValue>, value :: <boolean>)
  g-value-init(gvalue, $G-TYPE-BOOLEAN);
  g-value-set-boolean(gvalue, value);
end;
define method g-value-set-value (gvalue :: <GValue>, value :: <GTypeInstance>)
  g-value-init(gvalue, g-type-from-instance(value));
  g-value-set-object(gvalue, value);
end;

define method g-value-set-value (gvalue :: <GValue>, string :: <string>)
  g-value-init(gvalue, $G-TYPE-STRING);
  g-value-set-string(gvalue, string);
end;

define C-function g-object-get-property
  input parameter self :: <GObject>;
  input parameter property_name_ :: <C-string>;
  input parameter value_ :: <GValue>;
  c-name: "g_object_get_property";
end;

define C-function g-object-set-property
  input parameter self :: <GObject>;
  input parameter property_name_ :: <C-string>;
  input parameter value_ :: <GValue>;
  c-name: "g_object_set_property";
end;

define C-function gdk-threads-enter
  c-name: "gdk_threads_enter";
end;

define C-function gdk-threads-leave
  c-name: "gdk_threads_leave";
end;

define thread variable *holding-gdk-lock* = 0;

define macro with-gdk-lock
  { with-gdk-lock ?:body end }
 =>
  {  block()
       *holding-gdk-lock* > 0 | gdk-threads-enter();
       *holding-gdk-lock* := *holding-gdk-lock* + 1;
       ?body
     cleanup
       *holding-gdk-lock* := *holding-gdk-lock* - 1;
       *holding-gdk-lock* > 0 | gdk-threads-leave();
     end }
end;

define macro property-getter-definer
  { define property-getter ?:name :: ?type:name on ?class:name end }
  => { define method "@" ## ?name (object :: ?class) => (res)
         with-stack-structure (foo :: <GValue>)
           g-object-get-property(object, ?"name", foo);
//           g-value-to-dylan(foo);
         end;
       end;
  }
end;

define C-function g-value-nullify
  parameter gvalue :: <GValue>;
  c-name: "g_value_nullify";
end;

define macro property-setter-definer
  { define property-setter ?:name :: ?type:name on ?class:name end }
  => { define method "@" ## ?name ## "-setter" (res, object :: ?class) => (res)
         with-stack-structure (gvalue :: <GValue>)
           // FIXME: hack, because we cannot request initialization with zero
           // from with-stack-structure
           g-value-nullify(gvalue);
           g-value-set-value(gvalue, res);
           g-object-set-property(object, ?"name", gvalue);
         end;
         res;
       end;
  }
end;
