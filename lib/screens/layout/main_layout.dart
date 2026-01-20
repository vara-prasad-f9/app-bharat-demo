// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'custom_appbar.dart';
import 'custom_bottombar.dart';

class MainLayout extends ConsumerStatefulWidget {
  final Widget child;
  final String title;
  final bool showAppBar;
  final bool showBottomNav;
  final List<Widget>? appBarActions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<BottomNavItem>? bottomNavItems;
  final ValueChanged<int>? onBottomNavTap;
  final int currentBottomNavIndex;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const MainLayout({
    Key? key,
    required this.child,
    required this.title,
    this.showAppBar = true,
    this.showBottomNav = true,
    this.appBarActions,
    this.showBackButton = false,
    this.onBackPressed,
    this.bottomNavItems,
    this.onBottomNavTap,
    this.currentBottomNavIndex = 0,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? CustomAppBar(
              title: widget.title,
              actions: widget.appBarActions,
              showBackButton: widget.showBackButton,
              onBackPressed: widget.onBackPressed,
            )
          : null,
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: widget.showBottomNav && widget.bottomNavItems != null
          ? CustomBottomBar(
              currentIndex: widget.currentBottomNavIndex,
              items: widget.bottomNavItems!,
              onTap: widget.onBottomNavTap ?? (_) {},
            )
          : null,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation ??
          (widget.floatingActionButton != null
              ? FloatingActionButtonLocation.centerDocked
              : null),
    );
  }
}