import 'package:energise_test/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  static const _link =
      'https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7';

  Future<void> rateApp() async {
    final inAppReview = InAppReview.instance;

    await inAppReview.requestReview();
  }

  Future<void> shareApp() async {
    await Share.share('Shared from Artem app');
  }

  Future<void> contactUs() async {
    if (!await launchUrl(Uri.parse(_link))) {
      throw Exception('Could not launch $_link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          border: TableBorder.all(color: Colors.white),
          children: [
            _tableRowCell(
              Text(context.loc.buttons, textAlign: TextAlign.center),
            ),
            _tableRowCell(
              FilledButton(
                onPressed: rateApp,
                child: Text(context.loc.rate_app),
              ),
            ),
            _tableRowCell(
              FilledButton(
                onPressed: shareApp,
                child: Text(context.loc.share_app),
              ),
            ),
            _tableRowCell(
              FilledButton(
                onPressed: contactUs,
                child: Text(context.loc.contact_us),
              ),
            ),
          ],
        ),
      ],
    );
  }

  TableRow _tableRowCell(Widget child) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(padding: const EdgeInsets.all(8), child: child),
        ),
      ],
    );
  }
}
