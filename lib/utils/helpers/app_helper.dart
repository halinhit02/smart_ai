import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHelper {

  static int getServerTimeMillis({bool utc = false}) {
    DateTime startDate = DateTime.now();
    debugPrint('NTP DateTime: $startDate');
    if (utc) {
      startDate = startDate.toUtc();
    }
    return startDate.millisecondsSinceEpoch;
  }

  static Future openLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
