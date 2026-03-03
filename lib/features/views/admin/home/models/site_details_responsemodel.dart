class TaskDetailsResponseModel {
  final bool? success;
  final String? message;
  final TaskDetailsData? data;

  TaskDetailsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory TaskDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailsResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? TaskDetailsData.fromJson(json['data'])
          : null,
    );
  }
}

class TaskDetailsData {
  final String? id;
  final SiteShort? siteId;
  final FileShort? fileId;
  final String? title;
  final String? description;
  final List<String>? images;
  final UserShort? assignedTo;
  final UserShort? assignedBy;
  final DateTime? assignedAt;
  final String? status;
  final DateTime? dueDate;
  final List<dynamic>? attachments;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  TaskDetailsData({
    this.id,
    this.siteId,
    this.fileId,
    this.title,
    this.description,
    this.images,
    this.assignedTo,
    this.assignedBy,
    this.assignedAt,
    this.status,
    this.dueDate,
    this.attachments,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory TaskDetailsData.fromJson(Map<String, dynamic> json) {
    return TaskDetailsData(
      id: json['_id'],
      siteId: json['siteId'] != null
          ? SiteShort.fromJson(json['siteId'])
          : null,
      fileId: json['fileId'] != null
          ? FileShort.fromJson(json['fileId'])
          : null,
      title: json['title'],
      description: json['description'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      assignedTo: json['assignedTo'] != null
          ? UserShort.fromJson(json['assignedTo'])
          : null,
      assignedBy: json['assignedBy'] != null
          ? UserShort.fromJson(json['assignedBy'])
          : null,
      assignedAt: json['assignedAt'] != null
          ? DateTime.parse(json['assignedAt'])
          : null,
      status: json['status'],
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : null,
      attachments: json['attachments'] != null
          ? List<dynamic>.from(json['attachments'])
          : [],
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

class SiteShort {
  final String? id;
  final String? siteTitle;
  final List<String>? photos;

  SiteShort({
    this.id,
    this.siteTitle,
    this.photos,
  });

  factory SiteShort.fromJson(Map<String, dynamic> json) {
    return SiteShort(
      id: json['_id'],
      siteTitle: json['siteTitle'],
      photos: json['photos'] != null
          ? List<String>.from(json['photos'])
          : [],
    );
  }
}

class FileShort {
  final String? id;
  final String? fileName;
  final String? fileUrl;

  FileShort({
    this.id,
    this.fileName,
    this.fileUrl,
  });

  factory FileShort.fromJson(Map<String, dynamic> json) {
    return FileShort(
      id: json['_id'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
    );
  }
}

class UserShort {
  final String? id;
  final String? email;
  final String? name;
  final String? role;

  UserShort({
    this.id,
    this.email,
    this.name,
    this.role,
  });

  factory UserShort.fromJson(Map<String, dynamic> json) {
    return UserShort(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
    );
  }
}