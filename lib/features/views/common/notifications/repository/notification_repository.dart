
import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/common/notifications/models/notification_response_model.dart';
import 'package:charteur/services/api_urls.dart';

class NotificationRepository {
  final _network = NetworkCaller.instance;

  // ── sites ─────────────────────────────────────────────
  Future<ApiResult<NotificationResponse>> getNotifications() async {
    final response = await _network.getRequest(
      url: ApiUrls.notificationsUrl,
    );
    if (response.isSuccess) {
      return ApiResult.success(NotificationResponse.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

}