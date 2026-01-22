// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

class BasicDetailsStep extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const BasicDetailsStep({
    Key? key,
    required this.onSaved,
    this.initialData,
  }) : super(key: key);

  @override
  _BasicDetailsStepState createState() => _BasicDetailsStepState();
}

class _BasicDetailsStepState extends State<BasicDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _projectNameController;
  late TextEditingController _projectCodeController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedProjectType;

  @override
  void initState() {
    super.initState();
    _projectNameController = TextEditingController(text: widget.initialData?['projectName'] ?? '');
    _projectCodeController = TextEditingController(text: widget.initialData?['projectCode'] ?? '');
    _startDateController = TextEditingController(
      text: widget.initialData?['constructionStartDate'] ?? '',
    );
    _endDateController = TextEditingController(
      text: widget.initialData?['expectedCompletionDate'] ?? '',
    );
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSaved({
        'projectName': _projectNameController.text,
        'projectCode': _projectCodeController.text,
        'constructionStartDate': _startDateController.text,
        'expectedCompletionDate': _endDateController.text,
      });
    }
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _projectCodeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        _startDateController.text = _formatDate(picked);
        _saveForm();
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? (_startDate ?? DateTime.now()),
      firstDate: _startDate ?? DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
        _endDateController.text = _formatDate(picked);
        _saveForm();
      });
    }
  }

  Widget _buildProjectTypeChip(String label, IconData icon) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: _selectedProjectType == label,
      onSelected: (selected) {
        setState(() {
          _selectedProjectType = selected ? label : null;
          _saveForm();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _saveForm,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Basic Project Details',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _projectNameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter project name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _projectCodeController,
              decoration: const InputDecoration(
                labelText: 'Project Code / ID',
                border: OutlineInputBorder(),
                hintText: 'Will be auto-generated if left empty',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _startDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Start Date',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectStartDate,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select start date';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _endDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Expected Completion Date',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectEndDate,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select end date';
                }
                if (_startDate != null && _endDate != null && _endDate!.isBefore(_startDate!)) {
                  return 'End date must be after start date';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Project Type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                _buildProjectTypeChip('Residential', Icons.home),
                _buildProjectTypeChip('Commercial', Icons.business),
                _buildProjectTypeChip('Industrial', Icons.factory),
                _buildProjectTypeChip('Infrastructure', Icons.architecture),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
