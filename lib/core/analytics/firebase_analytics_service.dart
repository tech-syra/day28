import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Enable/disable analytics logging
  static Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    try {
      await _analytics.setAnalyticsCollectionEnabled(enabled);
      _log('Analytics collection ${enabled ? 'enabled' : 'disabled'}');
    } catch (e) {
      _logError('Failed to set analytics collection enabled', e);
    }
  }

  /// Log user login event
  static Future<void> logLogin({String? method}) async {
    try {
      await _analytics.logLogin(loginMethod: method);
      _log('User login logged');
    } catch (e) {
      _logError('Failed to log login', e);
    }
  }

  /// Log user signup event
  static Future<void> logSignUp({required String method}) async {
    try {
      await _analytics.logSignUp(signUpMethod: method);
      _log('User signup logged');
    } catch (e) {
      _logError('Failed to log signup', e);
    }
  }

  /// Log product view event
  static Future<void> logProductView({
    required String productId,
    required String productName,
    String? category,
    double? price,
  }) async {
    try {
      await _analytics.logViewItem(
        items: [
          AnalyticsEventItem(
            itemId: productId,
            itemName: productName,
            itemCategory: category,
            price: price,
          ),
        ],
      );
      _log('Product view logged: $productName');
    } catch (e) {
      _logError('Failed to log product view', e);
    }
  }

  /// Log add to cart event
  static Future<void> logAddToCart({
    required String productId,
    required String productName,
    String? category,
    double? price,
    int quantity = 1,
  }) async {
    try {
      await _analytics.logAddToCart(
        items: [
          AnalyticsEventItem(
            itemId: productId,
            itemName: productName,
            itemCategory: category,
            price: price,
            quantity: quantity,
          ),
        ],
      );
      _log('Add to cart logged: $productName (qty: $quantity)');
    } catch (e) {
      _logError('Failed to log add to cart', e);
    }
  }

  /// Log remove from cart event
  static Future<void> logRemoveFromCart({
    required String productId,
    required String productName,
    String? category,
    double? price,
  }) async {
    try {
      await _analytics.logRemoveFromCart(
        items: [
          AnalyticsEventItem(
            itemId: productId,
            itemName: productName,
            itemCategory: category,
            price: price,
          ),
        ],
      );
      _log('Remove from cart logged: $productName');
    } catch (e) {
      _logError('Failed to log remove from cart', e);
    }
  }

  /// Log purchase event
  static Future<void> logPurchase({
    required String transactionId,
    required double value,
    required String currency,
    required List<AnalyticsEventItem> items,
  }) async {
    try {
      await _analytics.logPurchase(
        transactionId: transactionId,
        value: value,
        currency: currency,
        items: items,
      );
      _log('Purchase logged: $transactionId (value: $value)');
    } catch (e) {
      _logError('Failed to log purchase', e);
    }
  }

  /// Log search event
  static Future<void> logSearch({required String searchTerm}) async {
    try {
      await _analytics.logSearch(searchTerm: searchTerm);
      _log('Search logged: $searchTerm');
    } catch (e) {
      _logError('Failed to log search', e);
    }
  }

  /// Log custom event
  static Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters: parameters,
      );
      _log('Custom event logged: $eventName');
    } catch (e) {
      _logError('Failed to log custom event', e);
    }
  }

  /// Set user ID
  static Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
      _log('User ID set: $userId');
    } catch (e) {
      _logError('Failed to set user ID', e);
    }
  }

  /// Set user properties
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
      _log('User property set: $name = $value');
    } catch (e) {
      _logError('Failed to set user property', e);
    }
  }

  // Logging helper methods
  static void _log(String message) {
    if (kDebugMode) {
      print('[FirebaseAnalytics] ✓ $message');
    }
  }

  static void _logError(String message, dynamic error) {
    if (kDebugMode) {
      print('[FirebaseAnalytics] ✗ $message: $error');
    }
  }
}
