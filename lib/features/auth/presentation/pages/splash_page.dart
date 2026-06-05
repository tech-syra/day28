import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_notifier.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    authNotifier.addListener(_handleAuthState);
  }

  void _handleAuthState() {
    if (!authNotifier.isLoading) {
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (authNotifier.isLoggedIn) {
          context.go('/');
        } else {
          context.go('/login_page');
        }
      });
    }
  }

  @override
  void dispose() {
    authNotifier.removeListener(_handleAuthState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Checking login status...'),
          ],
        ),
      ),
    );
  }
}
