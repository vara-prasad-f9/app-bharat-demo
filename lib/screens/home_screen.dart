// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharatplus/screens/layout/main_layout.dart';
import 'package:bharatplus/screens/layout/custom_bottombar.dart';

class PropertyStats {
  final String name;
  final int completed;
  final int inProgress;
  final int readyToStart;
  final IconData icon;
  final Color color;
  final String location;

  PropertyStats({
    required this.name,
    required this.completed,
    required this.inProgress,
    required this.readyToStart,
    required this.icon,
    required this.color,
    required this.location,
  });
}

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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add button pressed')),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<LocationCategory> _getLocationCategories() {
    final allProperties = [
      PropertyStats(
        name: 'Community',
        completed: 4,
        inProgress: 2,
        readyToStart: 1,
        icon: Icons.people,
        color: Colors.blue,
        location: 'Vizag MVP',
      ),
      PropertyStats(
        name: 'Villa',
        completed: 3,
        inProgress: 1,
        readyToStart: 2,
        icon: Icons.villa,
        color: Colors.green,
        location: 'Vizag MVP',
      ),
      PropertyStats(
        name: 'Building',
        completed: 5,
        inProgress: 3,
        readyToStart: 2,
        icon: Icons.apartment,
        color: Colors.orange,
        location: 'Vizag MVP',
      ),
      PropertyStats(
        name: 'Flat',
        completed: 8,
        inProgress: 2,
        readyToStart: 3,
        icon: Icons.home_work,
        color: Colors.purple,
        location: 'Vizag Beach',
      ),
      PropertyStats(
        name: 'Individual',
        completed: 2,
        inProgress: 1,
        readyToStart: 0,
        icon: Icons.person,
        color: Colors.red,
        location: 'Vizag Beach',
      ),
      PropertyStats(
        name: 'Group Housing',
        completed: 3,
        inProgress: 2,
        readyToStart: 1,
        icon: Icons.groups,
        color: Colors.teal,
        location: 'Vizianagaram',
      ),
      PropertyStats(
        name: 'Industrial',
        completed: 4,
        inProgress: 1,
        readyToStart: 2,
        icon: Icons.factory,
        color: Colors.brown,
        location: 'Vizianagaram',
      ),
      PropertyStats(
        name: 'Business',
        completed: 2,
        inProgress: 1,
        readyToStart: 0,
        icon: Icons.business,
        color: Colors.indigo,
        location: 'Bhogapuram',
      ),
      PropertyStats(
        name: 'Commercial Complex',
        completed: 3,
        inProgress: 1,
        readyToStart: 1,
        icon: Icons.business_center,
        color: Colors.pink,
        location: 'Bhogapuram',
      ),
      PropertyStats(
        name: 'SEZ',
        completed: 1,
        inProgress: 0,
        readyToStart: 1,
        icon: Icons.business_outlined,
        color: Colors.blueGrey,
        location: 'Vizag MVP',
      ),
      PropertyStats(
        name: 'Small House',
        completed: 5,
        inProgress: 2,
        readyToStart: 1,
        icon: Icons.house,
        color: Colors.lightBlue,
        location: 'Vizag Beach',
      ),
      PropertyStats(
        name: 'Farm House',
        completed: 2,
        inProgress: 1,
        readyToStart: 0,
        icon: Icons.agriculture,
        color: Colors.lightGreen,
        location: 'Vizianagaram',
      ),
      PropertyStats(
        name: 'Stadium',
        completed: 1,
        inProgress: 0,
        readyToStart: 0,
        icon: Icons.stadium,
        color: Colors.deepPurple,
        location: 'Bhogapuram',
      ),
      PropertyStats(
        name: 'Parks',
        completed: 3,
        inProgress: 1,
        readyToStart: 1,
        icon: Icons.park,
        color: Colors.green,
        location: 'Vizag MVP',
      ),
      PropertyStats(
        name: 'Government',
        completed: 2,
        inProgress: 1,
        readyToStart: 1,
        icon: Icons.account_balance,
        color: Colors.redAccent,
        location: 'Vizianagaram',
      ),
    ];

    // Group properties by location
    final locationMap = <String, List<PropertyStats>>{};
    for (var property in allProperties) {
      locationMap.putIfAbsent(property.location, () => []).add(property);
    }

    // Create location categories
    return locationMap.entries.map((entry) {
      return LocationCategory(
        name: entry.key,
        properties: entry.value,
      );
    }).toList();
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
    final locationCategories = _getLocationCategories();
    
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
