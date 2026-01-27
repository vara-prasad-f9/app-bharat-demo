// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bharatplus/models/project_model.dart';
import 'package:bharatplus/providers/project_provider.dart';
import 'package:bharatplus/screens/project/widgets/basic_details_step.dart';
import 'package:bharatplus/screens/project/widgets/location_details_step.dart';
import 'package:bharatplus/screens/project/widgets/owner_details_step.dart';
import 'package:bharatplus/screens/project/widgets/review_step.dart';

class AddProjectScreen extends ConsumerStatefulWidget {
  const AddProjectScreen({super.key});

  @override
  ConsumerState<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends ConsumerState<AddProjectScreen> {
  final ProjectModel _projectData = ProjectModel();
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = List.generate(4, (_) => GlobalKey<FormState>());

  @override
  void initState() {
    super.initState();
    // Initialize city with default value
    _projectData.city = 'Visakhapatnam';
  }

  final List<Map<String, dynamic>> _steps = [
    {'title': 'Step 1', 'subtitle': 'Enter project basic information'},
    {'title': 'Step 2', 'subtitle': 'Add project location details'},
    {'title': 'Step 3', 'subtitle': 'Enter owner information'},
    {'title': 'Step 4', 'subtitle': 'Review and submit project'},
  ];

 bool get _isNextButtonEnabled {
  // Get the current form state
  final formState = _formKeys[_currentStep].currentState;
  
  // If form state is null, button should be disabled
  if (formState == null) return false;
  
  // For the first step, check project name, type, and status
  if (_currentStep == 0) {
    final hasRequiredFields = _projectData.projectName?.trim().isNotEmpty == true &&
                            _projectData.projectType?.isNotEmpty == true &&
                            _projectData.projectStatus?.isNotEmpty == true;
    
    // Also validate the form to show any validation errors
    if (formState.mounted) {
      formState.validate();
    }
    
    return hasRequiredFields;
  }
  
  // For location step (index 1), manually validate required fields
  if (_currentStep == 1) {
    final hasCity = _projectData.city?.trim().isNotEmpty == true;
    final hasArea = _projectData.area?.trim().isNotEmpty == true;
    
    // Also validate the form to show any validation errors
    if (formState.mounted) {
      formState.validate();
    }
    
    return hasCity && hasArea;
  }
  
  // For owner details step (index 2), manually validate required fields
  if (_currentStep == 2) {
    final hasOwnerName = _projectData.ownerName?.trim().isNotEmpty == true;
    
    // Also validate the form to show any validation errors
    if (formState.mounted) {
      formState.validate();
    }
    
    return hasOwnerName;
  }
  
  // For other steps, use form validation
  return formState.validate();
}

  void _nextStep() {
    // Get the current form state
    final formState = _formKeys[_currentStep].currentState;
    
    // If form state is null, return early
    if (formState == null) return;

    // Validate the form and check if all required fields are filled
    if (formState.validate() && _isNextButtonEnabled) {
      if (_currentStep < _steps.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _submitForm();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onStepTapped(int step) {
    if (step < _currentStep) {
      _pageController.jumpToPage(step);
    }
  }

  void _submitForm() {
    try {
      // Get the project provider
      final projectNotifier = ref.read(projectProvider.notifier);
      
      // Set default values for required fields
      final now = DateTime.now();
      
      // Create a new project instance with all required fields
      final projectToAdd = ProjectModel()
        ..projectName = _projectData.projectName ?? 'New Project'
        ..projectCode = _projectData.projectCode ?? 'PRJ-${now.millisecondsSinceEpoch}'
        ..projectType = _projectData.projectType ?? 'Residential'
        ..constructionStartDate = _projectData.constructionStartDate ?? now
        ..expectedCompletionDate = _projectData.expectedCompletionDate ?? now.add(const Duration(days: 365))
        ..currentStage = _projectData.currentStage ?? 'Planning'
        ..projectStatus = _projectData.projectStatus ?? 'In Progress'
        ..country = _projectData.country
        ..state = _projectData.state
        ..city = _projectData.city
        ..area = _projectData.area
        ..pincode = _projectData.pincode;
      
      // Add the project to the provider
      projectNotifier.addProject(projectToAdd);
      
      // Show success message and navigate back
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project created successfully!')),
        );
        
        // Navigate back to home screen
        Navigator.of(context).pop(true); // Pass true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating project: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Column(
          children: [
            // Stepper Header with horizontal scrolling
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              height: 60, // Fixed height for the stepper
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _steps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    final isActive = index == _currentStep;
                    final isCompleted = index < _currentStep;
        
                    return Container(
                      width: 60, // Fixed width for each step
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => _onStepTapped(index),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isCompleted)
                              const Icon(
                                Icons.check_circle,
                                size: 24,
                                color: Colors.green,
                              )
                            else
                              SizedBox(
                                width: 60,
                                height: 24,
                               
                                child: Text(step['title'] as String, style: TextStyle(fontSize:  12, height: 2, color: isActive ? Colors.black : Theme.of(context).primaryColor)),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                ),
              ),
          
            
            // Progress Bar
            Container(
              margin: const EdgeInsets.only(bottom: 0),
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / _steps.length,
                backgroundColor: Colors.grey[200],
                minHeight: 4,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            
            // Step Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: [
                  // Step 1: Basic Details
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _formKeys[0],
                          child: BasicDetailsStep(
                            projectData: _projectData,
                            onChanged: (data) {
                              setState(() {
                                // Create a new instance with updated data
                                _projectData.copyWith(
                                  projectName: data.projectName,
                                  projectCode: data.projectCode,
                                  projectType: data.projectType,
                                  constructionStartDate: data.constructionStartDate,
                                  expectedCompletionDate: data.expectedCompletionDate,
                                  currentStage: data.currentStage,
                                  projectStatus: data.projectStatus,
                                );
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _currentStep == _steps.length - 1 
                          ? _buildReviewButtons() 
                          : _buildDefaultButtons(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  
                  // Step 2: Location Details
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _formKeys[1],
                          child: LocationDetailsStep(
                            projectData: _projectData,
                            onChanged: (data) {
                              setState(() {
                                _projectData.copyWith(
                                  country: data.country,
                                  state: data.state,
                                  district: data.district,
                                  city: data.city,
                                  area: data.area,
                                  landmark: data.landmark,
                                  pincode: data.pincode,
                                  fullAddress: data.fullAddress,
                                  latitude: data.latitude,
                                  longitude: data.longitude,
                                );
                              });
                              // Trigger form validation after state update
                              _formKeys[_currentStep].currentState?.validate();
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _currentStep == _steps.length - 1 
                          ? _buildReviewButtons() 
                          : _buildDefaultButtons(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  
                  // Step 3: Owner Details
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _formKeys[2],
                          child: OwnerDetailsStep(
                            projectData: _projectData,
                            onChanged: (data) {
                              // Update the project data
                              _projectData.ownerName = data.ownerName;
                              _projectData.ownerPhoneNumber = data.ownerPhoneNumber;
                              _projectData.ownerEmail = data.ownerEmail;
                              _projectData.supervisorName = data.supervisorName;
                              _projectData.supervisorPhoneNumber = data.supervisorPhoneNumber;
                              _projectData.watchmanName = data.watchmanName;
                              _projectData.watchmanPhoneNumber = data.watchmanPhoneNumber;
                              
                              // Trigger a rebuild and validate the form
                              if (mounted) {
                                setState(() {
                                  // The state update will trigger a rebuild
                                });
                                // Validate the form after the state has been updated
                                _formKeys[_currentStep].currentState?.validate();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _currentStep == _steps.length - 1 
                          ? _buildReviewButtons() 
                          : _buildDefaultButtons(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  
                  // Step 4: Review
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: _formKeys[3],
                          child: ReviewStep(
                            projectData: _projectData,
                            onChanged: (data) {
                              // Update project data if needed
                              setState(() {
                                // No need to update anything as this is just a review step
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _currentStep == _steps.length - 1 
                          ? _buildReviewButtons() 
                          : _buildDefaultButtons(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Navigation Buttons will be inside each step's content
          ],
        ),
      ),
    );
  }


  Widget _buildDefaultButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Back Button (only shown when not on first step)
          if (_currentStep > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  'BACK',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 8), // Reduced space between buttons
          ],
          // Cancel Button (only shown on first step)
          if (_currentStep == 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Navigate back to home page
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8), // Space between buttons
          ] else ...[
            // Empty widget when not on first step
            const SizedBox.shrink(),
          ],
          // Next Button
          Expanded(
            child: ElevatedButton(
              onPressed: _isNextButtonEnabled ? _nextStep : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              // Back Button
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side:  BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  child: Text(
                    'BACK',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Save as Draft Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                 
                    _submitForm();
                  },
                  icon: const Icon(Icons.save_outlined, size: 20),
                  label: const Text('SAVE'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isNextButtonEnabled ? _nextStep : null,
              icon: const Icon(Icons.check_circle_outline, size: 20),
              label: const Text('SUBMIT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}