import 'package:flutter/material.dart';
import 'package:bharatplus/screens/layout/main_layout.dart';
import 'package:bharatplus/models/project_model.dart';
import 'package:bharatplus/screens/project/widgets/basic_details_step.dart';
import 'package:bharatplus/screens/project/widgets/location_details_step.dart';
import 'package:bharatplus/screens/project/widgets/owner_details_step.dart';
import 'package:bharatplus/screens/project/widgets/construction_details_step.dart';
import 'package:bharatplus/screens/project/widgets/team_assignment_step.dart';
import 'package:bharatplus/screens/project/widgets/documents_step.dart';
import 'package:bharatplus/screens/project/widgets/review_step.dart';

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
    // Get the current form state
    final formState = _formKeys[_currentStep].currentState;
    
    // If form state is null, button should be disabled
    if (formState == null) return false;
    
    // For the first step, check project name is not empty
    if (_currentStep == 0) {
      return _projectData.projectName?.trim().isNotEmpty == true;
    }
    
    // For location step (index 1), manually validate required fields
    if (_currentStep == 1) {
      final hasState = _projectData.state?.trim().isNotEmpty == true;
      final hasCity = _projectData.city?.trim().isNotEmpty == true;
      final hasArea = _projectData.area?.trim().isNotEmpty == true;
      final hasPincode = _projectData.pincode?.trim().isNotEmpty == true && 
                        _projectData.pincode!.length == 6 && 
                        int.tryParse(_projectData.pincode!) != null;
      
      return hasState && hasCity && hasArea && hasPincode;
    }
    
    // For Owner Details step (index 2), validate required fields
    if (_currentStep == 2) {
      final hasOwnerName = _projectData.ownerName?.trim().isNotEmpty == true;
      final hasMobileNumber = _projectData.mobileNumber?.trim().isNotEmpty == true;
      
      return hasOwnerName && hasMobileNumber;
    }
    
    // For other steps, use form validation
    return formState.validate();
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
                
                // Step 5: Team Assignment
                Form(
                  key: _formKeys[4],
                  child: TeamAssignmentStep(
                    projectData: _projectData,
                    onChanged: (data) {
                      setState(() {
                        _projectData.assignedContractors = data.assignedContractors;
                        _projectData.assignedSuppliers = data.assignedSuppliers;
                        _projectData.documents = data.documents;
                      });
                    },
                  ),
                ),

                // Step 6: Documentation & Media
                Form(
                  key: _formKeys[5],
                  child: DocumentsStep(
                    projectData: _projectData,
                    onChanged: (data) {
                      setState(() {
                        _projectData.documents = data.documents;
                      });
                    },
                  ),
                ),
                
                // Step 7: Review
                Form(
                  key: _formKeys[6],
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
              ],
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