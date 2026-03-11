class CommentsResponseModel {
  final bool? success;
  final String? message;
  final List<CommentData>? data;

  CommentsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory CommentsResponseModel.fromJson(Map<String, dynamic> json) {
    return CommentsResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => CommentData.fromJson(e))
          .toList()
          : [],
    );
  }
}

class CommentData {
  final String? id;
  final String? taskId;
  final String? siteId;
  final String? fileId;
  final CommentUser? commentedBy;
  final String? userRole;
  final String? message;
  final List<String>? images;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  CommentData({
    this.id,
    this.taskId,
    this.siteId,
    this.fileId,
    this.commentedBy,
    this.userRole,
    this.message,
    this.images,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      id: json['_id'],
      taskId: json['taskId'],
      siteId: json['siteId'],
      fileId: json['fileId'],
      commentedBy: json['commentedBy'] != null
          ? CommentUser.fromJson(json['commentedBy'])
          : null,
      userRole: json['userRole'],
      message: json['message'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
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

class CommentUser {
  final String? id;
  final String? email;
  final String? name;
  final String? profileImage;
  final String? role;

  CommentUser({
    this.id,
    this.email,
    this.name,
    this.profileImage,
    this.role,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profileImage'],
      role: json['role'],
    );
  }
}