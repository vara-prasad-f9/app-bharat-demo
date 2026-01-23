// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharatplus/screens/layout/main_layout.dart';
import 'package:bharatplus/screens/layout/custom_bottombar.dart';
import 'package:bharatplus/screens/project/steps/add_project_screen.dart';
import 'package:bharatplus/providers/project_provider.dart';
import 'package:bharatplus/models/property_stats.dart';

class LocationCategory {
  final String name;
  final List<PropertyStats> properties;
  bool isExpanded;

  LocationCategory({
    required this.name,
    required this.properties,
    this.isExpanded = true,
  });
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  final List<BottomNavItem> _bottomNavItems = const [
    BottomNavItem(icon: 'dashboard', label: 'Dashboard', index: 0),
    BottomNavItem(icon: 'projects', label: 'Projects', index: 1),
    BottomNavItem(icon: 'visits', label: 'Visits', index: 2),
    BottomNavItem(icon: 'profile', label: 'Profile', index: 3),
  ];

  void _onAddPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddProjectScreen(),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<LocationCategory> _getLocationCategories(List<PropertyStats> stats) {
    // Debug print to check incoming stats
    print('Total stats received: ${stats.length}');
    for (var stat in stats) {
      print('Stat - City: "${stat.city}", Location: "${stat.location}"');
    }
    
    // First, group properties by city
    final cityMap = <String, List<PropertyStats>>{};
    
    for (var property in stats) {
      // Use city if not empty, otherwise fall back to location
      final city = property.city.isNotEmpty 
          ? property.city 
          : (property.location.isNotEmpty ? property.location : 'Unknown Location');
          
      if (!cityMap.containsKey(city)) {
        print('Creating new city group: $city');
      }
      
      cityMap.putIfAbsent(city, () => []).add(property);
    }

    // Create location categories grouped by city
    final categories = cityMap.entries.map((entry) {
      print('Category created - Name: "${entry.key}" with ${entry.value.length} properties');
      return LocationCategory(
        name: entry.key,
        properties: entry.value,
      );
    }).toList();
    
    print('Total categories created: ${categories.length}');
    return categories;
  }

  Widget _buildPropertyCard(PropertyStats stats) {
    return Container(
   
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [



          
          Icon(
            stats.icon,
            size: 32,
            color: stats.color,
          ),

   Text(
            stats.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
             const SizedBox(height: 18),

          Row(
            children: [
   
              _buildStatChip('C:${stats.completed}', Colors.green),
              const SizedBox(width : 4),
              _buildStatChip('P:${stats.inProgress}', Colors.orange),
              const SizedBox(width : 4),
              _buildStatChip('R:${stats.readyToStart}', Colors.red),
            
            ],
          ),
       
        ],
      ),
    );
  }

  Widget _buildStatChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }
  
  
  Widget _buildLocationCategories(BuildContext context) {
    // Watch for changes in the project stats
    final statsAsync = ref.watch(projectStatsProvider);
    
    // Show loading indicator while data is being loaded
    if (statsAsync.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading projects...'),
          ],
        ),
      );
    }
    
    // Group projects by location
    final locationCategories = _getLocationCategories(statsAsync);
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Search Bar
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        // Location Categories
        ...locationCategories.map((category) {
          final properties = category.properties;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [






                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle view all
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View all',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 12, color: Theme.of(context).primaryColor),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    return _buildPropertyCard(properties[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Refresh the projects when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This will trigger a rebuild if the projects change
      ref.read(projectProvider);
    });
    
    return MainLayout(
      title: 'BharatPlus',
      showBottomNav: true,
      bottomNavItems: _bottomNavItems,
      currentBottomNavIndex: _currentIndex,
      onBottomNavTap: _onItemTapped,
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      child: _buildLocationCategories(context),
    );
  }
}
