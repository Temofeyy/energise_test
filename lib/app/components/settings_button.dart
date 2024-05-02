import 'package:energise_test/ext.dart';
import 'package:energise_test/gen/assets.gen.dart';
import 'package:energise_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  void onTap(MenuController controller) =>
      controller.isOpen ? controller.close() : controller.open();

  List<MenuItemButton> availableLocales(BuildContext context) {
    final current = context.loc.localeName;

    final selectedStyle = MenuItemButton.styleFrom(
        backgroundColor: Colors.purple.withOpacity(0.2));

    return AppLocalizations.supportedLocales
        .map((l) => MenuItemButton(
              style: l.languageCode == current ? selectedStyle : null,
              leadingIcon: Image.asset(
                Assets.flags.values
                    .where((f) => f.path.fileName == l.languageCode)
                    .first
                    .path,
                width: 20,
              ),
              onPressed: () => MainApp.setLocale(context, l),
              child: Text(l.languageCode.toUpperCase()),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        SubmenuButton(
          leadingIcon: const Icon(Icons.language),
          menuChildren: [...availableLocales(context)],
          child: const Text('Language'), //TODO: localize
        ),
      ],
      builder: (_, controller, __) => IconButton(
        onPressed: () => onTap(controller),
        icon: const Icon(Icons.settings),
      ),
    );
  }
}
