// ignore_for_file: use_super_parameters, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:bharatplus/models/project_model.dart';


class ReviewStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const ReviewStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ReviewStep> createState() => _ReviewStepState();
}

class _ReviewStepState extends State<ReviewStep> {
  bool _isSaving = false;
  bool _isSubmitting = false;
  
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Project Overview'),
          _buildInfoCard([
            _buildInfoItem('Project Name', widget.projectData.projectName ?? 'Not provided'),
            _buildInfoItem('Project Type', widget.projectData.projectType ?? 'Not provided'),
            _buildInfoItem('Status', widget.projectData.projectStatus ?? 'Not provided'),
            _buildInfoItem('Current Stage', widget.projectData.currentStage ?? 'Not provided'),
          ]),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Location Details'),
          _buildInfoCard([
            _buildInfoItem('Address', widget.projectData.fullAddress ?? 'Not provided'),
            _buildInfoItem('Area', widget.projectData.area ?? 'Not provided'),
            _buildInfoItem('City', widget.projectData.city ?? 'Not provided'),
            _buildInfoItem('State', widget.projectData.state ?? 'Not provided'),
            _buildInfoItem('Pincode', widget.projectData.pincode ?? 'Not provided'),
            _buildInfoItem('Landmark', widget.projectData.landmark ?? 'Not provided'),
          ]),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Owner Details'),
          _buildInfoCard([
            _buildInfoItem('Owner Name', widget.projectData.ownerName ?? 'Not provided'),
            if (widget.projectData.ownerPhoneNumber?.isNotEmpty ?? false)
              _buildInfoItem('Owner Phone', widget.projectData.ownerPhoneNumber!),
            if (widget.projectData.ownerEmail?.isNotEmpty ?? false)
              _buildInfoItem('Owner Email', widget.projectData.ownerEmail!),
          ]),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Supervisor Details'),
          _buildInfoCard([
            if (widget.projectData.supervisorName?.isNotEmpty ?? false)
              _buildInfoItem('Supervisor Name', widget.projectData.supervisorName!),
            if (widget.projectData.supervisorPhoneNumber?.isNotEmpty ?? false)
              _buildInfoItem('Supervisor Phone', widget.projectData.supervisorPhoneNumber!),
          ]),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Watchman Details'),
          _buildInfoCard([
            if (widget.projectData.watchmanName?.isNotEmpty ?? false)
              _buildInfoItem('Watchman Name', widget.projectData.watchmanName!),
            if (widget.projectData.watchmanPhoneNumber?.isNotEmpty ?? false)
              _buildInfoItem('Watchman Phone', widget.projectData.watchmanPhoneNumber!),
          ]),
          
          
          if ((widget.projectData.assignedContractors?.isNotEmpty ?? false) || 
              (widget.projectData.assignedSuppliers?.isNotEmpty ?? false))
            ...[
              const SizedBox(height: 24),
              _buildSectionHeader('Team Assignment'),
              _buildInfoCard([
                if (widget.projectData.assignedContractors?.isNotEmpty ?? false)
                  _buildInfoItem(
                    'Contractors',
                    widget.projectData.assignedContractors!.join(', '),
                  ),
                if (widget.projectData.assignedSuppliers?.isNotEmpty ?? false)
                  _buildInfoItem(
                    'Suppliers',
                    widget.projectData.assignedSuppliers!.join(', '),
                  ),
              ]),
            ],
          
                ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _saveDraft() async {
    setState(() => _isSaving = true);
    try {
  
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Draft saved successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save draft: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _submitProject() async {
    setState(() => _isSubmitting = true);
    
    try {
  
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      if (mounted) {
        Navigator.of(context).pop(true); // Return success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit project: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
