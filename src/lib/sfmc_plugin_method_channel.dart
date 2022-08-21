import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sfmc_plugin_platform_interface.dart';

/// An implementation of [SfmcPluginPlatform] that uses method channels.
class MethodChannelSfmcPlugin extends SfmcPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sfmc_plugin');

  @override
  Future<bool?> initialize(
      {String? appId,
        String? accessToken,
        String? mid,
        String? sfmcURL,
        String? senderId,
        bool? locationEnabled,
        bool? inboxEnabled,
        bool? analyticsEnabled,
        bool? delayRegistration}) async {
    final bool? result = await methodChannel.invokeMethod('initialize', {
      "appId": appId,
      "accessToken": accessToken,
      "mid": mid,
      "sfmcURL": sfmcURL,
      "senderId": senderId,
      "locationEnabled": locationEnabled,
      "inboxEnabled": inboxEnabled,
      "analyticsEnabled": analyticsEnabled,
      "delayRegistration": delayRegistration,
    });
    return result;
  }

  @override
  Future<bool?> setContactKey(String? contactKey)async{
    final bool? result = await methodChannel.invokeMethod('setContactKey', {
      "contactKey": contactKey,
    });

    return result;
  }

  @override
  Future<String?> getContactKey() async{
    final String? result = await methodChannel.invokeMethod('getContactKey');

    return result;
  }

  @override
  Future<bool?> addTag(String? tag)async{
    final bool? result = await methodChannel.invokeMethod('addTag', {
      "tag": tag,
    });

    return result;
  }

  @override
  Future<bool?> removeTag(String? tag) async{
    final bool? result = await methodChannel.invokeMethod('removeTag', {
      "tag": tag,
    });

    return result;
  }

  @override
  Future<List<String>> getTags()async{
    final List<String> result = await methodChannel.invokeMethod('getTags');

    return result;
  }

  @override
  Future<bool?> setPushEnabled(bool? enabled)async{
    final bool? result = await methodChannel.invokeMethod('setPushEnabled', {
    "isEnabled": enabled ?? true,
    });

    return result;
  }
}