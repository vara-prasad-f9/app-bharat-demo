// ignore_for_file: use_super_parameters, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bharatplus/providers/project_form_provider.dart';
import 'package:bharatplus/screens/project/steps/basic_details_step.dart';
import 'package:bharatplus/screens/project/steps/location_details_step.dart';
import 'package:bharatplus/screens/project/steps/owner_details_step.dart';
import 'package:bharatplus/screens/project/steps/construction_details_step.dart';
import 'package:bharatplus/screens/project/steps/assignment_details_step.dart';
import 'package:bharatplus/screens/project/steps/documentation_step.dart';
import 'package:bharatplus/screens/project/steps/review_step.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectFormProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create New Project'),
          elevation: 0,
        ),
        body: Consumer<ProjectFormProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                _buildStepProgress(provider),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: PageView(
                      controller: provider.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        BasicDetailsStep(
                          onSaved: (data) {
                            // Update each field from the data map
                            data.forEach((key, value) {
                              provider.updateField(key, value);
                            });
                          },
                        ),
                        LocationDetailsStep(
                          onSaved: (data) {
                            data.forEach((key, value) {
                              provider.updateField(key, value);
                            });
                          },
                        ),
                        OwnerDetailsStep(
                          onSaved: (data) {
                            data.forEach((key, value) {
                              provider.updateField(key, value);
                            });
                          },
                        ),
                        ConstructionDetailsStep(
                          onSaved: (data) {
                            data.forEach((key, value) {
                              provider.updateField(key, value);
                            });
                          },
                        ),
                        AssignmentDetailsStep(
                          onSaved: (data) {
                            data.forEach((key, value) {
                              provider.updateField(key, value);
                            });
                          },
                        ),
                        DocumentationStep(
                          onSaved: (data) {
                            data.forEach((key, value) {
                              provider.updateField(key, value);
                            });
                          },
                        ),
                        const ReviewStep(),
                      ],
                    ),
                  ),
                ),
                _buildNavigationButtons(context, provider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepProgress(ProjectFormProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              return _buildStepCircle(
                step: index + 1,
                isActive: provider.currentStep == index,
                isCompleted: provider.currentStep > index,
                label: _getStepLabel(index),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            'Step ${provider.currentStep + 1} of 7: ${_getStepTitle(provider.currentStep)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle({
    required int step,
    required bool isActive,
    required bool isCompleted,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive || isCompleted
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    step.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isActive || isCompleted
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(
      BuildContext context, ProjectFormProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (provider.currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: provider.previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text('Back'),
              ),
            ),
          if (provider.currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                if (provider.currentStep < 6) {
                  // Validate current step before proceeding
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    provider.nextStep();
                  }
                } else {
                  // Submit the form
                  final success = await provider.submitForm();
                  if (success && mounted) {
                    Navigator.of(context).pop(true);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                provider.currentStep == 6 ? 'Submit' : 'Next',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Basic Details';
      case 1:
        return 'Location';
      case 2:
        return 'Owner Details';
      case 3:
        return 'Construction';
      case 4:
        return 'Assignments';
      case 5:
        return 'Documents';
      case 6:
        return 'Review';
      default:
        return '';
    }
  }

  String _getStepLabel(int index) {
    switch (index) {
      case 0:
        return 'Basic';
      case 1:
        return 'Location';
      case 2:
        return 'Owner';
      case 3:
        return 'Build';
      case 4:
        return 'Team';
      case 5:
        return 'Docs';
      case 6:
        return 'Review';
      default:
        return '';
    }
  }
}
