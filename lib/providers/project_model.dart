import 'package:flutter/material.dart';

class ProjectModel {
  // Step 1: Basic Project Details
  String? projectName;
  String? projectCode;
  String? projectType;
  DateTime? constructionStartDate;
  DateTime? expectedCompletionDate;
  String? currentStage;
  String? projectStatus;

  // Step 2: Location Details
  String country = 'India';
  String? state;
  String? district;
  String? city;
  String? area;
  String? landmark;
  String? pincode;
  String? fullAddress;
  double? latitude;
  double? longitude;

  // Step 3: Owner Details
  String? ownerType;
  String? ownerName;
  String? companyName;
  String? mobileNumber;
  String? alternateMobileNumber;
  String? email;
  bool isSameAsSiteAddress = false;
  String? idProofType;
  String? idProofNumber;

  // Step 4: Construction Details
  double? totalPlotArea;
  double? builtUpArea;
  int? numberOfFloors;
  String? constructionMethod;
  double? estimatedBudget;
  String? projectPriority;

  // Step 5: Assignment Details
  List<String>? assignedContractors;
  List<String>? assignedSuppliers;
  String? siteEngineer;
  String? adminInCharge;

  // Step 6: Documentation & Media
  List<String>? sitePlans;
  List<String>? sitePhotos;
  List<String>? approvalDocuments;

  // Methods to handle form validation
  bool validateBasicDetails() {
    return projectName?.isNotEmpty == true &&
        projectType?.isNotEmpty == true &&
        constructionStartDate != null &&
        expectedCompletionDate != null &&
        currentStage?.isNotEmpty == true &&
        projectStatus?.isNotEmpty == true;
  }

  bool validateLocationDetails() {
    return state?.isNotEmpty == true &&
        city?.isNotEmpty == true &&
        area?.isNotEmpty == true &&
        pincode?.isNotEmpty == true &&
        fullAddress?.isNotEmpty == true;
  }

  bool validateOwnerDetails() {
    return ownerType?.isNotEmpty == true &&
        ((ownerType == 'Individual' && ownerName?.isNotEmpty == true) ||
            (ownerType == 'Company' && companyName?.isNotEmpty == true)) &&
        mobileNumber?.isNotEmpty == true;
  }

  ProjectModel copyWith(ProjectModel? newData) {
    if (newData == null) return this;
    
    return ProjectModel()
      ..projectName = newData.projectName ?? projectName
      ..projectCode = newData.projectCode ?? projectCode
      ..projectType = newData.projectType ?? projectType
      ..constructionStartDate = newData.constructionStartDate ?? constructionStartDate
      ..expectedCompletionDate = newData.expectedCompletionDate ?? expectedCompletionDate
      ..currentStage = newData.currentStage ?? currentStage
      ..projectStatus = newData.projectStatus ?? projectStatus
      ..country = newData.country
      ..state = newData.state ?? state
      ..district = newData.district ?? district
      ..city = newData.city ?? city
      ..area = newData.area ?? area
      ..landmark = newData.landmark ?? landmark
      ..pincode = newData.pincode ?? pincode
      ..fullAddress = newData.fullAddress ?? fullAddress
      ..latitude = newData.latitude ?? latitude
      ..longitude = newData.longitude ?? longitude
      ..ownerType = newData.ownerType ?? ownerType
      ..ownerName = newData.ownerName ?? ownerName
      ..companyName = newData.companyName ?? companyName
      ..mobileNumber = newData.mobileNumber ?? mobileNumber
      ..alternateMobileNumber = newData.alternateMobileNumber ?? alternateMobileNumber
      ..email = newData.email ?? email
      ..isSameAsSiteAddress = newData.isSameAsSiteAddress
      ..idProofType = newData.idProofType ?? idProofType
      ..idProofNumber = newData.idProofNumber ?? idProofNumber
      ..totalPlotArea = newData.totalPlotArea ?? totalPlotArea
      ..builtUpArea = newData.builtUpArea ?? builtUpArea
      ..numberOfFloors = newData.numberOfFloors ?? numberOfFloors
      ..constructionMethod = newData.constructionMethod ?? constructionMethod
      ..estimatedBudget = newData.estimatedBudget ?? estimatedBudget
      ..projectPriority = newData.projectPriority ?? projectPriority
      ..assignedContractors = newData.assignedContractors ?? assignedContractors
      ..assignedSuppliers = newData.assignedSuppliers ?? assignedSuppliers
      ..siteEngineer = newData.siteEngineer ?? siteEngineer
      ..adminInCharge = newData.adminInCharge ?? adminInCharge
      ..sitePlans = newData.sitePlans ?? sitePlans
      ..sitePhotos = newData.sitePhotos ?? sitePhotos
      ..approvalDocuments = newData.approvalDocuments ?? approvalDocuments;
  }
}