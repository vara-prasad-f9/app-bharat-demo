class Role {
  final String id;
  final String name;
  final String description;
  final String icon;

  const Role({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  static List<Role> get roles => const [
        Role(
          id: 'admin',
          name: 'Admin',
          description: 'Full access to all features',
          icon: '👨‍💼',
        ),
        Role(
          id: 'contractor',
          name: 'Contractor',
          description: 'Manage projects and teams',
          icon: '👷',
        ),
        Role(
          id: 'supplier',
          name: 'Supplier',
          description: 'Manage inventory and supplies',
          icon: '🏭',
        ),
        Role(
          id: 'construction_team',
          name: 'Construction Team',
          description: 'Site Engineers / Workers',
          icon: '👷‍♂️',
        ),
      ];
}
