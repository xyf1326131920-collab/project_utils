import 'project_utils_platform_interface.dart';

export 'keep_alive_wrapper.dart';
export 'print/toast_utils.dart';

/// Flutter 项目工具插件入口。
///
/// 提供平台版本查询；Toast 与 KeepAlive 请使用导出的 [ToastUtils]、[KeepAliveWrapper]。
class ProjectUtils {
  /// 获取当前运行平台的系统版本字符串。
  Future<String?> getPlatformVersion() {
    return ProjectUtilsPlatform.instance.getPlatformVersion();
  }
}
