import 'package:day28/features/auth/presentation/pages/login_page.dart';
import 'package:day28/features/auth/presentation/pages/splash_page.dart';
import 'package:day28/core/auth/auth_notifier.dart';
import 'package:day28/features/auth/presentation/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/presentation/pages/cart_screen.dart';
import '../../features/products/data/models/product.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/product_list_page.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  refreshListenable: authNotifier,
  redirect: (context, state) {
    final loc = state.uri.path;
    final isSplash = loc == '/splash';
    final isLogin = loc == '/login_page';

    if (authNotifier.isLoading) {
      return isSplash ? null : '/splash';
    }

    if (!authNotifier.isLoggedIn) {
      return isLogin ? null : '/login_page';
    }

    if (isLogin || isSplash) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const ProductListPage();
      },
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) {
        final product = state.extra as Product;

        return ProductDetailPage(
          product: product,
        );
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) {
        return const CartScreen();
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return const ProfilePage();
      },
    ),
  ],
);

