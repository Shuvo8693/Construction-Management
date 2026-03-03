
import 'dart:convert';

import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/common/profile/models/profile_response_model.dart';
import 'package:charteur/services/api_urls.dart';



class ProfileRepository {
  final _network = NetworkCaller.instance;

  Future<ApiResult<ProfileResponseModel>> getProfile() async {
    final response = await _network.getRequest(url: ApiUrls.profileUrl);
    if (response.isSuccess) {
      return ApiResult.success(ProfileResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Failed to get profile');
  }
// {
  //   "name": "John Doe",
  //   "phoneNumber": "+1234567890",
  //   "address": "123 Main Street, New York, USA",
  //   "experience": 5,
  //   "expertiseArea": "Civil Engineering",
  //   "employmentType": "Full-time"
  // }
  // ── Update Profile ───────────────────────────────────────────
  Future<ApiResult<String>> updateProfile({
    String? filePath,
    String? fileName,
    // Profile Info
    String? fullName,
    String? phone,
    String? email,
    String? address,
    // Professional Info
    String? employmentType,
    String? expertise,
    String? experience,
  }) async {
    final response = await _network.multipartRequest(
      url: ApiUrls.updateProfileUrl,
      method: HttpMethod.patch,
      body: {
        if (filePath != null)
          "image": await _network.toMultipartFile(filePath, fileName: fileName),
        "data": jsonEncode({
          "name":           fullName,
          "phone":          phone,
          "email":          email,
          "address":        address,
          "employmentType": employmentType,
          "expertiseArea":  expertise,
          "experience":     experience,
        }),
      },
    );

    if (response.isSuccess) {
      return ApiResult.success('Profile updated successfully');
    }
    return ApiResult.failure(response.errorMassage ?? 'Update failed');
  }
}