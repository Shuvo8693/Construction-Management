import 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://your-api-base-url.com/api/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }

  // ─── GET ───────────────────────────────────────────────
  static Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    return instance.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // ─── POST ──────────────────────────────────────────────
  static Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    return instance.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // ─── PUT ───────────────────────────────────────────────
  static Future<Response> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    return instance.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // ─── PATCH ─────────────────────────────────────────────
  static Future<Response> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    return instance.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // ─── DELETE ────────────────────────────────────────────
  static Future<Response> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    return instance.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // ─── UPLOAD ────────────────────────────────────────────
  static Future<Response> uploadFile(
      String path,
      String filePath, {
        String fileKey = 'file',
        Map<String, dynamic>? extraFields,
        ProgressCallback? onSendProgress,
      }) async {
    final formData = FormData.fromMap({
      fileKey: await MultipartFile.fromFile(filePath),
      ...?extraFields,
    });

    return instance.post(
      path,
      data: formData,
      onSendProgress: onSendProgress,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  // ─── SET TOKEN ─────────────────────────────────────────
  static void setAuthToken(String token) {
    instance.options.headers['Authorization'] = 'Bearer $token';
  }

  static void clearAuthToken() {
    instance.options.headers.remove('Authorization');
  }
}

// ─── INTERCEPTORS ──────────────────────────────────────────────────────────────

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Optionally load token from secure storage here
    // final token = SecureStorage.getToken();
    // if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token refresh here if needed
      // Then retry: handler.resolve(await _retry(err.requestOptions));
    }
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('→ [${options.method}] ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('← [${response.statusCode}] ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('✗ [${err.response?.statusCode}] ${err.message}');
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = _mapError(err);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: message,
      ),
    );
  }

  String _mapError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        return _mapStatusCode(err.response?.statusCode);
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  String _mapStatusCode(int? code) {
    switch (code) {
      case 400: return 'Bad request.';
      case 401: return 'Unauthorized. Please log in again.';
      case 403: return 'Forbidden. You don\'t have permission.';
      case 404: return 'Resource not found.';
      case 422: return 'Validation error.';
      case 500: return 'Internal server error.';
      default:   return 'Unexpected error (code: $code).';
    }
  }
}