import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_sfmc_android_method_channel.dart';

abstract class FlutterSfmcAndroidPlatform extends PlatformInterface {
  /// Constructs a FlutterSfmcAndroidPlatform.
  FlutterSfmcAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSfmcAndroidPlatform _instance = MethodChannelFlutterSfmcAndroid();

  /// The default instance of [FlutterSfmcAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSfmcAndroid].
  static FlutterSfmcAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSfmcAndroidPlatform] when
  /// they register themselves.
  static set instance(FlutterSfmcAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
