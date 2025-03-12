import 'package:flutter/material.dart';
import 'app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLocale = 'nl';
  late AppLocalizations localization;

  @override
  void initState() {
    super.initState();
    loadLocalization();
  }

  Future<void> loadLocalization() async {
    localization = await AppLocalizations.load(currentLocale);
    setState(() {});
  }

  void changeLanguage(String locale) async {
    setState(() {
      currentLocale = locale;
    });
    localization = await AppLocalizations.load(locale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(localization.translate("title"))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: currentLocale,
              onChanged: (String? newLocale) {
                if (newLocale != null) {
                  changeLanguage(newLocale);
                }
              },
              items: [
                DropdownMenuItem(value: "nl", child: Text("🇳🇱 Nederlands")),
                DropdownMenuItem(value: "en", child: Text("🇬🇧 English")),
                DropdownMenuItem(value: "fr", child: Text("🇫🇷 Français")),
                DropdownMenuItem(value: "de", child: Text("🇩🇪 Deutsch")),
                DropdownMenuItem(value: "es", child: Text("🇪🇸 Español")),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text(localization.translate("chat")),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(localization.translate("sync")),
            ),
          ],
        ),
      ),
    );
  }
}
