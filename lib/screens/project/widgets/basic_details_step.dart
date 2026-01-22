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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project Name *',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Project name is required' : null,
              onChanged: (value) {
                widget.projectData.projectName = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project Code / ID',
                border: OutlineInputBorder(),
                hintText: 'Auto-generated',
              ),
              readOnly: true,
              onChanged: (value) {
                widget.projectData.projectCode = value;
                widget.onChanged(widget.projectData);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Project Type *',
                border: OutlineInputBorder(),
              ),
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
              validator: (value) => value == null ? 'Please select project type' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start Date *',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: widget.projectData.constructionStartDate != null
                          ? DateFormat('dd/MM/yyyy').format(widget.projectData.constructionStartDate!)
                          : '',
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
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
                    validator: (value) => widget.projectData.constructionStartDate == null
                        ? 'Start date is required'
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Completion Date *',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: widget.projectData.expectedCompletionDate != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(widget.projectData.expectedCompletionDate!)
                          : '',
                    ),
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 30)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          widget.projectData.expectedCompletionDate = date;
                          widget.onChanged(widget.projectData);
                        });
                      }
                    },
                    validator: (value) => widget.projectData.expectedCompletionDate == null
                        ? 'Completion date is required'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Current Stage *',
                border: OutlineInputBorder(),
              ),
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
              validator: (value) => value == null ? 'Please select current stage' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Project Status *',
                border: OutlineInputBorder(),
              ),
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
              validator: (value) => value == null ? 'Please select project status' : null,
            ),
          ],
        ),
      ),
    );
  }
}
