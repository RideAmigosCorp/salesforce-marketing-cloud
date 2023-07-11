import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_sfmc_ios_platform_interface.dart';

/// An implementation of [FlutterSfmcIosPlatform] that uses method channels.
class MethodChannelFlutterSfmcIos extends FlutterSfmcIosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_sfmc_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}