import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale);

  static Future<AppLocalizations> load(String locale) async {
    String jsonString = await rootBundle.loadString('lib/l10n/\$locale.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AppLocalizations._internal(jsonMap);
  }

  late final Map<String, String> _localizedStrings;

  AppLocalizations._internal(Map<String, dynamic> jsonMap) {
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
