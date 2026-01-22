// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/project_model.dart';

class BasicDetailsStep extends StatefulWidget {
  final ProjectModel projectData;
  final Function(ProjectModel) onChanged;

  const BasicDetailsStep({
    Key? key,
    required this.projectData,
    required this.onChanged,
  }) : super(key: key);

  @override
  _BasicDetailsStepState createState() => _BasicDetailsStepState();
}

class _BasicDetailsStepState extends State<BasicDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _projectTypes = ['Residential', 'Commercial', 'Industrial', 'Infrastructure'];
  final List<String> _projectStages = [
    'Planning',
    'Foundation',
    'Structure',
    'Brick Work',
    'Finishing',
    'Completed'
  ];
  final List<String> _projectStatuses = ['Active', 'On Hold', 'Completed'];

  @override
  void initState() {
    super.initState();
    if (widget.projectData.projectName != null) {
      _formKey.currentState?.validate();
    }
  }

  @override
  void didUpdateWidget(covariant BasicDetailsStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.projectData != oldWidget.projectData) {
      _formKey.currentState?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Basic Project Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Project Name (Required)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project Name *',
                border: OutlineInputBorder(),
                hintText: 'Enter project name',
              ),
              initialValue: widget.projectData.projectName,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Project name is required';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.projectData.projectName = value.trim();
                  widget.onChanged(widget.projectData);
                });
              },
            ),
            const SizedBox(height: 16),
            // Project Code / ID (Optional)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project Code / ID',
                border: OutlineInputBorder(),
                hintText: 'Auto-generated / Manual',
              ),
              initialValue: widget.projectData.projectCode,
              onChanged: (value) {
                setState(() {
                  widget.projectData.projectCode = value;
                  widget.onChanged(widget.projectData);
                });
              },
            ),
            const SizedBox(height: 16),
            // Project Type (Optional)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Project Type',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Select project type'),
              initialValue: widget.projectData.projectType,
              items: _projectTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.projectData.projectType = value;
                  widget.onChanged(widget.projectData);
                });
              },
            ),
            const SizedBox(height: 16),
            // Construction Start Date (Optional)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Construction Start Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              controller: TextEditingController(
                text: widget.projectData.constructionStartDate != null
                    ? DateFormat('MMM dd, yyyy').format(widget.projectData.constructionStartDate!)
                    : '',
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: widget.projectData.constructionStartDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    widget.projectData.constructionStartDate = date;
                    widget.onChanged(widget.projectData);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            // Expected Completion Date (Optional)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Expected Completion Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              controller: TextEditingController(
                text: widget.projectData.expectedCompletionDate != null
                    ? DateFormat('MMM dd, yyyy').format(widget.projectData.expectedCompletionDate!)
                    : '',
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: widget.projectData.expectedCompletionDate ?? DateTime.now().add(const Duration(days: 30)),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    widget.projectData.expectedCompletionDate = date;
                    widget.onChanged(widget.projectData);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            // Current Stage (Optional)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Current Stage',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Select current stage'),
              initialValue: widget.projectData.currentStage,
              items: _projectStages.map((stage) {
                return DropdownMenuItem(
                  value: stage,
                  child: Text(stage),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.projectData.currentStage = value;
                  widget.onChanged(widget.projectData);
                });
              },
            ),
            const SizedBox(height: 16),
            // Project Status (Optional)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Project Status',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Select project status'),
              initialValue: widget.projectData.projectStatus,
              items: _projectStatuses.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.projectData.projectStatus = value;
                  widget.onChanged(widget.projectData);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
