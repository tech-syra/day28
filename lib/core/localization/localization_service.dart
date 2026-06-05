import 'package:flutter/material.dart';

class LocalizationService {
  static Locale _currentLocale = const Locale('en');

  static Locale get currentLocale => _currentLocale;

  static List<Locale> get supportedLocales => [
    const Locale('en'),
    const Locale('hi'),
  ];

  static void setLocale(Locale locale) {
    _currentLocale = locale;
  }

  static Locale getSystemLocale() {
    final systemLocale = Locale(
      WidgetsBinding.instance.window.locale.languageCode,
      WidgetsBinding.instance.window.locale.countryCode,
    );

    // Check if system locale is supported
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == systemLocale.languageCode) {
        return supportedLocale;
      }
    }

    // Default to English if not supported
    return const Locale('en');
  }

  static void initializeLocale() {
    _currentLocale = getSystemLocale();
  }
}
