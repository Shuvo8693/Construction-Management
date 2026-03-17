class NotificationResponse {
  final bool? success;
  final String? message;
  final Meta? meta;
  final List<NotificationData>? data;

  NotificationResponse({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'],
      message: json['message'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<NotificationData>.from(
          json['data'].map((x) => NotificationData.fromJson(x)))
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

class NotificationData {
  final String? id;
  final Sender? sender;
  final String? recipient;
  final String? type;
  final String? message;
  final bool? isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationData({
    this.id,
    this.sender,
    this.recipient,
    this.type,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['_id'],
      sender: json['sender'] != null
          ? Sender.fromJson(json['sender'])
          : null,
      recipient: json['recipient'],
      type: json['type'],
      message: json['message'],
      isRead: json['isRead'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}

class Sender {
  final String? id;
  final String? name;

  Sender({
    this.id,
    this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      name: json['name'],
    );
  }
}