import 'package:json_annotation/json_annotation.dart';

part 'ip_api_response.g.dart';

@JsonSerializable()
final class IpAPIResponse {
  IpAPIResponse(
    this.query,
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.as,
  );

  String query;
  String status;
  String country;
  String countryCode;
  String region;
  String regionName;
  String city;
  String zip;
  double lat;
  double lon;
  String timezone;
  String isp;
  String org;
  String as;

  factory IpAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$IpAPIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IpAPIResponseToJson(this);

  @override
  String toString() {
    return 'IpAPIResponse{query: $query, status: $status, country: $country, countryCode: $countryCode, region: $region, regionName: $regionName, city: $city, zip: $zip, lat: $lat, lon: $lon, timezone: $timezone, isp: $isp, org: $org, as: $as}';
  }
}
