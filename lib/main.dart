// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/phone_login_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/home_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'services/onboarding_service.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Provider for onboarding state
final onboardingProvider = FutureProvider<bool>((ref) async {
  return await OnboardingService.isOnboardingCompleted();
});

// Define the router configuration
final _router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final authState = ProviderScope.containerOf(context, listen: false).read(authProvider);
    final isAuthPage = state.uri.path == '/login' || 
                      state.uri.path == '/otp-verify' ||
                      state.uri.path == '/role-selection';
    final isSplash = state.uri.path == '/';
    final isOnboarding = state.uri.path == '/onboarding';
    
    // Get onboarding status
    final prefs = await SharedPreferences.getInstance();
    final isOnboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    // Handle authenticated users
    if (authState.isAuthenticated) {
      if (isOnboarding) {
        return '/home';
      }
      return null; // Allow access to all routes when authenticated
    }
    
    // Handle unauthenticated users
    if (!isOnboardingCompleted) {
      if (!isOnboarding && !isSplash) {
        return '/onboarding';
      }
      return null; // Allow access to onboarding and splash
    }
    
    // If onboarding is completed but not authenticated
    if (!isAuthPage && !isSplash) {
      return '/login';
    }
    
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const PhoneLoginScreen(),
    ),
    GoRoute(
      path: '/otp-verify',
      builder: (context, state) => const OtpVerificationScreen(),
    ),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: 'BharatPlus',
      theme: theme,
      darkTheme: theme, // Use the same theme for dark mode since we're handling it manually
      themeMode: ThemeMode.system, // This will be overridden by our theme provider
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
