import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/locale_provider.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

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
            children: [
              Radio<String>(
                value: 'en',
                groupValue: currentLocale.languageCode,
                onChanged: (_) {},
              ),
              const SizedBox(width: 8),
              const Text('English'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'hi',
          child: Row(
            children: [
              Radio<String>(
                value: 'hi',
                groupValue: currentLocale.languageCode,
                onChanged: (_) {},
              ),
              const SizedBox(width: 8),
              const Text('हिंदी'),
            ],
          ),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.language),
      ),
    );
  }
}
