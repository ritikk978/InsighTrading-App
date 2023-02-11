import 'package:url_launcher/url_launcher_string.dart';

class ZLaunchUrl {
  static Future<void> launchUrl(String url) async {
    try {
      await launchUrlString(url);
    } catch (e) {
      print(e);
    }
  }
}
