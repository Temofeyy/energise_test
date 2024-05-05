import 'package:energise_test/app/app.dart';
import 'package:energise_test/utils/custom_get_it.dart';
import 'package:energise_test/utils/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomGetIt.init();
  await Storage.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    context.findAncestorStateOfType<_MainAppState>()!.setLocale(newLocale);
  }
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;

  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const App(),
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        menuTheme: MenuThemeData(
          style: MenuStyle(
            padding:
                MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
          ),
        ),
        menuButtonTheme: MenuButtonThemeData(
            style: MenuItemButton.styleFrom(
                // padding: EdgeInsets.zero
                )),
        tabBarTheme: const TabBarTheme(
          dividerHeight: 0,
          labelPadding: EdgeInsets.all(16),
        ),
        cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
