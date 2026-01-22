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

  ProjectModel();

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
    String? ownerType,
    String? ownerName,
    String? companyName,
    String? mobileNumber,
    String? alternateMobileNumber,
    String? email,
    bool? isSameAsSiteAddress,
    String? idProofType,
    String? idProofNumber,
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
      ..ownerType = ownerType ?? this.ownerType
      ..ownerName = ownerName ?? this.ownerName
      ..companyName = companyName ?? this.companyName
      ..mobileNumber = mobileNumber ?? this.mobileNumber
      ..alternateMobileNumber = alternateMobileNumber ?? this.alternateMobileNumber
      ..email = email ?? this.email
      ..isSameAsSiteAddress = isSameAsSiteAddress ?? this.isSameAsSiteAddress
      ..idProofType = idProofType ?? this.idProofType
      ..idProofNumber = idProofNumber ?? this.idProofNumber
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
      ..sitePlans = sitePlans != null ? List.from(sitePlans) : this.sitePlans != null ? List.from(this.sitePlans!) : null
      ..sitePhotos = sitePhotos != null ? List.from(sitePhotos) : this.sitePhotos != null ? List.from(this.sitePhotos!) : null
      ..approvalDocuments = approvalDocuments != null ? List.from(approvalDocuments) : this.approvalDocuments != null ? List.from(this.approvalDocuments!) : null;
  }
}
