
import 'dart:convert';

import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';

import 'package:charteur/features/views/common/sites/models/filelist_response_model.dart';
import 'package:charteur/features/views/common/sites/models/tasklist_response_model.dart';
import 'package:charteur/services/api_urls.dart';



class SitesRepository {
  final _network = NetworkCaller.instance;

  // ── Get Assign Sites ─────────────────────────────────────────────
  Future<ApiResult<SiteListResponseModel>> getAssignedSites() async {
    final response = await _network.getRequest(
      url: ApiUrls.siteUrl,
    );

    if (response.isSuccess) {
      return ApiResult.success(SiteListResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

  // ── Site Files ──────────────────────────────────────────
  Future<ApiResult<FileListResponseModel>> getSiteFiles({String siteId = ''}) async {
    final response = await _network.getRequest(
      url: ApiUrls.siteFileUrl(siteId),
    );
    if (response.isSuccess) {
      return ApiResult.success(FileListResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Registration failed');
  }

  // ── Site Task ──────────────────────────────────────────
  Future<ApiResult<TaskListResponseModel>> getSiteTask({String status = ''}) async {
    final response = await _network.getRequest(
      url: ApiUrls.siteTaskUrl(status),
    );
    if (response.isSuccess) {
      return ApiResult.success(TaskListResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Registration failed');
  }

  // ──Add Site file ──────────────────────────────────────────
  Future<ApiResult<String>> uploadSiteFile({
    String? fileName,
    String? siteId,
    String? filePath,
  }) async {

    final response = await _network.multipartRequest(
      url: ApiUrls.siteFileUploadUrl,
      body: {
        "files": await _network.toMultipartFile(filePath!,fileName: fileName),
        "data": jsonEncode({
          "siteId": siteId,
          "fileName": fileName,
        }),
      },
    );

    if (response.isSuccess) {
      return ApiResult.success(response.responseBody['data'][0]['fileUrl']);
    }
    return ApiResult.failure(response.errorMassage ?? 'Upload failed');
  }


  // ──Add Site ──────────────────────────────────────────
  Future<ApiResult<String>> addSite({
    String? fileName,
    String? createdBy,
    String? siteTitle,
    String? siteOwner,
    String? siteStatus,
    String? siteLocation,
    String? buildingType,
    String? filePath,
  }) async {

    final response = await _network.multipartRequest(
      url: ApiUrls.siteCreateUrl,
      body: {
        "images": await _network.toMultipartFile(filePath!,fileName: fileName),
        "data": jsonEncode({
          "createdBy": createdBy,
          "siteOwner": siteOwner,
          "siteTitle": siteTitle,
          "buildingType": buildingType,
          "location": {
            "address": siteLocation,
            "coordinates": {
              "lat": 40.7128,
              "lng": -74.0060
            }
          },
          "status": siteStatus,
          "endDate": "2027-12-31T00:00:00.000Z"
        }
        ),
      },
    );

    if (response.isSuccess) {
      return ApiResult.success('Site Added Successfully');
    }
    return ApiResult.failure(response.errorMassage ?? 'Upload failed');
  }

}