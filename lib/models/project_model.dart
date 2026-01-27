// ignore_for_file: unused_import

import 'dart:convert';

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
  String? ownerName;
  String? ownerPhoneNumber;
  String? ownerEmail;

  // Supervisor Details
  String? supervisorName;
  String? supervisorPhoneNumber;

  // Watchman Details
  String? watchmanName;
  String? watchmanPhoneNumber;

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
  Map<String, dynamic>? documents; // For storing document references
  List<String>? sitePlans;
  List<String>? sitePhotos;
  List<String>? governmentApprovals;
  List<String>? approvalDocuments;

  ProjectModel();

  // Helper method to get city with default value
  String getCityDisplay() {
    return city ?? 'City not specified';
  }

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
    return ownerName?.isNotEmpty == true;
  }

  ProjectModel copyWith({
    String? projectName,
    String? projectCode,
    String? projectType,
    DateTime? constructionStartDate,
    DateTime? expectedCompletionDate,
    String? currentStage,
    String? projectStatus,
    String? country,
    String? state,
    String? district,
    String? city,
    String? area,
    String? landmark,
    String? pincode,
    String? fullAddress,
    double? latitude,
    double? longitude,
    String? ownerName,
    String? ownerPhoneNumber,
    String? ownerEmail,
    String? supervisorName,
    String? supervisorPhoneNumber,
    String? watchmanName,
    String? watchmanPhoneNumber,
    double? totalPlotArea,
    double? builtUpArea,
    int? numberOfFloors,
    String? constructionMethod,
    double? estimatedBudget,
    String? projectPriority,
    List<String>? assignedContractors,
    List<String>? assignedSuppliers,
    String? siteEngineer,
    String? adminInCharge,
    Map<String, dynamic>? documents,
    List<String>? sitePlans,
    List<String>? sitePhotos,
    List<String>? approvalDocuments,
  }) {
    return ProjectModel()
      ..projectName = projectName ?? this.projectName
      ..projectCode = projectCode ?? this.projectCode
      ..projectType = projectType ?? this.projectType
      ..constructionStartDate = constructionStartDate ?? this.constructionStartDate
      ..expectedCompletionDate = expectedCompletionDate ?? this.expectedCompletionDate
      ..currentStage = currentStage ?? this.currentStage
      ..projectStatus = projectStatus ?? this.projectStatus
      ..country = country ?? this.country
      ..state = state ?? this.state
      ..district = district ?? this.district
      ..city = city ?? this.city
      ..area = area ?? this.area
      ..landmark = landmark ?? this.landmark
      ..pincode = pincode ?? this.pincode
      ..fullAddress = fullAddress ?? this.fullAddress
      ..latitude = latitude ?? this.latitude
      ..longitude = longitude ?? this.longitude
      ..ownerName = ownerName ?? this.ownerName
      ..ownerPhoneNumber = ownerPhoneNumber ?? this.ownerPhoneNumber
      ..ownerEmail = ownerEmail ?? this.ownerEmail
      ..supervisorName = supervisorName ?? this.supervisorName
      ..supervisorPhoneNumber = supervisorPhoneNumber ?? this.supervisorPhoneNumber
      ..watchmanName = watchmanName ?? this.watchmanName
      ..watchmanPhoneNumber = watchmanPhoneNumber ?? this.watchmanPhoneNumber
      ..totalPlotArea = totalPlotArea ?? this.totalPlotArea
      ..builtUpArea = builtUpArea ?? this.builtUpArea
      ..numberOfFloors = numberOfFloors ?? this.numberOfFloors
      ..constructionMethod = constructionMethod ?? this.constructionMethod
      ..estimatedBudget = estimatedBudget ?? this.estimatedBudget
      ..projectPriority = projectPriority ?? this.projectPriority
      ..assignedContractors = assignedContractors != null ? List.from(assignedContractors) : this.assignedContractors != null ? List.from(this.assignedContractors!) : null
      ..assignedSuppliers = assignedSuppliers != null ? List.from(assignedSuppliers) : this.assignedSuppliers != null ? List.from(this.assignedSuppliers!) : null
      ..siteEngineer = siteEngineer ?? this.siteEngineer
      ..adminInCharge = adminInCharge ?? this.adminInCharge
      ..documents = documents != null ? Map.from(documents) : this.documents != null ? Map.from(this.documents!) : null
      ..sitePlans = sitePlans != null ? List.from(sitePlans) : this.sitePlans != null ? List.from(this.sitePlans!) : null
      ..sitePhotos = sitePhotos != null ? List.from(sitePhotos) : this.sitePhotos != null ? List.from(this.sitePhotos!) : null
      ..approvalDocuments = approvalDocuments != null ? List.from(approvalDocuments) : this.approvalDocuments != null ? List.from(this.approvalDocuments!) : null;
  }

  // Convert ProjectModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'projectName': projectName,
      'projectCode': projectCode,
      'projectType': projectType,
      'constructionStartDate': constructionStartDate?.toIso8601String(),
      'expectedCompletionDate': expectedCompletionDate?.toIso8601String(),
      'currentStage': currentStage,
      'projectStatus': projectStatus,
      'country': country,
      'state': state,
      'district': district,
      'city': city,
      'area': area,
      'landmark': landmark,
      'pincode': pincode,
      'fullAddress': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'ownerName': ownerName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'ownerEmail': ownerEmail,
      'supervisorName': supervisorName,
      'supervisorPhoneNumber': supervisorPhoneNumber,
      'watchmanName': watchmanName,
      'watchmanPhoneNumber': watchmanPhoneNumber,
      'totalPlotArea': totalPlotArea,
      'builtUpArea': builtUpArea,
      'numberOfFloors': numberOfFloors,
      'constructionMethod': constructionMethod,
      'estimatedBudget': estimatedBudget,
      'projectPriority': projectPriority,
      'assignedContractors': assignedContractors,
      'assignedSuppliers': assignedSuppliers,
      'siteEngineer': siteEngineer,
      'adminInCharge': adminInCharge,
      'documents': documents,
      'sitePlans': sitePlans,
      'sitePhotos': sitePhotos,
      'approvalDocuments': approvalDocuments,
    };
  }

  // Create ProjectModel from JSON
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel()
      ..projectName = json['projectName']
      ..projectCode = json['projectCode']
      ..projectType = json['projectType']
      ..constructionStartDate = json['constructionStartDate'] != null 
          ? DateTime.parse(json['constructionStartDate'])
          : null
      ..expectedCompletionDate = json['expectedCompletionDate'] != null
          ? DateTime.parse(json['expectedCompletionDate'])
          : null
      ..currentStage = json['currentStage']
      ..projectStatus = json['projectStatus']
      ..country = json['country'] ?? 'India'
      ..state = json['state']
      ..district = json['district']
      ..city = json['city']
      ..area = json['area']
      ..landmark = json['landmark']
      ..pincode = json['pincode']
      ..fullAddress = json['fullAddress']
      ..latitude = (json['latitude'] as num?)?.toDouble()
      ..longitude = (json['longitude'] as num?)?.toDouble()
      ..ownerName = json['ownerName']
      ..ownerPhoneNumber = json['ownerPhoneNumber']
      ..ownerEmail = json['ownerEmail']
      ..supervisorName = json['supervisorName']
      ..supervisorPhoneNumber = json['supervisorPhoneNumber']
      ..watchmanName = json['watchmanName']
      ..watchmanPhoneNumber = json['watchmanPhoneNumber']
      ..totalPlotArea = (json['totalPlotArea'] as num?)?.toDouble()
      ..builtUpArea = (json['builtUpArea'] as num?)?.toDouble()
      ..numberOfFloors = json['numberOfFloors']
      ..constructionMethod = json['constructionMethod']
      ..estimatedBudget = (json['estimatedBudget'] as num?)?.toDouble()
      ..projectPriority = json['projectPriority']
      ..assignedContractors = json['assignedContractors'] != null
          ? List<String>.from(json['assignedContractors'])
          : null
      ..assignedSuppliers = json['assignedSuppliers'] != null
          ? List<String>.from(json['assignedSuppliers'])
          : null
      ..siteEngineer = json['siteEngineer']
      ..adminInCharge = json['adminInCharge']
      ..documents = json['documents'] != null
          ? Map<String, dynamic>.from(json['documents'])
          : null
      ..sitePlans = json['sitePlans'] != null
          ? List<String>.from(json['sitePlans'])
          : null
      ..sitePhotos = json['sitePhotos'] != null
          ? List<String>.from(json['sitePhotos'])
          : null
      ..approvalDocuments = json['approvalDocuments'] != null
          ? List<String>.from(json['approvalDocuments'])
          : null;
  }
}
