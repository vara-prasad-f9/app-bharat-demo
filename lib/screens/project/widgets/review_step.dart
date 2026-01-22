// ignore_for_file: use_super_parameters

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Project Overview'),
          _buildInfoCard([
            _buildInfoItem('Project Name', widget.projectData.projectName ?? 'Not provided'),
            _buildInfoItem('Project Code', widget.projectData.projectCode ?? 'Not provided'),
            _buildInfoItem('Project Type', widget.projectData.projectType ?? 'Not provided'),
            _buildInfoItem('Status', widget.projectData.projectStatus ?? 'Not provided'),
            _buildInfoItem('Current Stage', widget.projectData.currentStage ?? 'Not provided'),
            _buildInfoItem('Start Date', widget.projectData.constructionStartDate?.toString().split(' ')[0] ?? 'Not provided'),
            _buildInfoItem('Expected Completion', widget.projectData.expectedCompletionDate?.toString().split(' ')[0] ?? 'Not provided'),
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
            _buildInfoItem('Owner Type', widget.projectData.ownerType ?? 'Not provided'),
            _buildInfoItem(
              widget.projectData.ownerType == 'Company' ? 'Company Name' : 'Owner Name',
              widget.projectData.ownerType == 'Company' 
                  ? widget.projectData.companyName ?? 'Not provided'
                  : widget.projectData.ownerName ?? 'Not provided',
            ),
            _buildInfoItem('Mobile', widget.projectData.mobileNumber ?? 'Not provided'),
            if (widget.projectData.alternateMobileNumber?.isNotEmpty ?? false)
              _buildInfoItem('Alternate Mobile', widget.projectData.alternateMobileNumber!),
            if (widget.projectData.email?.isNotEmpty ?? false)
              _buildInfoItem('Email', widget.projectData.email!),
          ]),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Construction Details'),
          _buildInfoCard([
            if (widget.projectData.totalPlotArea != null)
              _buildInfoItem('Total Plot Area', '${widget.projectData.totalPlotArea} sq.ft'),
            if (widget.projectData.builtUpArea != null)
              _buildInfoItem('Built-up Area', '${widget.projectData.builtUpArea} sq.ft'),
            if (widget.projectData.numberOfFloors != null)
              _buildInfoItem('Number of Floors', '${widget.projectData.numberOfFloors}'),
            if (widget.projectData.constructionMethod?.isNotEmpty ?? false)
              _buildInfoItem('Construction Method', widget.projectData.constructionMethod!),
            if (widget.projectData.estimatedBudget != null)
              _buildInfoItem('Estimated Budget', '₹${widget.projectData.estimatedBudget?.toStringAsFixed(2)}'),
            if (widget.projectData.projectPriority?.isNotEmpty ?? false)
              _buildInfoItem('Priority', widget.projectData.projectPriority!),
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
          
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isSaving || _isSubmitting ? null : _saveAsDraft,
                  icon: _isSaving 
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined, size: 20),
                  label: const Text('SAVE AS DRAFT'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isSaving || _isSubmitting ? null : _submitProject,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.check_circle_outline, size: 20),
                  label: const Text('SUBMIT PROJECT', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
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

  Future<void> _saveAsDraft() async {
    setState(() => _isSaving = true);
    
    try {
    
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project saved as draft')),
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
