// ignore_for_file: unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharatplus/models/project_model.dart';
import 'package:bharatplus/models/property_stats.dart';

// Helper function to get color based on project status
Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'in progress':
      return Colors.green;
    case 'on hold':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

class ProjectNotifier extends StateNotifier<List<ProjectModel>> {
  ProjectNotifier() : super([]) {
    // Initialize with some sample data if needed
    _initializeSampleData();
  }

  void _initializeSampleData() {
    final sampleProjects = [
      ProjectModel()
        ..projectName = 'Luxury Villa'
        ..projectType = 'Villa'
        ..projectStatus = 'In Progress'
        ..city = 'Beverly Hills, CA'
        ..area = 'Beverly Hills'
        ..price = '\$19,999'
        ..imageUrl =
            'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=800&auto=format&fit=crop',
      ProjectModel()
        ..projectName = 'Emerald'
        ..projectType = 'Apartment'
        ..projectStatus = 'In Progress'
        ..city = 'Malibu, CA'
        ..area = 'Malibu'
        ..price = '\$39,999'
        ..imageUrl =
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=800&auto=format&fit=crop',
      ProjectModel()
        ..projectName = 'Bella Vista Villa'
        ..projectType = 'Villa'
        ..projectStatus = 'In Progress'
        ..city = 'Santa Monica, CA'
        ..area = 'Santa Monica'
        ..price = '\$39,999'
        ..imageUrl =
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=800&auto=format&fit=crop',
      ProjectModel()
        ..projectName = 'Harmony Villa'
        ..projectType = 'Villa'
        ..projectStatus = 'In Progress'
        ..city = 'Newport Beach, CA'
        ..area = 'Newport Beach'
        ..price = '\$59,999'
        ..imageUrl =
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?q=80&w=800&auto=format&fit=crop',
    ];

    state = sampleProjects;
  }

  void addProject(ProjectModel project) {
    state = [...state, project];

    // Print the current state for debugging
    print('Added project: ${project.projectName}');
    print('Total projects: ${state.length}');
  }

  void updateProject(int index, ProjectModel project) {
    state = [...state.sublist(0, index), project, ...state.sublist(index + 1)];
  }

  void deleteProject(int index) {
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
  }

  List<ProjectModel> getProjectsByLocation(String location) {
    return state.where((project) => project.area == location).toList();
  }
}

final projectProvider =
    StateNotifierProvider<ProjectNotifier, List<ProjectModel>>((ref) {
      return ProjectNotifier();
    });

final projectStatsProvider = Provider<List<PropertyStats>>((ref) {
  final projects = ref.watch(projectProvider);

  // Debug output
  print('Building project stats for ${projects.length} projects');

  if (projects.isEmpty) {
    print('No projects found');
    return [];
  }

  // Group projects by project type and location
  final Map<String, Map<String, List<ProjectModel>>> groupedProjects = {};

  for (var project in projects) {
    final type = project.projectType ?? 'Other';
    final location = project.area ?? 'Unknown';

    if (!groupedProjects.containsKey(location)) {
      groupedProjects[location] = {};
    }

    if (!groupedProjects[location]!.containsKey(type)) {
      groupedProjects[location]![type] = [];
    }

    groupedProjects[location]![type]!.add(project);
  }

  // Convert to PropertyStats list
  final List<PropertyStats> stats = [];

  groupedProjects.forEach((location, types) {
    types.forEach((type, projects) {
      // Count projects by status (simplified - you'll need to adjust based on your actual status field)
      final completed = projects
          .where((p) => p.projectStatus == 'Completed')
          .length;
      final inProgress = projects
          .where((p) => p.projectStatus == 'In Progress')
          .length;
      final readyToStart = projects
          .where((p) => p.projectStatus == 'Ready to Start')
          .length;

      // Map project types to icons
      final iconData = _getIconForProjectType(type);
      final color = _getColorForProjectType(type);

      if (type.isNotEmpty && location.isNotEmpty) {
        // Debug print to check city values
        final project = projects.first;
        print('Project city: ${project.city}, location: $location');

        // Use the first project's city, or fall back to location if city is not available
        final city = project.city?.isNotEmpty == true
            ? project.city!
            : location;

        stats.add(
          PropertyStats(
            name: type,
            completed: completed,
            inProgress: inProgress,
            readyToStart: readyToStart,
            icon: iconData,
            color: color,
            location: location,
            city: city,
          ),
        );

        print('Created PropertyStats with city: $city');

        print(
          'Added stat for $type in $location: C:$completed, P:$inProgress, R:$readyToStart',
        );
      }
    });
  });

  return stats;
});

IconData _getIconForProjectType(String type) {
  switch (type.toLowerCase()) {
    case 'villa':
      return Icons.villa;
    case 'apartment':
    case 'flat':
      return Icons.apartment;
    case 'commercial':
      return Icons.business;
    case 'individual':
      return Icons.person;
    case 'group housing':
      return Icons.groups;
    case 'industrial':
      return Icons.factory;
    default:
      return Icons.home;
  }
}

Color _getColorForProjectType(String type) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.pink,
    Colors.blueGrey,
  ];

  final index = type.hashCode % colors.length;
  return colors[index];
}
