enum ProjectType { residential, commercial, industrial, infrastructure }
enum ProjectStatus { active, onHold, completed }
enum ConstructionStage { planning, foundation, structure, brickWork, finishing, completed }
enum OwnerType { individual, company }
enum ConstructionMethod { rcc, steel, mixed }
enum ProjectPriority { low, medium, high }

class Project {
  // Step 1: Basic Project Details
  final String projectName;
  final String? projectCode;
  final ProjectType projectType;
  final DateTime constructionStartDate;
  final DateTime expectedCompletionDate;
  final ConstructionStage currentStage;
  final ProjectStatus projectStatus;

  // Step 2: Location Details
  final String country;
  final String state;
  final String? district;
  final String city;
  final String area;
  final String? landmark;
  final String pincode;
  final String fullAddress;
  final double latitude;
  final double longitude;

  // Step 3: Owner Details
  final OwnerType ownerType;
  final String ownerFullName;
  final String? companyName;
  final String mobileNumber;
  final String? alternateMobileNumber;
  final String? email;
  final bool isOwnerAddressSameAsSite;
  final String? idProofType;
  final String? idProofNumber;

  // Step 4: Construction Details
  final double totalPlotArea;
  final String plotAreaUnit;
  final double builtUpArea;
  final int numberOfFloors;
  final ConstructionMethod constructionMethod;
  final double estimatedBudget;
  final ProjectPriority projectPriority;

  // Step 5: Assignment Details
  final List<String> assignedContractors;
  final List<String> assignedSuppliers;
  final String? siteEngineer;
  final String? adminInCharge;

  // Step 6: Documentation & Media
  final List<String>? sitePlanUrls;
  final List<String>? sitePhotos;
  final List<String>? approvalDocuments;

  Project({
    // Step 1
    required this.projectName,
    this.projectCode,
    required this.projectType,
    required this.constructionStartDate,
    required this.expectedCompletionDate,
    required this.currentStage,
    required this.projectStatus,
    
    // Step 2
    this.country = 'India',
    required this.state,
    this.district,
    required this.city,
    required this.area,
    this.landmark,
    required this.pincode,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    
    // Step 3
    required this.ownerType,
    required this.ownerFullName,
    this.companyName,
    required this.mobileNumber,
    this.alternateMobileNumber,
    this.email,
    this.isOwnerAddressSameAsSite = true,
    this.idProofType,
    this.idProofNumber,
    
    // Step 4
    required this.totalPlotArea,
    this.plotAreaUnit = 'sq.ft',
    required this.builtUpArea,
    required this.numberOfFloors,
    required this.constructionMethod,
    required this.estimatedBudget,
    required this.projectPriority,
    
    // Step 5
    this.assignedContractors = const [],
    this.assignedSuppliers = const [],
    this.siteEngineer,
    this.adminInCharge,
    
    // Step 6
    this.sitePlanUrls,
    this.sitePhotos,
    this.approvalDocuments,
  });

  // Add copyWith method for form handling
  Project copyWith({
    String? projectName,
    String? projectCode,
    ProjectType? projectType,
    DateTime? constructionStartDate,
    DateTime? expectedCompletionDate,
    ConstructionStage? currentStage,
    ProjectStatus? projectStatus,
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
    OwnerType? ownerType,
    String? ownerFullName,
    String? companyName,
    String? mobileNumber,
    String? alternateMobileNumber,
    String? email,
    bool? isOwnerAddressSameAsSite,
    String? idProofType,
    String? idProofNumber,
    double? totalPlotArea,
    String? plotAreaUnit,
    double? builtUpArea,
    int? numberOfFloors,
    ConstructionMethod? constructionMethod,
    double? estimatedBudget,
    ProjectPriority? projectPriority,
    List<String>? assignedContractors,
    List<String>? assignedSuppliers,
    String? siteEngineer,
    String? adminInCharge,
    List<String>? sitePlanUrls,
    List<String>? sitePhotos,
    List<String>? approvalDocuments,
  }) {
    return Project(
      projectName: projectName ?? this.projectName,
      projectCode: projectCode ?? this.projectCode,
      projectType: projectType ?? this.projectType,
      constructionStartDate: constructionStartDate ?? this.constructionStartDate,
      expectedCompletionDate: expectedCompletionDate ?? this.expectedCompletionDate,
      currentStage: currentStage ?? this.currentStage,
      projectStatus: projectStatus ?? this.projectStatus,
      country: country ?? this.country,
      state: state ?? this.state,
      district: district ?? this.district,
      city: city ?? this.city,
      area: area ?? this.area,
      landmark: landmark ?? this.landmark,
      pincode: pincode ?? this.pincode,
      fullAddress: fullAddress ?? this.fullAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      ownerType: ownerType ?? this.ownerType,
      ownerFullName: ownerFullName ?? this.ownerFullName,
      companyName: companyName ?? this.companyName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      alternateMobileNumber: alternateMobileNumber ?? this.alternateMobileNumber,
      email: email ?? this.email,
      isOwnerAddressSameAsSite: isOwnerAddressSameAsSite ?? this.isOwnerAddressSameAsSite,
      idProofType: idProofType ?? this.idProofType,
      idProofNumber: idProofNumber ?? this.idProofNumber,
      totalPlotArea: totalPlotArea ?? this.totalPlotArea,
      plotAreaUnit: plotAreaUnit ?? this.plotAreaUnit,
      builtUpArea: builtUpArea ?? this.builtUpArea,
      numberOfFloors: numberOfFloors ?? this.numberOfFloors,
      constructionMethod: constructionMethod ?? this.constructionMethod,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      projectPriority: projectPriority ?? this.projectPriority,
      assignedContractors: assignedContractors ?? this.assignedContractors,
      assignedSuppliers: assignedSuppliers ?? this.assignedSuppliers,
      siteEngineer: siteEngineer ?? this.siteEngineer,
      adminInCharge: adminInCharge ?? this.adminInCharge,
      sitePlanUrls: sitePlanUrls ?? this.sitePlanUrls,
      sitePhotos: sitePhotos ?? this.sitePhotos,
      approvalDocuments: approvalDocuments ?? this.approvalDocuments,
    );
  }
}
