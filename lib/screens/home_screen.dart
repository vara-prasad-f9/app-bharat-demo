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
  late String _selectedLocation;
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

  Widget _buildStatCard(PropertyStats stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.red!, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: stats.color.withAlpha(64),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(stats.icon, color: stats.color, size: 20,),
                      ),
                         const SizedBox(width: 16),
                          Text(
                    stats.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
           ],
         ),
   
     
         const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 _buildStatRow('Completed', stats.completed, Colors.green),
                  const SizedBox(width: 12),
                     _buildStatRow('In Progress', stats.inProgress, Colors.orange),
                  const SizedBox(width: 12),
                  _buildStatRow('Ready to Start', stats.readyToStart, Colors.blue),
                ],
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int count, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withAlpha(64),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
       
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedLocation = 'Vizag MVP';
  }
  
  Widget _buildLocationChips() {
    final locations = _getLocationCategories().map((e) => e.name).toList();
    
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          final isSelected = _selectedLocation == location;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedLocation = location;
              });
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.red : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: isSelected ? Colors.white : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[800],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 9,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildLocationCategories() {
    final locationCategories = _getLocationCategories();
    final selectedCategory = locationCategories.firstWhere(
      (cat) => cat.name == _selectedLocation,
      orElse: () => locationCategories.first,
    );
    
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          toolbarHeight: 105,
          flexibleSpace: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildLocationChips(),
              ),
              const SizedBox(height: 8),
            ],
          ),
          pinned: true,
          floating: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.5,
                mainAxisSpacing: 12,
              ),
              itemCount: selectedCategory.properties.length,
              itemBuilder: (context, index) {
                return _buildStatCard(selectedCategory.properties[index]);
              },
            ),
          ]),
        ),
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
        child: const Icon(Icons.add),
      ),
      child: _buildLocationCategories(),
    );
  }
}
