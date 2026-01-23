import 'package:flutter/material.dart';

class PropertyStats {
  final String name;
  final int completed;
  final int inProgress;
  final int readyToStart;
  final IconData icon;
  final Color color;
  final String location;
  final String city;

  PropertyStats({
    required this.name,
    required this.completed,
    required this.inProgress,
    required this.readyToStart,
    required this.icon,
    required this.color,
    required this.location,
    this.city = '',
  });
}
