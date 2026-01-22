import 'package:flutter/material.dart';
import 'package:bharatplus/screens/layout/main_layout.dart';
import 'package:bharatplus/models/project_model.dart';
import 'package:bharatplus/screens/project/widgets/basic_details_step.dart';
import 'package:bharatplus/screens/project/widgets/location_details_step.dart';
import 'package:bharatplus/screens/project/widgets/owner_details_step.dart';
import 'package:bharatplus/screens/project/widgets/construction_details_step.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final ProjectModel _projectData = ProjectModel();
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = List.generate(7, (_) => GlobalKey<FormState>());

  final List<Map<String, dynamic>> _steps = [
    {'title': 'Basic Details', 'subtitle': 'Enter project basic information'},
    {'title': 'Location', 'subtitle': 'Add project location details'},
    {'title': 'Owner', 'subtitle': 'Enter owner information'},
    {'title': 'Construction', 'subtitle': 'Add construction details'},
    {'title': 'Team', 'subtitle': 'Assign team members'},
    {'title': 'Documents', 'subtitle': 'Upload required documents'},
    {'title': 'Review', 'subtitle': 'Review and submit project'},
  ];

  bool get _isNextButtonEnabled {
    if (_currentStep == 0) { // Basic Details step
      // For the first step, validate the form and check if project name is not empty
      final isFormValid = _formKeys[_currentStep].currentState?.validate() ?? false;
      final hasProjectName = _projectData.projectName?.trim().isNotEmpty ?? false;
      return isFormValid && hasProjectName;
    }
    // For other steps, just validate the form
    return _formKeys[_currentStep].currentState?.validate() ?? false;
  }

  void _nextStep() {
    if (_isNextButtonEnabled) {
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
    // TODO: Implement form submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project created successfully!')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Add New Project',
      child: Column(
        children: [
          // Stepper Header with horizontal scrolling
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            height: 90, // Fixed height for the stepper
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
                    width: 100, // Fixed width for each step
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () => _onStepTapped(index),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Theme.of(context).primaryColor
                                  : isCompleted
                                      ? Colors.green
                                      : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: isActive ? Colors.white : Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step['title'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                              color: isActive || isCompleted
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[600],
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
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
            margin: const EdgeInsets.only(bottom: 16),
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
                
                // Step 2: Location Details
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
                    },
                  ),
                ),
                
                // Step 3: Owner Details
                Form(
                  key: _formKeys[2],
                  child: OwnerDetailsStep(
                    projectData: _projectData,
                    onChanged: (data) {
                      setState(() {
                        _projectData.copyWith(
                          ownerType: data.ownerType,
                          ownerName: data.ownerName,
                          companyName: data.companyName,
                          mobileNumber: data.mobileNumber,
                          alternateMobileNumber: data.alternateMobileNumber,
                          email: data.email,
                          isSameAsSiteAddress: data.isSameAsSiteAddress,
                          idProofType: data.idProofType,
                          idProofNumber: data.idProofNumber,
                        );
                      });
                    },
                  ),
                ),
                
                // Step 4: Construction Details
                Form(
                  key: _formKeys[3],
                  child: ConstructionDetailsStep(
                    projectData: _projectData,
                    onChanged: (data) {
                      setState(() {
                        _projectData.copyWith(
                          totalPlotArea: data.totalPlotArea,
                          builtUpArea: data.builtUpArea,
                          numberOfFloors: data.numberOfFloors,
                          constructionMethod: data.constructionMethod,
                          estimatedBudget: data.estimatedBudget,
                          projectPriority: data.projectPriority,
                        );
                      });
                    },
                  ),
                ),
                
                // Step 5: Team Assignment (Placeholder)
                _buildPlaceholderStep('Team Assignment'),
                
                // Step 6: Documents (Placeholder)
                _buildPlaceholderStep('Documents'),
                
                // Step 7: Review (Placeholder)
                _buildPlaceholderStep('Review & Submit'),
              ],
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('BACK'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _currentStep == _steps.length - 1 ? 'SUBMIT' : 'NEXT',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderStep(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'This step is under development',
            style: TextStyle(color: Colors.grey[600]),
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