class SiteListResponseModel {
  final bool success;
  final String message;
  final Meta meta;
  final List<SiteData> data;

  SiteListResponseModel({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory SiteListResponseModel.fromJson(Map<String, dynamic> json) {
    return SiteListResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: Meta.fromJson(json['meta']),
      data: (json['data'] as List)
          .map((e) => SiteData.fromJson(e))
          .toList(),
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
      total: json['total'] ?? 0,
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}

class SiteData {
  final Location location;
  final String id;
  final String createdBy;
  final String companyId;
  final String siteOwner;
  final String siteTitle;
  final String buildingType;
  final String status;
  final String completionDescription;
  final List<String> photos;
  final DateTime endDate;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  SiteData({
    required this.location,
    required this.id,
    required this.createdBy,
    required this.companyId,
    required this.siteOwner,
    required this.siteTitle,
    required this.buildingType,
    required this.status,
    required this.completionDescription,
    required this.photos,
    required this.endDate,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SiteData.fromJson(Map<String, dynamic> json) {
    return SiteData(
      location: Location.fromJson(json['location']),
      id: json['_id'] ?? '',
      createdBy: json['createdBy'] ?? '',
      companyId: json['companyId'] ?? '',
      siteOwner: json['siteOwner'] ?? '',
      siteTitle: json['siteTitle'] ?? '',
      buildingType: json['buildingType'] ?? '',
      status: json['status'] ?? '',
      completionDescription: json['completionDescription'] ?? '',
      photos: List<String>.from(json['photos'] ?? []),
      endDate: DateTime.parse(json['endDate']),
      isDeleted: json['isDeleted'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Location {
  final Coordinates coordinates;
  final String address;

  Location({
    required this.coordinates,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: Coordinates.fromJson(json['coordinates']),
      address: json['address'] ?? '',
    );
  }
}

class Coordinates {
  final String type;
  final double lat;
  final double lng;

  Coordinates({
    required this.type,
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    final List coords = json['coordinates'];

    return Coordinates(
      type: json['type'] ?? '',
      lng: (coords[0] as num).toDouble(),
      lat: (coords[1] as num).toDouble(),
    );
  }
}
