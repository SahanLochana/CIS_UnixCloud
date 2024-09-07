import 'package:url_launcher/url_launcher.dart';

class OpenTelegram {
  void openTelegram(String tgLink) async {
    Uri uri = Uri.parse(tgLink);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $tgLink');
    }
  }
}
