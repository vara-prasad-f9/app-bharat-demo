import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'steps/basic_details_step.dart';

// Define a simple owner details step widget for now
class OwnerDetailsStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const OwnerDetailsStep({
    super.key,
    required this.onSaved,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Owner Details Step - To be implemented'),
    );
  }
}

// Define a simple location details step widget for now
class LocationDetailsStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const LocationDetailsStep({
    super.key,
    required this.onSaved,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Location Details Step - To be implemented'),
    );
  }
}

// Define a simple construction details step widget for now
class ConstructionDetailsStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const ConstructionDetailsStep({
    super.key,
    required this.onSaved,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Construction Details Step - To be implemented'),
    );
  }
}

// Define a simple assignment details step widget for now
class AssignmentDetailsStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const AssignmentDetailsStep({
    super.key,
    required this.onSaved,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Assignment Details Step - To be implemented'),
    );
  }
}

// Define a simple documentation step widget for now
class DocumentationStep extends StatelessWidget {
  final Function(Map<String, dynamic>) onSaved;
  final Map<String, dynamic>? initialData;
  
  const DocumentationStep({
    super.key,
    required this.onSaved,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Documentation Step - To be implemented'),
    );
  }
}

// Define a simple review step widget for now
class ReviewStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  
  const ReviewStep({
    super.key,
    required this.formData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review Your Project',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('Project Name: ${formData['projectName'] ?? 'Not provided'}'),
          Text('Project Code: ${formData['projectCode'] ?? 'Not provided'}'),
          Text('Start Date: ${formData['constructionStartDate'] ?? 'Not provided'}'),
          Text('End Date: ${formData['expectedCompletionDate'] ?? 'Not provided'}'),
          const SizedBox(height: 16),
          const Text(
            'Please review all the information before submitting.\nYou can go back to previous steps to make changes.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class AddProjectScreen extends ConsumerStatefulWidget {
  const AddProjectScreen({super.key});

  @override
  ConsumerState<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends ConsumerState<AddProjectScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Form data that will be collected across all steps
  final Map<String, dynamic> _formData = {
    'projectName': '',
    'projectCode': '',
    'constructionStartDate': '',
    'expectedCompletionDate': '',
    'projectType': '',
  };

  // List of all steps in the form
  late final List<Step> _steps = _buildSteps();

  List<Step> _buildSteps() {
    return [
      // Step 1: Basic Details
      Step(
        title: const Text('Basic'),
        content: BasicDetailsStep(
          onSaved: (data) => _formData.addAll(data),
        ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      // Step 2: Owner Details
      Step(
        title: const Text('Owner'),
        content: OwnerDetailsStep(
          onSaved: (data) => _formData.addAll(data),
        ),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      // Step 3: Location Details
      Step(
        title: const Text('Location'),
        content: LocationDetailsStep(
          onSaved: (data) => _formData.addAll(data),
        ),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      // Step 4: Construction Details
      Step(
        title: const Text('Construction'),
        content: ConstructionDetailsStep(
          onSaved: (data) => _formData.addAll(data),
        ),
        isActive: _currentStep >= 3,
        state: _currentStep > 3 ? StepState.complete : StepState.indexed,
      ),
      // Step 5: Assignment Details
      Step(
        title: const Text('Assignment'),
        content: AssignmentDetailsStep(
          onSaved: (data) => _formData.addAll(data),
        ),
        isActive: _currentStep >= 4,
        state: _currentStep > 4 ? StepState.complete : StepState.indexed,
      ),
      // Step 6: Documentation
      Step(
        title: const Text('Documents'),
        content: DocumentationStep(
          onSaved: (data) => _formData.addAll(data),
        ),
        isActive: _currentStep >= 5,
        state: _currentStep > 5 ? StepState.complete : StepState.indexed,
      ),
      // Step 7: Review
      Step(
        title: const Text('Review'),
        content: ReviewStep(formData: _formData),
        isActive: _currentStep >= 6,
        state: StepState.indexed,
      ),
    ];
  }

  void _onStepContinue() {
    // Save the current step's data
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      
      if (_currentStep < _steps.length - 1) {
        setState(() {
          _currentStep++;
        });
      } else {
        // Handle form submission
        debugPrint('Form submitted with data: $_formData');
        
        // Show success message and navigate back
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Project added successfully!')),
          );
          Navigator.of(context).pop();
        }
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Project'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: _onStepCancel,
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          steps: _steps,
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                      ),
                      child: const Text('BACK'),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        _currentStep == _steps.length - 1 ? 'SUBMIT' : 'NEXT',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}