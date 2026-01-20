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

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getIconData(item.icon),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(item.label),
              ],
            ),
          ),
          label: '',
        );
      }).toList(),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home_outlined;
      case 'search':
        return Icons.search;
      case 'add':
        return Icons.add_circle_outline;
      case 'notifications':
        return Icons.notifications_outlined;
      case 'profile':
        return Icons.person_outline;
      default:
        return Icons.help_outline;
    }
  }
}