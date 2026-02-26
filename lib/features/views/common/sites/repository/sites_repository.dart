
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';

import 'package:charteur/features/views/auth/models/user_model.dart';
import 'package:charteur/services/api_urls.dart';

class SitesRepository {
  final _network = NetworkCaller.instance;

  // ── Login ─────────────────────────────────────────────
  Future<ApiResult<SiteListResponseModel>> getAssignedSites() async {
    final response = await _network.getRequest(
      url: ApiUrls.assignedSiteUrl,
    );

    if (response.isSuccess) {
      return ApiResult.success(SiteListResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

  // ── Register ──────────────────────────────────────────
  Future<ApiResult<String>> home({
    required String name,
    required String email,
    required String password,
    required String role,
    required String phoneNumber,
  }) async {
    final response = await _network.postRequest(
      url: ApiUrls.register,
      body: {
        "email": email,
        "password": password,
        "name": name,
        "phoneNumber": phoneNumber,
        "role": role
      },
    );

    if (response.isSuccess) {
      return ApiResult.success(response.responseBody['data']['email']);
    }
    return ApiResult.failure(response.errorMassage ?? 'Registration failed');
  }

}