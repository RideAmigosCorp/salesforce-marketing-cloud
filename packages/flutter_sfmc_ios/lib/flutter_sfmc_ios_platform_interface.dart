import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_sfmc_ios_method_channel.dart';

abstract class FlutterSfmcIosPlatform extends PlatformInterface {
  /// Constructs a FlutterSfmcIosPlatform.
  FlutterSfmcIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSfmcIosPlatform _instance = MethodChannelFlutterSfmcIos();

  /// The default instance of [FlutterSfmcIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSfmcIos].
  static FlutterSfmcIosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSfmcIosPlatform] when
  /// they register themselves.
  static set instance(FlutterSfmcIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
