class FileDetailsResponseModel {
  final bool? success;
  final String? message;
  final FileDetailsData? data;

  FileDetailsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory FileDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return FileDetailsResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? FileDetailsData.fromJson(json['data'])
          : null,
    );
  }
}

class FileDetailsData {
  final String? id;
  final UploadedBy? uploadedBy;
  final SiteSummary? siteId;
  final String? fileName;
  final String? fileType;
  final String? fileUrl;
  final String? fileSize;
  final bool? isDeleted;
  final int? version;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FileDetailsData({
    this.id,
    this.uploadedBy,
    this.siteId,
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.fileSize,
    this.isDeleted,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FileDetailsData.fromJson(Map<String, dynamic> json) {
    return FileDetailsData(
      id: json['_id'],
      uploadedBy: json['uploadedBy'] != null
          ? UploadedBy.fromJson(json['uploadedBy'])
          : null,
      siteId: json['siteId'] != null
          ? SiteSummary.fromJson(json['siteId'])
          : null,
      fileName: json['fileName'],
      fileType: json['fileType'],
      fileUrl: json['fileUrl'],
      fileSize: json['fileSize'],
      isDeleted: json['isDeleted'],
      version: json['__v'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}

class UploadedBy {
  final String? id;
  final String? email;
  final String? name;

  UploadedBy({
    this.id,
    this.email,
    this.name,
  });

  factory UploadedBy.fromJson(Map<String, dynamic> json) {
    return UploadedBy(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
    );
  }
}

class SiteSummary {
  final String? id;
  final String? siteOwner;
  final String? siteTitle;
  final String? buildingType;
  final String? status;
  final List<String>? photos;

  SiteSummary({
    this.id,
    this.siteOwner,
    this.siteTitle,
    this.buildingType,
    this.status,
    this.photos,
  });

  factory SiteSummary.fromJson(Map<String, dynamic> json) {
    return SiteSummary(
      id: json['_id'],
      siteOwner: json['siteOwner'],
      siteTitle: json['siteTitle'],
      buildingType: json['buildingType'],
      status: json['status'],
      photos: json['photos'] != null
          ? List<String>.from(json['photos'])
          : [],
    );
  }
}