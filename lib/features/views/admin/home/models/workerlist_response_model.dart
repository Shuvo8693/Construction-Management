
class WorkerListResponseModel {
  final bool? success;
  final String? message;
  final Meta? meta;
  final List<WorkerData>? data;

  WorkerListResponseModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory WorkerListResponseModel.fromJson(Map<String, dynamic> json) {
    return WorkerListResponseModel(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<WorkerData>.from(
        json['data'].map((x) => WorkerData.fromJson(x)),
      )
          : [],
    );
  }
}

class Meta {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPage;

  Meta({
    this.total,
    this.page,
    this.limit,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPage: json['totalPage'],
    );
  }
}

class WorkerData {
  final bool? isCompanyAdded;
  final String? id;
  final String? companyId;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? profileImage;
  final String? role;
  final int? experience;
  final String? expertiseArea;
  final String? employmentType;
  final bool? isActive;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WorkerData({
    this.isCompanyAdded,
    this.id,
    this.companyId,
    this.email,
    this.name,
    this.phoneNumber,
    this.address,
    this.profileImage,
    this.role,
    this.experience,
    this.expertiseArea,
    this.employmentType,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkerData.fromJson(Map<String, dynamic> json) {
    return WorkerData(
      isCompanyAdded: json['isCompanyAdded'],
      id: json['_id'],
      companyId: json['companyId'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      profileImage: json['profileImage'],
      role: json['role'],
      experience: json['experience'],
      expertiseArea: json['expertiseArea'],
      employmentType: json['employmentType'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}