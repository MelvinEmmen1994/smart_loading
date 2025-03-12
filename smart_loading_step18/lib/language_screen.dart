import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Locale _selectedLocale = const Locale('en');

  void _changeLanguage(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _selectedLocale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('nl', ''),
        Locale('fr', ''),
        Locale('de', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(title: Text(Intl.message('Taalkeuze', name: 'languageSelection'))),
        body: Center(
          child: DropdownButton<Locale>(
            value: _selectedLocale,
            items: const [
              DropdownMenuItem(value: Locale('en'), child: Text('English')),
              DropdownMenuItem(value: Locale('nl'), child: Text('Nederlands')),
              DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
              DropdownMenuItem(value: Locale('de'), child: Text('Deutsch')),
              DropdownMenuItem(value: Locale('es'), child: Text('Español')),
            ],
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                _changeLanguage(newLocale);
              }
            },
          ),
        ),
      ),
    );
  }
}
