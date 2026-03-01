
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/common/profile/models/profile_response_model.dart';
import 'package:charteur/services/api_urls.dart';



class ProfileRepository {
  final _network = NetworkCaller.instance;

  // ── Get Profile ─────────────────────────────────────────────
  Future<ApiResult<ProfileResponseModel>> getProfile() async {
    final response = await _network.getRequest(
      url: ApiUrls.profileUrl,
    );

    if (response.isSuccess) {
      return ApiResult.success(ProfileResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }



}