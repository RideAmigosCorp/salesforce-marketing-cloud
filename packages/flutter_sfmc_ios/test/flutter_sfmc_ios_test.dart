import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sfmc_ios/flutter_sfmc_ios.dart';
import 'package:flutter_sfmc_ios/flutter_sfmc_ios_platform_interface.dart';
import 'package:flutter_sfmc_ios/flutter_sfmc_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSfmcIosPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSfmcIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSfmcIosPlatform initialPlatform = FlutterSfmcIosPlatform.instance;

  test('$MethodChannelFlutterSfmcIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSfmcIos>());
  });

  test('getPlatformVersion', () async {
    FlutterSfmcIos flutterSfmcIosPlugin = FlutterSfmcIos();
    MockFlutterSfmcIosPlatform fakePlatform = MockFlutterSfmcIosPlatform();
    FlutterSfmcIosPlatform.instance = fakePlatform;

    expect(await flutterSfmcIosPlugin.getPlatformVersion(), '42');
  });
}
