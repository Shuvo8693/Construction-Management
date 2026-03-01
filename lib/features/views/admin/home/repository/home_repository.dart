
import 'dart:convert';

import 'package:charteur/core/helpers/prefs_helper.dart';
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/auth/models/user_model.dart';
import 'package:charteur/services/api_urls.dart';

class HomeRepository {
  final _network = NetworkCaller.instance;

  // ── Login ─────────────────────────────────────────────
  Future<ApiResult<SiteListResponseModel>> getSites() async {
  String token = await PrefsHelper.getString('token');
  print(token);
    final response = await _network.getRequest(
      url: ApiUrls.siteUrl,
    );

    if (response.isSuccess) {
      return ApiResult.success(SiteListResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

  // ── add company info ──────────────────────────────────────────
  Future<ApiResult<String>> addCompanyInfo({
    required String name,
    required String address,
    required String workType,
    required String email,
    required String phone,
    required String website,
    required String description,
  }) async {
    final response = await _network.postRequest(
      url: ApiUrls.addCompanyUrl,
      body: {
        "name": name,
        "address": address,
        "workType": workType,
        "email": email,
        "phone": phone,
        "website": website,
        "description": description,
      },
    );

    if (response.isSuccess) {
      return ApiResult.success(response.responseBody['data']['email']);
    }
    return ApiResult.failure(response.errorMassage ?? 'Failed to update company info');
  }



  // ── Assign Task ──────────────────────────────────────────
  Future<ApiResult<String>> assignTask({
    String? filePath,
    String? fileName,
    String? fileId,
    String? title,
    String? description,
    String? assignedTo,
    String? dueDate,
  }) async {

    final response = await _network.multipartRequest(
      url: ApiUrls.assignTaskUrl(fileId ?? ''),
      body: {
        "files": await _network.toMultipartFile(filePath!, fileName: fileName),
        "data": jsonEncode({
          "title": title,
          "description": description,
          "assignedTo": assignedTo,
          "dueDate": dueDate,
        }),
      },
    );

    if (response.isSuccess) {
      return ApiResult.success('Task assigned successfully');
    }
    return ApiResult.failure(response.errorMassage ?? 'Upload failed');
  }
}