import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:day28/core/storage/secure_storage_service.dart';
import 'package:day28/features/auth/providers/auth_provider.dart';
import 'package:day28/core/auth/auth_notifier.dart';
import 'package:day28/core/analytics/firebase_analytics_service.dart';
import 'package:day28/core/widgets/language_switcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/minimal_colors.dart';
import '../../../../core/widgets/minimal_text_field.dart';
import '../../../../core/widgets/minimal_button.dart';
import '../../../../core/widgets/minimal_glass_container.dart';

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
        SnackBar(content: Text(AppLocalizations.of(context)!.error)),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final api = ref.read(authProvider);
      final result = await api.login(username: username, password: password);

      await SecureStorageService().saveToken(result.token);
      await FirebaseAnalyticsService.logLogin();

      if (!mounted) return;

      authNotifier.setLoggedIn(true);
      context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: MinimalColors.background,
      appBar: AppBar(
        title: const Text(''),
        actions: const [LanguageSwitcher()],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MinimalGlassContainer(
                padding: const EdgeInsets.all(32),
                borderRadius: 32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      LucideIcons.fingerprint,
                      size: 64,
                      color: MinimalColors.primary,
                    ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      l10n.loginButton.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: MinimalColors.primary,
                      ),
                    ).animate().fade(delay: 300.ms),
                    
                    const SizedBox(height: 40),
                    
                    MinimalTextField(
                      controller: usernameController,
                      hintText: l10n.username,
                    ).animate().slideY(begin: 0.1, delay: 500.ms).fade(delay: 500.ms),
                    
                    const SizedBox(height: 16),
                    
                    MinimalTextField(
                      controller: passwordController,
                      hintText: l10n.password,
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText ? LucideIcons.eye : LucideIcons.eyeOff,
                          color: MinimalColors.textLight,
                          size: 20,
                        ),
                      ),
                    ).animate().slideY(begin: 0.1, delay: 600.ms).fade(delay: 600.ms),
                    
                    const SizedBox(height: 40),
                    
                    MinimalButton(
                      text: l10n.loginButton,
                      onPressed: _onSubmit,
                      isLoading: isLoading,
                    ).animate().slideY(begin: 0.1, delay: 700.ms).fade(delay: 700.ms),
                  ],
                ),
              ).animate().fade(duration: 800.ms, curve: Curves.easeOut),
            ),
          ),
        ),
      ),
    );
  }
}