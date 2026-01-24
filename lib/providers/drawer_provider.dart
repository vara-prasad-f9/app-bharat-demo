import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DrawerScreen {
  about,
  privacyPolicy,
  team,
  termsAndConditions,
  logout,
}

class DrawerNotifier extends StateNotifier<DrawerScreen?> {
  DrawerNotifier() : super(null);

  void navigateTo(DrawerScreen screen) {
    state = screen;
  }

  void clearNavigation() {
    state = null;
  }
}

final drawerProvider = StateNotifierProvider<DrawerNotifier, DrawerScreen?>(
  (ref) => DrawerNotifier(),
);
