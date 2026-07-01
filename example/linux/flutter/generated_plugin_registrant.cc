//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <project_utils/project_utils_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) project_utils_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ProjectUtilsPlugin");
  project_utils_plugin_register_with_registrar(project_utils_registrar);
}
