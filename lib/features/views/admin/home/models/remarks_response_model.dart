class RemarkDetailsResponseModel {
  final bool? success;
  final String? message;
  final RemarkDetailsData? data;

  RemarkDetailsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory RemarkDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return RemarkDetailsResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? RemarkDetailsData.fromJson(json['data'])
          : null,
    );
  }
}

class RemarkDetailsData {
  final String? id;
  final String? taskId;
  final String? siteId;
  final String? fileId;
  final String? lastRemarkedBy;
  final String? lastRemarkedRole;
  final DateTime? lastRemarkedAt;
  final String? description;
  final List<String>? images;
  final List<RemarkHistory>? history;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  RemarkDetailsData({
    this.id,
    this.taskId,
    this.siteId,
    this.fileId,
    this.lastRemarkedBy,
    this.lastRemarkedRole,
    this.lastRemarkedAt,
    this.description,
    this.images,
    this.history,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory RemarkDetailsData.fromJson(Map<String, dynamic> json) {
    return RemarkDetailsData(
      id: json['_id'],
      taskId: json['taskId']['_id'],
      siteId: json['siteId'],
      fileId: json['fileId'],
      lastRemarkedBy: json['lastRemarkedBy'],
      lastRemarkedRole: json['lastRemarkedRole'],
      lastRemarkedAt: json['lastRemarkedAt'] != null
          ? DateTime.parse(json['lastRemarkedAt'])
          : null,
      description: json['description'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      history: json['history'] != null
          ? (json['history'] as List)
          .map((e) => RemarkHistory.fromJson(e))
          .toList()
          : [],
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

class RemarkHistory {
  final RemarkUser? remarkedBy;
  final String? userRole;
  final String? description;
  final List<String>? images;
  final DateTime? remarkedAt;
  final String? statusAtTime;

  RemarkHistory({
    this.remarkedBy,
    this.userRole,
    this.description,
    this.images,
    this.remarkedAt,
    this.statusAtTime,
  });

  factory RemarkHistory.fromJson(Map<String, dynamic> json) {
    return RemarkHistory(
      remarkedBy: json['remarkedBy'] != null
          ? RemarkUser.fromJson(json['remarkedBy'])
          : null,
      userRole: json['userRole'],
      description: json['description'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      remarkedAt: json['remarkedAt'] != null
          ? DateTime.parse(json['remarkedAt'])
          : null,
      statusAtTime: json['statusAtTime'],
    );
  }
}

class RemarkUser {
  final String? id;
  final String? email;
  final String? name;
  final String? profileImage;

  RemarkUser({
    this.id,
    this.email,
    this.name,
    this.profileImage,
  });

  factory RemarkUser.fromJson(Map<String, dynamic> json) {
    return RemarkUser(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      profileImage: json['profileImage'],
    );
  }
}