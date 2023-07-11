import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sfmc_android/flutter_sfmc_android.dart';
import 'package:flutter_sfmc_android/flutter_sfmc_android_platform_interface.dart';
import 'package:flutter_sfmc_android/flutter_sfmc_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSfmcAndroidPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSfmcAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSfmcAndroidPlatform initialPlatform = FlutterSfmcAndroidPlatform.instance;

  test('$MethodChannelFlutterSfmcAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSfmcAndroid>());
  });

  test('getPlatformVersion', () async {
    FlutterSfmcAndroid flutterSfmcAndroidPlugin = FlutterSfmcAndroid();
    MockFlutterSfmcAndroidPlatform fakePlatform = MockFlutterSfmcAndroidPlatform();
    FlutterSfmcAndroidPlatform.instance = fakePlatform;

    expect(await flutterSfmcAndroidPlugin.getPlatformVersion(), '42');
  });
}
