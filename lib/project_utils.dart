import 'project_utils_platform_interface.dart';

class ProjectUtils {
  /// 获取平台版本
  Future<String?> getPlatformVersion() {
    return ProjectUtilsPlatform.instance.getPlatformVersion();
  }
}
