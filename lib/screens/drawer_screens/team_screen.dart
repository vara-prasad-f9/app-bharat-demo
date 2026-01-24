import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Team'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTeamMember(
            context,
            name: 'John Doe',
            role: 'CEO & Founder',
            description: 'With over 10 years of experience in property management, John leads our team with vision and dedication.',
          ),
          const SizedBox(height: 16),
          _buildTeamMember(
            context,
            name: 'Jane Smith',
            role: 'CTO',
            description: 'Technology expert with a passion for creating seamless user experiences.',
          ),
          const SizedBox(height: 16),
          _buildTeamMember(
            context,
            name: 'Alex Johnson',
            role: 'Head of Operations',
            description: 'Ensuring smooth operations and customer satisfaction.',
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(
    BuildContext context, {
    required String name,
    required String role,
    required String description,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              role,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
