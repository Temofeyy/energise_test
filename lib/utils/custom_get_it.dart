import 'package:dio/dio.dart';
import 'package:energise_test/utils/storage.dart';

import '../api/api.dart';

class CustomGetIt {
  static final _instances = <Type, dynamic>{};

  static T? get<T>() => _instances[T] as T;

  static Future<void> init() async {
    _instances.addAll({
      API: API(configureDio()),
    });
  }
}

Dio configureDio() {
  return Dio();
}
