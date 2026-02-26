
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';

import 'package:charteur/features/views/auth/models/user_model.dart';
import 'package:charteur/features/views/common/sites/models/filelist_response_model.dart';
import 'package:charteur/services/api_urls.dart';

class SitesRepository {
  final _network = NetworkCaller.instance;

  // ── Get Assign Sites ─────────────────────────────────────────────
  Future<ApiResult<SiteListResponseModel>> getAssignedSites() async {
    final response = await _network.getRequest(
      url: ApiUrls.assignedSiteUrl,
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

}