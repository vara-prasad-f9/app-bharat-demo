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

  // Step 4: Review

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
      ..watchmanPhoneNumber = watchmanPhoneNumber ?? this.watchmanPhoneNumber;
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
      ..watchmanPhoneNumber = json['watchmanPhoneNumber'];
  }
}
