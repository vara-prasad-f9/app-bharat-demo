// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bharatplus/providers/project_form_provider.dart';
import 'package:bharatplus/models/project_model.dart';

class BasicDetailsStep extends StatefulWidget {
  const BasicDetailsStep({Key? key}) : super(key: key);

  @override
  _BasicDetailsStepState createState() => _BasicDetailsStepState();
}

class _BasicDetailsStepState extends State<BasicDetailsStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _projectNameController;
  late TextEditingController _projectCodeController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProjectFormProvider>(context, listen: false);
    _projectNameController = TextEditingController(text: provider.project.projectName);
    _projectCodeController = TextEditingController(text: provider.project.projectCode);
    _startDateController = TextEditingController(
      text: _formatDate(provider.project.constructionStartDate),
    );
    _endDateController = TextEditingController(
      text: _formatDate(provider.project.expectedCompletionDate),
    );
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
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final provider = Provider.of<ProjectFormProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller == _startDateController
          ? provider.project.constructionStartDate
          : provider.project.expectedCompletionDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = _formatDate(picked);
        if (controller == _startDateController) {
          provider.updateField('constructionStartDate', picked);
        } else {
          provider.updateField('expectedCompletionDate', picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectFormProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Basic Project Details',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _projectNameController,
              decoration: const InputDecoration(
                labelText: 'Project Name *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter project name';
                }
                return null;
              },
              onSaved: (value) {
                provider.updateField('projectName', value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _projectCodeController,
              decoration: const InputDecoration(
                labelText: 'Project Code / ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.code),
                suffixIcon: Icon(Icons.auto_awesome_motion),
                hintText: 'Will be auto-generated if left empty',
              ),
              onSaved: (value) {
                provider.updateField('projectCode', value);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProjectType>(
              value: provider.project.projectType,
              decoration: const InputDecoration(
                labelText: 'Project Type *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: ProjectType.values.map((type) {
                return DropdownMenuItem<ProjectType>(
                  value: type,
                  child: Text(
                    type.toString().split('.').last[0].toUpperCase() +
                        type.toString().split('.').last.substring(1),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.updateField('projectType', value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _startDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Construction Start Date *',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () => _selectDate(context, _startDateController),
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
                labelText: 'Expected Completion Date *',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.event_available),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () => _selectDate(context, _endDateController),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select completion date';
                }
                // Additional validation: end date should be after start date
                if (provider.project.constructionStartDate
                    .isAfter(provider.project.expectedCompletionDate)) {
                  return 'Completion date must be after start date';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ConstructionStage>(
              value: provider.project.currentStage,
              decoration: const InputDecoration(
                labelText: 'Current Stage *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.construction),
              ),
              items: ConstructionStage.values.map((stage) {
                return DropdownMenuItem<ConstructionStage>(
                  value: stage,
                  child: Text(
                    stage.toString().split('.').last[0].toUpperCase() +
                        stage.toString().split('.').last.substring(1),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.updateField('currentStage', value);
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProjectStatus>(
              value: provider.project.projectStatus,
              decoration: const InputDecoration(
                labelText: 'Project Status *',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.info_outline),
              ),
              items: ProjectStatus.values.map((status) {
                return DropdownMenuItem<ProjectStatus>(
                  value: status,
                  child: Text(
                    status.toString().split('.').last[0].toUpperCase() +
                        status.toString().split('.').last.substring(1),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.updateField('projectStatus', value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
