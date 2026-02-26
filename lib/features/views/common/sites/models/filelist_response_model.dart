class FileListResponseModel {
  final bool success;
  final String message;
  final Meta meta;
  final List<FileData> data;

  FileListResponseModel({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory FileListResponseModel.fromJson(Map<String, dynamic> json) {
    return FileListResponseModel(
      success: json['success'],
      message: json['message'],
      meta: Meta.fromJson(json['meta']),
      data: List<FileData>.from(
        json['data'].map((x) => FileData.fromJson(x)),
      ),
    );
  }
}

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
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPage: json['totalPage'],
    );
  }
}

class FileData {
  final String id;
  final String uploadedBy;
  final String siteId;
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String fileSize;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileData({
    required this.id,
    required this.uploadedBy,
    required this.siteId,
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.fileSize,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      id: json['_id'],
      uploadedBy: json['uploadedBy'],
      siteId: json['siteId'],
      fileName: json['fileName'],
      fileType: json['fileType'],
      fileUrl: json['fileUrl'],
      fileSize: json['fileSize'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}