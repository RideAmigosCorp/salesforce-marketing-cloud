import 'package:flutter/services.dart';
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.pigeon.dart',
    kotlinOut:
        '../flutter_sfmc_android/android/src/main/kotlin/com/rideamigos/flutter_sfmc/GeneratedAndroidSfmc.kt',
    swiftOut: '../flutter_sfmc_ios/ios/Classes/Messages.swift',
  ),
)
@HostApi()
abstract class SfmcHostApi {
  /// To Initialize the SDK for iOS only
  Future<bool?> initialize({
    String? appId,
    String? accessToken,
    String? mid,
    String? sfmcURL,
    String? senderId,
    bool? delayRegistration,
    bool? analytics,
  });

  /// (Applicable to iOS only - pass URL to Flutter through 'handle_url' methodCall.method - refer to example)
  void setHandler(Future<dynamic> Function(MethodCall call)? handler);

  /// To Set Contact Key
  @async
  bool? setContactKey(String? contactKey);

  /// To Get Contact Key
  @async
  String? getContactKey();

  /// To Add Tags
  @async
  bool? addTag(String? tag);

  /// To Remove Tags
  @async
  bool? removeTag(String? tag);

  /// Set Profile Attribute
  /// @param key - Key of the attribute
  /// @param value - Value of the attribute
  @async
  bool? setProfileAttribute(String key, String value);

  /// Clear Profile Attribute
  /// @param key - Key of the attribute
  @async
  bool? clearProfileAttribute(String key);

  /// To Get Tags
  @async
  List<String> getTags();

  /// To Enable/Disable Push Notification
  @async
  bool? setPushEnabled(bool? enabled);

  ///Get the PushToken currently registered in the native SFMC sdk
  /// [ANDROID] gets the FCM push token
  ///
  /// [iOS] gets the APNS token
  @async
  String? getPushToken();

  /// Set the PushToken used for mobile push
  @async
  String? setPushToken(String token);
}
