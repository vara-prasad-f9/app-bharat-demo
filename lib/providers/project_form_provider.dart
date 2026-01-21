import 'package:flutter/material.dart';
import 'package:bharatplus/models/project_model.dart';

class ProjectFormProvider with ChangeNotifier {
  int _currentStep = 0;
  final PageController _pageController = PageController();
  bool _isLoading = false;
  Project _project;

  ProjectFormProvider() : _project = Project(
    projectName: '',
    projectType: ProjectType.residential,
    constructionStartDate: DateTime.now(),
    expectedCompletionDate: DateTime.now().add(const Duration(days: 365)),
    currentStage: ConstructionStage.planning,
    projectStatus: ProjectStatus.active,
    state: '',
    city: '',
    area: '',
    pincode: '',
    fullAddress: '',
    latitude: 0.0,
    longitude: 0.0,
    ownerType: OwnerType.individual,
    ownerFullName: '',
    mobileNumber: '',
    totalPlotArea: 0.0,
    builtUpArea: 0.0,
    numberOfFloors: 1,
    constructionMethod: ConstructionMethod.rcc,
    estimatedBudget: 0.0,
    projectPriority: ProjectPriority.medium,
  );

  // Getters
  int get currentStep => _currentStep;
  PageController get pageController => _pageController;
  bool get isLoading => _isLoading;
  Project get project => _project;

  // Setters for form fields
  void updateProject(Project newProject) {
    _project = newProject;
    notifyListeners();
  }

  void updateField<T>(String field, T value) {
    _project = _project.copyWith(
      projectName: field == 'projectName' ? value as String? : _project.projectName,
      projectCode: field == 'projectCode' ? value as String? : _project.projectCode,
      projectType: field == 'projectType' ? value as ProjectType? : _project.projectType,
      constructionStartDate: field == 'constructionStartDate' ? value as DateTime? : _project.constructionStartDate,
      expectedCompletionDate: field == 'expectedCompletionDate' ? value as DateTime? : _project.expectedCompletionDate,
      currentStage: field == 'currentStage' ? value as ConstructionStage? : _project.currentStage,
      projectStatus: field == 'projectStatus' ? value as ProjectStatus? : _project.projectStatus,
      state: field == 'state' ? value as String? : _project.state,
      district: field == 'district' ? value as String? : _project.district,
      city: field == 'city' ? value as String? : _project.city,
      area: field == 'area' ? value as String? : _project.area,
      landmark: field == 'landmark' ? value as String? : _project.landmark,
      pincode: field == 'pincode' ? value as String? : _project.pincode,
      fullAddress: field == 'fullAddress' ? value as String? : _project.fullAddress,
      latitude: field == 'latitude' ? value as double? : _project.latitude,
      longitude: field == 'longitude' ? value as double? : _project.longitude,
      ownerType: field == 'ownerType' ? value as OwnerType? : _project.ownerType,
      ownerFullName: field == 'ownerFullName' ? value as String? : _project.ownerFullName,
      companyName: field == 'companyName' ? value as String? : _project.companyName,
      mobileNumber: field == 'mobileNumber' ? value as String? : _project.mobileNumber,
      alternateMobileNumber: field == 'alternateMobileNumber' ? value as String? : _project.alternateMobileNumber,
      email: field == 'email' ? value as String? : _project.email,
      isOwnerAddressSameAsSite: field == 'isOwnerAddressSameAsSite' ? value as bool? : _project.isOwnerAddressSameAsSite,
      idProofType: field == 'idProofType' ? value as String? : _project.idProofType,
      idProofNumber: field == 'idProofNumber' ? value as String? : _project.idProofNumber,
      totalPlotArea: field == 'totalPlotArea' ? value as double? : _project.totalPlotArea,
      builtUpArea: field == 'builtUpArea' ? value as double? : _project.builtUpArea,
      numberOfFloors: field == 'numberOfFloors' ? value as int? : _project.numberOfFloors,
      constructionMethod: field == 'constructionMethod' ? value as ConstructionMethod? : _project.constructionMethod,
      estimatedBudget: field == 'estimatedBudget' ? value as double? : _project.estimatedBudget,
      projectPriority: field == 'projectPriority' ? value as ProjectPriority? : _project.projectPriority,
    );
    notifyListeners();
  }

  // Navigation methods
  void nextStep() {
    if (_currentStep < 6) {
      _currentStep++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 6) {
      _currentStep = step;
      _pageController.animateToPage(
        step,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  // Form submission
  Future<bool> submitForm() async {
    if (!_validateCurrentStep()) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
     
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      return true;
    } catch (e) {
      debugPrint('Error submitting form: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _validateCurrentStep() {

    return true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
