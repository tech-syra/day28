import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:day28/core/storage/secure_storage_service.dart';
import 'package:day28/features/auth/providers/auth_provider.dart';
import 'package:day28/core/auth/auth_notifier.dart';
import 'package:day28/core/analytics/firebase_analytics_service.dart';
import 'package:day28/core/widgets/language_switcher.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController(text: 'mor_2314');
  final passwordController = TextEditingController(text: '83r5^_');
  bool obscureText = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // if already logged in, go to home
    if (authNotifier.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/');
      });
    }

    authNotifier.addListener(_authListener);
  }

  void _authListener() {
    if (authNotifier.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/');
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    authNotifier.removeListener(_authListener);
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final api = ref.read(authProvider);
      final result = await api.login(username: username, password: password);

      // persist token
      await SecureStorageService().saveToken(result.token);

        // analytics: login
        await FirebaseAnalyticsService.logLogin();

      if (!mounted) return;

      // update auth state so router redirects
      authNotifier.setLoggedIn(true);

      // navigate to home (product list)
      context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: const [LanguageSwitcher()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag,
                size: 80,
              ),

              const SizedBox(height: 20),

              const Text(
                'Ecom Store',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _onSubmit,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Login'),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                '(Demo credentials pre-filled)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}