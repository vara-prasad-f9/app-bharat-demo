import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharatplus/screens/layout/main_layout.dart';
import 'package:bharatplus/screens/layout/custom_bottombar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<BottomNavItem> _bottomNavItems = const [
    BottomNavItem(icon: 'home', label: 'Home', index: 0),
    BottomNavItem(icon: 'search', label: 'Search', index: 1),
    BottomNavItem(icon: 'add', label: 'Add', index: 2),
    BottomNavItem(icon: 'notifications', label: 'Alerts', index: 3),
    BottomNavItem(icon: 'profile', label: 'Profile', index: 4),
  ];

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'BharatPlus',
      showBottomNav: true,
      bottomNavItems: _bottomNavItems,
      currentBottomNavIndex: _currentIndex,
      onBottomNavTap: _onItemTapped,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.home,
                size: 80,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Welcome to BharatPlus!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your journey starts here!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
