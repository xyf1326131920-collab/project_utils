import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'project_utils_platform_interface.dart';

/// An implementation of [ProjectUtilsPlatform] that uses method channels.
class MethodChannelProjectUtils extends ProjectUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('project_utils');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
