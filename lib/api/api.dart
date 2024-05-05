import 'package:dio/dio.dart';
import 'package:energise_test/api/models/response/ip_api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi()
abstract class API {
  static const _GET_LOCATION_BY_IP = 'http://ip-api.com/json';

  factory API(Dio dio, {String baseUrl}) = _API;

  @GET(_GET_LOCATION_BY_IP + '/{ip}')
  Future<IpAPIResponse> infoByIp(@Path() String ip);
}
