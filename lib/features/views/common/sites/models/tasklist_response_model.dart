class TaskListResponseModel {
  final bool success;
  final String message;
  final Meta meta;
  final List<TaskData> data;

  TaskListResponseModel({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory TaskListResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskListResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: Meta.fromJson(json['meta'] ?? {}),
      data: (json['data'] as List? ?? [])
          .map((e) => TaskData.fromJson(e))
          .toList(),
    );
  }
}

/* ================= META ================= */

class Meta {
  final int total;
  final int page;
  final int limit;
  final int totalPage;

  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}

/* ================= TASK DATA ================= */

class TaskData {
  final String id;
  final SiteSummary siteId;
  final FileSummary fileId;
  final String title;
  final String description;
  final List<String> images;
  final UserSummary assignedTo;
  final UserSummary assignedBy;
  final DateTime assignedAt;
  final String status;
  final DateTime dueDate;
  final List<dynamic> attachments;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskData({
    required this.id,
    required this.siteId,
    required this.fileId,
    required this.title,
    required this.description,
    required this.images,
    required this.assignedTo,
    required this.assignedBy,
    required this.assignedAt,
    required this.status,
    required this.dueDate,
    required this.attachments,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['_id'] ?? '',
      siteId: SiteSummary.fromJson(json['siteId'] ?? {}),
      fileId: FileSummary.fromJson(json['fileId'] ?? {}),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      assignedTo: UserSummary.fromJson(json['assignedTo'] ?? {}),
      assignedBy: UserSummary.fromJson(json['assignedBy'] ?? {}),
      assignedAt: DateTime.parse(json['assignedAt']),
      status: json['status'] ?? '',
      dueDate: DateTime.parse(json['dueDate']),
      attachments: json['attachments'] ?? [],
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

/* ================= SITE ================= */

class SiteSummary {
  final SiteLocation location;
  final String id;
  final String siteTitle;
  final String status;

  SiteSummary({
    required this.location,
    required this.id,
    required this.siteTitle,
    required this.status,
  });

  factory SiteSummary.fromJson(Map<String, dynamic> json) {
    return SiteSummary(
      location: SiteLocation.fromJson(json['location'] ?? {}),
      id: json['_id'] ?? '',
      siteTitle: json['siteTitle'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class SiteLocation {
  final Coordinates coordinates;
  final String address;

  SiteLocation({
    required this.coordinates,
    required this.address,
  });

  factory SiteLocation.fromJson(Map<String, dynamic> json) {
    return SiteLocation(
      coordinates: Coordinates.fromJson(json['coordinates'] ?? {}),
      address: json['address'] ?? '',
    );
  }
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/* ================= FILE ================= */

class FileSummary {
  final String id;
  final String fileName;
  final String fileType;
  final String fileUrl;

  FileSummary({
    required this.id,
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
  });

  factory FileSummary.fromJson(Map<String, dynamic> json) {
    return FileSummary(
      id: json['_id'] ?? '',
      fileName: json['fileName'] ?? '',
      fileType: json['fileType'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
    );
  }
}

/* ================= USER ================= */

class UserSummary {
  final String id;
  final String email;
  final String name;

  UserSummary({
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
