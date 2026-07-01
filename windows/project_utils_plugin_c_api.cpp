#include "include/project_utils/project_utils_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "project_utils_plugin.h"

void ProjectUtilsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  project_utils::ProjectUtilsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
