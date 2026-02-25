// features/auth/repository/auth_repository.dart


import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/auth/models/user_model.dart';
import 'package:charteur/services/api_urls.dart';

class AuthRepository {
  final _network = NetworkCaller.instance;

  // ── Login ─────────────────────────────────────────────
  Future<ApiResult<UserModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await _network.postRequest(
      url: ApiUrls.login,
      body: {'email': email, 'password': password},
    );

    if (response.isSuccess) {
      return ApiResult.success(UserModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

  // ── Register ──────────────────────────────────────────
  Future<ApiResult<String>> register({
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

  // ── Send OTP ──────────────────────────────────────────
  Future<ApiResult<void>> sendOtp(String email) async {
    final response = await _network.postRequest(
      url: ApiUrls.resendOtp(email),
    );

    if (response.isSuccess) return ApiResult.success(null);
    return ApiResult.failure(response.errorMassage ?? 'Failed to send OTP');
  }

  // ── Verify OTP ────────────────────────────────────────
  Future<ApiResult<String>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _network.postRequest(
      url: ApiUrls.verifyOtp,
      body: {'email': email, 'otp': otp},
    );

    if (response.isSuccess) return ApiResult.success(response.responseBody['data']['accessToken']);
    return ApiResult.failure(response.errorMassage ?? 'Invalid OTP');
  }

  // ── Forgot Password ───────────────────────────────────
  Future<ApiResult<void>> forgotPassword(String email) async {
    final response = await _network.postRequest(
      url: ApiUrls.forgetPassword,
      body: {'email': email},
    );

    if (response.isSuccess) return ApiResult.success(null);
    return ApiResult.failure(response.errorMassage ?? 'Failed to send reset link');
  }

  // ── Reset Password ────────────────────────────────────
  Future<ApiResult<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await _network.postRequest(
      url: ApiUrls.resetPassword,
      body: {'token': token, 'password': newPassword},
    );

    if (response.isSuccess) return ApiResult.success(null);
    return ApiResult.failure(response.errorMassage ?? 'Failed to reset password');
  }

  // ── Change Password ───────────────────────────────────
  Future<ApiResult<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await _network.postRequest(
      url: ApiUrls.changePassword,
      body: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );

    if (response.isSuccess) return ApiResult.success(null);
    return ApiResult.failure(response.errorMassage ?? 'Failed to change password');
  }

  // ── Logout ────────────────────────────────────────────
  Future<ApiResult<void>> logout() async {
    final response = await _network.postRequest(url: " "); /// need url

    if (response.isSuccess) return ApiResult.success(null);
    return ApiResult.failure(response.errorMassage ?? 'Logout failed');
  }
}