
import 'dart:convert';

import 'package:charteur/core/network/api_results.dart';
import 'package:charteur/core/network/dio_api_client.dart';
import 'package:charteur/features/views/admin/home/models/comment_response_model.dart';
import 'package:charteur/features/views/admin/home/models/file_details_view_model.dart';
import 'package:charteur/features/views/admin/home/models/remarks_response_model.dart';
import 'package:charteur/features/views/admin/home/models/site_details_responsemodel.dart';
import 'package:charteur/features/views/admin/home/models/sitelist_response_model.dart';
import 'package:charteur/features/views/admin/home/models/workerlist_response_model.dart';
import 'package:charteur/services/api_urls.dart';

class HomeRepository {
  final _network = NetworkCaller.instance;

  // ── sites ─────────────────────────────────────────────
  Future<ApiResult<SiteListResponseModel>> getSites() async {
    final response = await _network.getRequest(
      url: ApiUrls.siteUrl,
    );

    if (response.isSuccess) {
      return ApiResult.success(SiteListResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

  // ── get remarks ─────────────────────────────────────────────
  Future<ApiResult<RemarkDetailsResponseModel>> getRemarks({String taskId = ''}) async {
    final response = await _network.getRequest(
      url: ApiUrls.remarkUrl(taskId: taskId),
    );

    if (response.isSuccess) {
      return ApiResult.success(RemarkDetailsResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }
  // ── sites Details ─────────────────────────────────────────────
  Future<ApiResult<TaskDetailsResponseModel>> getSiteDetails({String taskId = ''}) async {
    final response = await _network.getRequest(
      url: ApiUrls.siteDetailsUrl(taskId),
    );

    if (response.isSuccess) {
      return ApiResult.success(TaskDetailsResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

  // ── Get files ─────────────────────────────────────────────
  Future<ApiResult<FileDetailsResponseModel>> getFileDetails({String? fileId}) async {
    final response = await _network.getRequest(
      url: ApiUrls.siteFileViewUrl(fileId??''),
    );

    if (response.isSuccess) {
      return ApiResult.success(FileDetailsResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

  // ── Get workers/office_admin ─────────────────────────────────────────────
  Future<ApiResult<WorkerListResponseModel>> getWorkersOrAdmins({String? role}) async {
    final response = await _network.getRequest(
      url:role?.contains('all')==true ? ApiUrls.allWorkersUrl :ApiUrls.workersOrAdminsUrl(role??'worker'),
    );

    if (response.isSuccess) {
      return ApiResult.success(WorkerListResponseModel.fromJson(response.responseBody));
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

  // ── update work ──────────────────────────────────────────
  Future<ApiResult<String>> updateWorkStatus({
    required String status,
    required String taskId,
  }) async {
    final response = await _network.patchRequest(
      url: ApiUrls.updateWorkStatusUrl(taskId: taskId),
      body: {
        "status": status
      },
    );

    if (response.isSuccess) {
      return ApiResult.success('Updated successfully');
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

  // ── add remark ──────────────────────────────────────────
  Future<ApiResult<String>> addRemark({
    String? filePath,
    String? fileName,
    String? taskId,
    String? description,
  }) async {

    final response = await _network.multipartRequest(
      url: ApiUrls.addRemarkUrl(taskId ?? ''),
      body: {
        "images": await _network.toMultipartFile(filePath!, fileName: fileName),
        "data": jsonEncode({
          "description": description,
        }),
      },
    );

    if (response.isSuccess) {
      return ApiResult.success('remark added successfully');
    }
    return ApiResult.failure(response.errorMassage ?? 'Upload failed');
  }

  // ── add Comments ──────────────────────────────────────────
  Future<ApiResult<String>> addComment({
    String? filePath,
    String? fileName,
    String? taskId,
    String? description,
  }) async {

    final response = await _network.multipartRequest(
      url: ApiUrls.addCommentUrl(taskId ?? ''),
      body: {
        // "images": await _network.toMultipartFile(filePath!, fileName: fileName),
        "data": jsonEncode({
          "message": description,
        }),
      },
    );

    if (response.isSuccess) {
      return ApiResult.success('Added successfully');
    }
    return ApiResult.failure(response.errorMassage ?? 'Upload failed');
  }

  // ── Get Comment ─────────────────────────────────────────────
  Future<ApiResult<CommentsResponseModel>> getComment({String? taskId}) async {
    final response = await _network.getRequest(
      url: ApiUrls.getCommentUrl(taskId??''),
    );

    if (response.isSuccess) {
      return ApiResult.success(CommentsResponseModel.fromJson(response.responseBody));
    }
    return ApiResult.failure(response.errorMassage ?? 'Login failed');
  }

}