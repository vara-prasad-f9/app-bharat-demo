// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class BottomNavItem {
  final String icon;
  final String label;
  final int index;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.index,
  });
}

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavItem> items;
  final ValueChanged<int> onTap;
  final VoidCallback? onProfileTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 8,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.5),
        unselectedLabelStyle: const TextStyle(fontSize: 10, height: 1.5),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconSize: 20,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: items.map((item) {
          return BottomNavigationBarItem(
            icon: item.icon == 'profile' && onProfileTap != null
                ? GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Icon(
                        _getIconData(item.icon),
                        size: 20,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Icon(
                      _getIconData(item.icon),
                      size: 20,
                    ),
                  ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'dashboard':
        return Icons.dashboard_outlined;
      case 'projects':
        return Icons.assignment_outlined;
      case 'visits':
        return Icons.location_on_outlined;
      case 'profile':
        return Icons.person_outline;
      case 'add':
        return Icons.add_circle_outline;
      default:
        return Icons.help_outline;
    }
  }
}