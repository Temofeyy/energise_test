import 'dart:async';

import 'package:energise_test/api/api.dart';
import 'package:energise_test/api/models/response/ip_api_response.dart';
import 'package:energise_test/ext.dart';
import 'package:energise_test/features/map/widgets/error_info.dart';
import 'package:energise_test/features/map/widgets/loading_shimmer.dart';
import 'package:energise_test/features/map/widgets/location_info.dart';
import 'package:energise_test/features/map/widgets/map.dart';
import 'package:energise_test/utils/custom_get_it.dart';
import 'package:energise_test/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_ip_address/public_ip_address.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class MapProvider extends ChangeNotifier {
  MapProvider() {
    unawaited(_init());
  }

  bool isLoading = true;
  String? _error;
  IpAPIResponse? _info;

  IpAPIResponse? get info => _info;
  String? get error => _error;
  bool get hasError => _error != null;

  Future<void> _init() async {
    final cachedInfo = await Storage.tryRetrieveLocationInfo();
    if (cachedInfo == null) {
      await reload();
      isLoading = false;
      notifyListeners();
      return;
    }
    _info = cachedInfo;
    isLoading = false;
    // notifyListeners();
  }

  Future<String> _getIp() async => IpAddress().getIp();

  Future<IpAPIResponse?> _loadInfoByIp(String ip) async {
    return CustomGetIt.get<API>()?.infoByIp(ip);
  }

  Future<void> reload() async {
    final ip = await _getIp();
    final fetchedInfo = await _loadInfoByIp(ip);
    if (fetchedInfo == null) {
      _error = 'Unknown Error';
      notifyListeners();
      return;
    }
    _info = fetchedInfo;
    notifyListeners();
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final provider = MapProvider();
  final _refreshController = RefreshController(initialRefresh: true);

  Future<void> reloadWrapper([bool isButton = false]) async {
    if (isButton) await _refreshController.requestRefresh();
    await provider.reload();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<MapProvider>(
        builder: (ctx, map, __) {
          return Stack(
            children: [
              SmartRefresher(
                controller: _refreshController,
                onRefresh: reloadWrapper,
                header: ClassicHeader(
                  idleText: ctx.loc.pull_to_refresh,
                  releaseText: ctx.loc.release_to_refresh,
                  refreshingText: ctx.loc.loading,
                  completeText: ctx.loc.refresh_completed,
                ),
                child: SingleChildScrollView(
                  child: map.isLoading
                      ? const LoadingShimmer()
                      : map.hasError
                          ? ErrorInfo(errorText: map.error!)
                          : Column(
                              children: [
                                MapSection(
                                  lat: map.info!.lat,
                                  lng: map.info!.lon,
                                ),
                                LocationInfo(info: map.info!),
                                const SizedBox(height: 100),
                              ],
                            ),
                ),
              ),
              Positioned(
                bottom: 06,
                left: 16,
                right: 16,
                child: FilledButton(
                  onPressed: () async => reloadWrapper(true),
                  child: Text(ctx.loc.reload),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}