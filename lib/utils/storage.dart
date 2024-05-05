import 'dart:convert';

import 'package:energise_test/api/models/response/ip_api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class Storage {
  static const _LOCATION_KEY = 'location';

  static late final SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<bool> saveLocationInfo(IpAPIResponse info) async {
    final jsonString = jsonEncode(info.toJson());
    return _instance.setString(_LOCATION_KEY, jsonString);
  }

  static Future<IpAPIResponse?> tryRetrieveLocationInfo() async {
    IpAPIResponse instance(String info) =>
        IpAPIResponse.fromJson(jsonDecode(info) as Map<String, dynamic>);

    final cached = _instance.getString(_LOCATION_KEY);
    return cached == null ? null : instance(cached);
  }
}
