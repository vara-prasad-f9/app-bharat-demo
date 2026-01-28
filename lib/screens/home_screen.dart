import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharatplus/screens/layout/main_layout.dart';
import 'package:bharatplus/screens/layout/custom_bottombar.dart';
import 'package:bharatplus/screens/project/steps/add_project_screen.dart';
import 'package:bharatplus/providers/project_provider.dart';
import 'package:bharatplus/models/project_model.dart';
import 'package:bharatplus/screens/project/project_details_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  final List<BottomNavItem> _bottomNavItems = const [
    BottomNavItem(icon: 'dashboard', label: 'Dashboard', index: 0),
    BottomNavItem(icon: 'projects', label: 'Projects', index: 1),
    BottomNavItem(icon: 'visits', label: 'Visits', index: 2),
    BottomNavItem(icon: 'profile', label: 'Profile', index: 3),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  Widget _buildProjectCard(ProjectModel project) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.work_outline, size: 30),
        ),
        title: Text(
          project.projectName ?? 'Unnamed Project',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(project.city ?? 'No location'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProjectDetailsScreen(project: project),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectList(List<ProjectModel> projects) {
    if (projects.isEmpty) {
      return const Center(
        child: Text('No projects found'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(projects[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(projectProvider);

    return MainLayout(
      title: 'Projects',
      showBottomNav: true,
      bottomNavItems: _bottomNavItems,
      currentBottomNavIndex: _currentIndex,
      onBottomNavTap: _onItemTapped,
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              tabs: const [
                Tab(text: 'In Progress'),
                Tab(text: 'On Hold'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // In Progress Projects Tab
                _buildProjectList(
                  projects.where((p) => p.projectStatus == 'In Progress').toList(),
                ),
                // On Hold Projects Tab
                _buildProjectList(
                  projects.where((p) => p.projectStatus == 'On Hold').toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}