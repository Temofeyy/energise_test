import 'package:energise_test/app/components/settings_button.dart';
import 'package:energise_test/ext.dart';
import 'package:energise_test/features/buttons/buttons_page.dart';
import 'package:energise_test/features/map/map_page.dart';
import 'package:energise_test/features/timer/timer_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  static const _tabsCount = 3;
  late final _controller = TabController(length: _tabsCount, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.app_title),
        centerTitle: true,
        actions: const [SettingsButton()],
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          TimerPage(),
          MapPage(),
          ButtonsPage(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.black,
        child: TabBar(
          controller: _controller,
          tabs: const [
            Icon(Icons.timer),
            Icon(Icons.location_on),
            Icon(Icons.menu),
          ],
        ),
      ),
    );
  }
}
