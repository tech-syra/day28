import 'package:flutter/foundation.dart';

import '../storage/secure_storage_service.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLoading = true;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthNotifier() {
    _load();
  }

  Future<void> _load() async {
    final token = await SecureStorageService().getToken();
    _isLoggedIn = token != null && token.isNotEmpty;
    _isLoading = false;
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    _isLoading = false;
    notifyListeners();
  }
}

final authNotifier = AuthNotifier();
