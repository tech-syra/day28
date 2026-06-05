import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

enum AppFlavorType { development, production, unknown }

class AppFlavor {
  static final String _flavorName =
      const String.fromEnvironment('FLAVOR', defaultValue: 'development')
          .toLowerCase();

  static AppFlavorType get currentFlavor {
    return AppFlavorType.values.firstWhere(
      (flavor) => flavor.name == _flavorName,
      orElse: () => AppFlavorType.unknown,
    );
  }

  static bool get showBanner {
    return currentFlavor == AppFlavorType.development ||
        currentFlavor == AppFlavorType.production;
  }

  static void initialize() {
    FlavorConfig(
      name: showBanner ? currentFlavor.name.toUpperCase() : '',
      color: _bannerColor,
      location: BannerLocation.topStart,
      variables: {'flavor': currentFlavor.name},
    );
  }

  static Color get _bannerColor {
    switch (currentFlavor) {
      case AppFlavorType.production:
        return Colors.red;
      case AppFlavorType.development:
        return Colors.blue;
      case AppFlavorType.unknown:
        return Colors.transparent;
    }
  }

  static Widget wrap(Widget child) {
    if (!showBanner) return child;
    return FlavorBanner(child: child);
  }
}
