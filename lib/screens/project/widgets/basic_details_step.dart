// ignore_for_file: use_super_parameters, library_private_types_in_public_api, deprecated_member_use

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
  final List<String> _projectTypes = [
    'Community',
    'Villa',
    'Building',
    'Flat',
    'Individual',
    'Group housing',
    'Industrial',
    'Business',
    'Commercial complex',
    'SEZ',
    'Small house',
    'Farm house',
    'Stadium',
    'Parks',
    'Government',
    'Residential',
    'Commercial',
    'Infrastructure',
    'Others',
  ];
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
            // Project Type (Required)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project Type *',
                  style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.projectData.projectType == null || 
                             widget.projectData.projectType!.isEmpty
                          ? Colors.red
                          : Colors.grey.shade400,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      style: const TextStyle(fontSize: 13, color: Colors.black, height: 1.0),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a project type';
                        }
                        return null;
                      },
                      hint: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          'Select project type',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      value: widget.projectData.projectType,
                      items: _projectTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              type,
                              style: const TextStyle(fontSize: 13, color: Colors.black),
                            ),
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
                ),
                if (widget.projectData.projectType == null || 
                    widget.projectData.projectType!.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 4.0),
                    child: Text(
                      'Please select a project type',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // Date fields in a row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Construction Start Date (Optional)
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 13, height: 1.0),
                      decoration: const InputDecoration(
                        labelText: 'Start Date',
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
                ),
                const SizedBox(width: 12),
                // Expected Completion Date (Optional)
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      style: const TextStyle(fontSize: 13, height: 1.0),
                      decoration: const InputDecoration(
                        labelText: 'End Date',
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
                ),
              ],
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
            // Project Status (Radio Buttons)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project Status *',
                  style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _projectStatuses.map((status) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.projectData.projectStatus = status;
                          widget.onChanged(widget.projectData);
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: status,
                            groupValue: widget.projectData.projectStatus,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  widget.projectData.projectStatus = value;
                                  widget.onChanged(widget.projectData);
                                });
                              }
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Text(
                            status,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate() &&
                    (widget.projectData.projectStatus == null || widget.projectData.projectStatus!.isEmpty))
                  const Text(
                    'Project status is required',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
            const SizedBox(height:0,)
          ],
        ),
      ),
    );
  }
}
