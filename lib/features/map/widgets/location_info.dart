import 'package:energise_test/api/models/response/ip_api_response.dart';
import 'package:flutter/material.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key, required this.info});

  final IpAPIResponse info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: const Text('IP:'), subtitle: Text(info.query)),
        ListTile(
            title: const Text('Country:'),
            subtitle: Text('${info.country} ${info.countryCode}')),
        ListTile(title: const Text('Region'), subtitle: Text(info.region)),
        ListTile(
            title: const Text('Region Name:'), subtitle: Text(info.regionName)),
        ListTile(title: const Text('City:'), subtitle: Text(info.city)),
        ListTile(title: const Text('ZIP:'), subtitle: Text(info.zip)),
        ListTile(
            title: const Text('LAT:'), subtitle: Text(info.lat.toString())),
        ListTile(
            title: const Text('LON:'), subtitle: Text(info.lon.toString())),
        ListTile(title: const Text('TimeZone:'), subtitle: Text(info.timezone)),
        ListTile(title: const Text('isp:'), subtitle: Text(info.isp)),
        ListTile(title: const Text('Organization:'), subtitle: Text(info.org)),
        ListTile(title: const Text('as:'), subtitle: Text(info.as)),
      ],
    );
  }
}
