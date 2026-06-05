import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization/localization_service.dart';

// Locale state provider
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(LocalizationService.currentLocale);

  void setLocale(Locale locale) {
    LocalizationService.setLocale(locale);
    state = locale;
  }

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      setLocale(const Locale('hi'));
    } else {
      setLocale(const Locale('en'));
    }
  }
}
