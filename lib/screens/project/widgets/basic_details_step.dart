// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/project_model.dart';
import '../../../widgets/photo_picker.dart';

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
            Center(
              child: const Text(
                'Basic Project Details',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          
            const SizedBox(height: 16),
            // Project Name (Required)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Project Name *',
                  border: OutlineInputBorder(),
                  hintText: 'Enter project name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
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
            ),
              const SizedBox(height: 10),
            // Project Photo (Optional)
            PhotoPicker(
              initialPhotos: widget.projectData.sitePhotos,
              onPhotosChanged: (photos) {
                setState(() {
                  widget.projectData.sitePhotos = photos;
                  widget.onChanged(widget.projectData);
                });
              },
              maxPhotos: 5,
              
            ),
            const SizedBox(height: 16),
            // Project Code / ID (Optional)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Project Code / ID',
                  border: OutlineInputBorder(),
                  hintText: 'Auto-generated / Manual',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                initialValue: widget.projectData.projectCode,
                onChanged: (value) {
                  setState(() {
                    widget.projectData.projectCode = value;
                    widget.onChanged(widget.projectData);
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            // Project Type (Optional)
            SizedBox(
              height: 50,
              child: DropdownButtonFormField<String>(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Project Type',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
                ),
                hint: const Text('Select project type', style: TextStyle(fontSize: 13)),
                initialValue: widget.projectData.projectType,
                items: _projectTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(
                      type,
                      style: const TextStyle(color: Colors.black), // Set text color to black
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.projectData.projectType = value;
                    widget.onChanged(widget.projectData);
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            // Construction Start Date (Optional)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Construction Start Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 13),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
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
            ),
            const SizedBox(height: 12),
            // Expected Completion Date (Optional)
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  labelText: 'Expected Completion Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 13),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  labelStyle: TextStyle(fontSize: 13),
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
            ),
            const SizedBox(height: 16),
            // Current Stage (Optional)
            SizedBox(
              height: 50,
              child: DropdownButtonFormField<String>(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 13, height: 1.0),
                  labelText: 'Current Stage',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down, size: 16),
                ),
                hint: const Text('Select current stage'),
                initialValue: widget.projectData.currentStage,
                items: _projectStages.map((stage) {
                  return DropdownMenuItem(
                    value: stage,
                    child: Text(
                      stage,
                      style: const TextStyle(color: Colors.black), // Set text color to black
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.projectData.currentStage = value;
                    widget.onChanged(widget.projectData);
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            // Project Status (Optional)
            SizedBox(
              height: 50,
              child: DropdownButtonFormField<String>(
                style: const TextStyle(fontSize: 13, height: 1.0),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 13, height: 1.0),
                  labelText: 'Project Status',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down, size: 16),
                ),
                hint: const Text('Select project status'),
                initialValue: widget.projectData.projectStatus,
                items: _projectStatuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.black), // Set text color to black
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.projectData.projectStatus = value;
                    widget.onChanged(widget.projectData);
                  });
                },
              ),
            ),
            const SizedBox(height:0,)
          ],
        ),
      ),
    );
  }
}
