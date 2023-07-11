
import 'flutter_sfmc_android_platform_interface.dart';

class FlutterSfmcAndroid {
  Future<String?> getPlatformVersion() {
    return FlutterSfmcAndroidPlatform.instance.getPlatformVersion();
  }
}
