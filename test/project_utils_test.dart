import 'package:flutter_test/flutter_test.dart';
import 'package:project_utils/project_utils.dart';
import 'package:project_utils/project_utils_platform_interface.dart';
import 'package:project_utils/project_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockProjectUtilsPlatform
    with MockPlatformInterfaceMixin
    implements ProjectUtilsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ProjectUtilsPlatform initialPlatform = ProjectUtilsPlatform.instance;

  test('$MethodChannelProjectUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelProjectUtils>());
  });

  test('getPlatformVersion', () async {
    ProjectUtils projectUtilsPlugin = ProjectUtils();
    MockProjectUtilsPlatform fakePlatform = MockProjectUtilsPlatform();
    ProjectUtilsPlatform.instance = fakePlatform;

    expect(await projectUtilsPlugin.getPlatformVersion(), '42');
  });
}
