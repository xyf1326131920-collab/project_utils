import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'project_utils_method_channel.dart';

abstract class ProjectUtilsPlatform extends PlatformInterface {
  /// Constructs a ProjectUtilsPlatform.
  ProjectUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static ProjectUtilsPlatform _instance = MethodChannelProjectUtils();

  /// The default instance of [ProjectUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelProjectUtils].
  static ProjectUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ProjectUtilsPlatform] when
  /// they register themselves.
  static set instance(ProjectUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
