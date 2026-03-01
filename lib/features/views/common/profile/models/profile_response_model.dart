class ProfileResponseModel {
  final bool? success;
  final String? message;
  final UserData? data;

  ProfileResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String? companyId;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? profileImage;
  final int? experience;
  final String? expertiseArea;
  final String? employmentType;
  final bool? isCompanyAdded;
  final String? currentSubscriptionId;
  final bool? hasActiveSubscription;
  final String? id;
  final String? email;
  final String? role;
  final bool? isActive;
  final bool? isVerified;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  UserData({
    this.companyId,
    this.name,
    this.phoneNumber,
    this.address,
    this.profileImage,
    this.experience,
    this.expertiseArea,
    this.employmentType,
    this.isCompanyAdded,
    this.currentSubscriptionId,
    this.hasActiveSubscription,
    this.id,
    this.email,
    this.role,
    this.isActive,
    this.isVerified,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      companyId: json['companyId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      profileImage: json['profileImage'],
      experience: json['experience'],
      expertiseArea: json['expertiseArea'],
      employmentType: json['employmentType'],
      isCompanyAdded: json['isCompanyAdded'],
      currentSubscriptionId: json['currentSubscriptionId'],
      hasActiveSubscription: json['hasActiveSubscription'],
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      isActive: json['isActive'],
      isVerified: json['isVerified'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      version: json['__v'],
    );
  }
}