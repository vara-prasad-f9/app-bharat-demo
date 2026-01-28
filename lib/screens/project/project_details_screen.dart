import 'package:flutter/material.dart';
import 'package:bharatplus/models/project_model.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.projectName ?? 'Project Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.work_outline, size: 36),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.projectName ?? 'Unnamed Project',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                project.projectType ?? 'No type specified',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Status Chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(project.projectStatus ?? ''),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        project.projectStatus ?? 'No Status',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Project Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Project Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.location_on, 'Location', 
                        '${project.city ?? 'N/A'}${project.area != null ? ', ${project.area}' : ''}'),
                    _buildDetailRow(Icons.assessment, 'Current Stage', 
                        project.currentStage ?? 'N/A'),
                    _buildDetailRow(Icons.code, 'Project Code', 
                        project.projectCode ?? 'N/A'),
                    _buildDetailRow(Icons.calendar_today, 'Construction Start Date', 
                        project.constructionStartDate != null 
                            ? _formatDate(project.constructionStartDate!) 
                            : 'N/A'),
                    _buildDetailRow(Icons.event, 'Expected Completion Date', 
                        project.expectedCompletionDate != null 
                            ? _formatDate(project.expectedCompletionDate!) 
                            : 'N/A'),
                    _buildDetailRow(Icons.public, 'Country', 
                        project.country.isNotEmpty ? project.country : 'N/A'),
                    _buildDetailRow(Icons.map, 'State', 
                        project.state ?? 'N/A'),
                    _buildDetailRow(Icons.location_city, 'District', 
                        project.district ?? 'N/A'),
                    _buildDetailRow(Icons.place, 'Landmark', 
                        project.landmark ?? 'N/A'),
                    _buildDetailRow(Icons.mail, 'Pincode', 
                        project.pincode ?? 'N/A'),
                    _buildDetailRow(Icons.home, 'Full Address', 
                        project.fullAddress ?? 'N/A'),
                    _buildDetailRow(Icons.gps_fixed, 'Coordinates', 
                        (project.latitude != null && project.longitude != null) 
                            ? '${project.latitude!.toStringAsFixed(6)}, ${project.longitude!.toStringAsFixed(6)}'
                            : 'N/A'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Owner Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Owner Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.person, 'Name', project.ownerName ?? 'N/A'),
                    _buildDetailRow(Icons.phone, 'Phone', project.ownerPhoneNumber ?? 'N/A'),
                    _buildDetailRow(Icons.email, 'Email', project.ownerEmail ?? 'N/A'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Supervisor Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Supervisor Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.person, 'Name', project.supervisorName ?? 'N/A'),
                    _buildDetailRow(Icons.phone, 'Phone', project.supervisorPhoneNumber ?? 'N/A'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Watchman Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Watchman Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.person, 'Name', project.watchmanName ?? 'N/A'),
                    _buildDetailRow(Icons.phone, 'Phone', project.watchmanPhoneNumber ?? 'N/A'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
}
