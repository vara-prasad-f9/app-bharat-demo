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
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000),
            blurRadius: 10,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth * 0.9) / items.length;
          
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              if (item.icon == 'add') {
                return Container(
                  width: itemWidth * 1.2,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildNavItem(item, context),
                );
              }
              
              return Container(
                width: itemWidth,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildNavItem(item, context),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(BottomNavItem item, BuildContext context) {
    final isSelected = currentIndex == item.index;
    final color = isSelected 
        ? Theme.of(context).colorScheme.primary 
        : Colors.grey;
    
    final isAddButton = item.icon == 'add';
    final iconSize = isAddButton ? 20.0 : 24.0;
    
    final itemWidget = GestureDetector(
      onTap: () => onTap(item.index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isAddButton
              ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconData(item.icon),
                    size: iconSize,
                    color: Colors.white,
                  ),
                )
              : Icon(
                  _getIconData(item.icon),
                  size: iconSize,
                  color: color,
                ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 10,
              height: 1.5,
              color: color,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
    
    if (item.icon == 'profile' && onProfileTap != null) {
      return GestureDetector(
        onTap: onProfileTap,
        child: itemWidget,
      );
    }
    
    return itemWidget;
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
        return Icons.add;
      default:
        return Icons.help_outline;
    }
  }
}