import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/locale_provider.dart';

class LanguageSwitcher extends ConsumerWidget {
  final Widget? child;

  const LanguageSwitcher({super.key, this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return PopupMenuButton<String>(
      onSelected: (String locale) {
        ref.read(localeProvider.notifier).setLocale(Locale(locale));
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'en',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('English'),
              if (currentLocale.languageCode == 'en')
                const Icon(Icons.check, size: 20),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'hi',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('हिंदी'),
              if (currentLocale.languageCode == 'hi')
                const Icon(Icons.check, size: 20),
            ],
          ),
        ),
      ],
      child: child ?? const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.language, color: Colors.white),
      ),
    );
  }
}
