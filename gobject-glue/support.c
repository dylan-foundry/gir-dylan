#include <glib-object.h>

GType g_type_from_instance(GTypeInstance *instance) {
  return G_TYPE_FROM_INSTANCE(instance);
}

void g_value_nullify(GValue *gvalue) {
  char *foo = (char*)gvalue;
  int i;

  for (i = 0; i < sizeof(GValue); i++, foo++) {
    *foo = 0;
  }
}
