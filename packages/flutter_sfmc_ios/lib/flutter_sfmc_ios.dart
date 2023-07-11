
import 'flutter_sfmc_ios_platform_interface.dart';

class FlutterSfmcIos {
  Future<String?> getPlatformVersion() {
    return FlutterSfmcIosPlatform.instance.getPlatformVersion();
  }
}
