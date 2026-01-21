// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bharatplus/providers/project_form_provider.dart';
import 'package:bharatplus/models/project_model.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectFormProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Review Project Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Basic Information'),
          _buildInfoCard([
            _buildInfoRow('Project Name', projectProvider.project.projectName.isNotEmpty ? projectProvider.project.projectName : 'Not provided'),
            _buildInfoRow('Project Code', projectProvider.project.projectCode?.isNotEmpty == true ? projectProvider.project.projectCode! : 'Auto-generated'),
            _buildInfoRow('Project Type', projectProvider.project.projectType.toString().split('.').last),
            _buildInfoRow('Start Date', '${projectProvider.project.constructionStartDate.day}/${projectProvider.project.constructionStartDate.month}/${projectProvider.project.constructionStartDate.year}'),
            _buildInfoRow('Expected Completion', '${projectProvider.project.expectedCompletionDate.day}/${projectProvider.project.expectedCompletionDate.month}/${projectProvider.project.expectedCompletionDate.year}'),
            _buildInfoRow('Current Stage', projectProvider.project.currentStage.toString().split('.').last),
            _buildInfoRow('Status', projectProvider.project.projectStatus.toString().split('.').last),
          ]),
          
          const SizedBox(height: 16),
          _buildSectionHeader('Location Details'),
          _buildInfoCard([
            _buildInfoRow('Address', _buildAddress(projectProvider)),
            _buildInfoRow('GPS Location', _buildGpsLocation(projectProvider)),
          ]),
          
          const SizedBox(height: 16),
          _buildSectionHeader('Owner Details'),
          _buildInfoCard([
            _buildInfoRow('Owner Name', projectProvider.project.ownerFullName.isNotEmpty ? projectProvider.project.ownerFullName : 'Not provided'),
            if (projectProvider.project.ownerType == OwnerType.company)
              _buildInfoRow('Company', projectProvider.project.companyName?.isNotEmpty == true ? projectProvider.project.companyName! : 'Not provided'),
            _buildInfoRow('Contact', projectProvider.project.mobileNumber.isNotEmpty ? projectProvider.project.mobileNumber : 'Not provided'),
            if (projectProvider.project.email?.isNotEmpty ?? false)
              _buildInfoRow('Email', projectProvider.project.email!),
          ]),
          
          const SizedBox(height: 16),
          _buildSectionHeader('Construction Details'),
          _buildInfoCard([
            _buildInfoRow('Plot Area', '${projectProvider.project.totalPlotArea} sq.ft'),
            _buildInfoRow('Built-up Area', '${projectProvider.project.builtUpArea} sq.ft'),
            _buildInfoRow('Number of Floors', '${projectProvider.project.numberOfFloors}'),
            _buildInfoRow('Construction Method', projectProvider.project.constructionMethod.toString().split('.').last),
            _buildInfoRow('Estimated Budget', '₹${projectProvider.project.estimatedBudget}'),
            _buildInfoRow('Priority', projectProvider.project.projectPriority.toString().split('.').last),
          ]),
          
          const SizedBox(height: 24),
          const Text(
            'By submitting, you confirm that all the information provided is accurate to the best of your knowledge.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Save as draft
                    Navigator.pop(context);
                  },
                  child: const Text('Save as Draft'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Submit the project
                    _submitProject(context, projectProvider);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit Project'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(':  '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildAddress(ProjectFormProvider provider) {
    final project = provider.project;
    final addressParts = [
      project.fullAddress,
      project.area,
      project.city,
      project.state,
      project.pincode,
    ].where((part) => part != null && part.isNotEmpty).toList();
    
    return addressParts.join(', ');
  }

  String _buildGpsLocation(ProjectFormProvider provider) {
    final project = provider.project;
    if (project.latitude != 0.0 && project.longitude != 0.0) {
      return '${project.latitude.toStringAsFixed(6)}, ${project.longitude.toStringAsFixed(6)}';
    }
    return 'Not available';
  }

  void _submitProject(BuildContext context, ProjectFormProvider provider) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Project created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to projects list
        Navigator.of(context).pop(true); // true indicates success
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating project: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
