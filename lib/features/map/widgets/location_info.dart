import 'package:energise_test/api/models/response/ip_api_response.dart';
import 'package:energise_test/ext.dart';
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
          title: Text(context.loc.country),
          subtitle: Text('${info.country} ${info.countryCode}'),
        ),
        ListTile(title: Text(context.loc.region), subtitle: Text(info.region)),
        ListTile(
            title: Text(context.loc.region_name),
            subtitle: Text(info.regionName)),
        ListTile(title: Text(context.loc.city), subtitle: Text(info.city)),
        ListTile(title: Text(context.loc.zip), subtitle: Text(info.zip)),
        ListTile(
          title: Text(context.loc.lat),
          subtitle: Text(info.lat.toString()),
        ),
        ListTile(
          title: Text(context.loc.lon),
          subtitle: Text(info.lon.toString()),
        ),
        ListTile(
          title: Text(context.loc.timezone),
          subtitle: Text(info.timezone),
        ),
        ListTile(title: Text(context.loc.isp), subtitle: Text(info.isp)),
        ListTile(
          title: Text(context.loc.organization),
          subtitle: Text(info.org),
        ),
        ListTile(title: Text(context.loc.as), subtitle: Text(info.as)),
      ],
    );
  }
}
