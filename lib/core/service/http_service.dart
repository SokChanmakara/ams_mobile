import 'package:dio/dio.dart';

class HttpService {
  HttpService._();

  static HttpService? _instance;
  static Dio? _dio;

  /// Get HttpService instance
  static HttpService get instance {
    if (_instance == null) {
      throw Exception(
        'HttpService not initialized. Call HttpService.init() before using.',
      );
    }
    return _instance!;
  }

  /// Initialize HttpService
  /// Call this in main() or at app startup
  static void init({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
    Map<String, dynamic>? defaultHeaders,
    List<Interceptor>? interceptors,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        headers: defaultHeaders ??
            {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
        validateStatus: (status) => status != null && status < 500,
      ),
    );
    if (interceptors != null) {
      _dio!.interceptors.addAll(interceptors);
    }
    _instance = HttpService._();
  }

  /// Get the underlying Dio instance for advanced usage
  Dio get dio {
    if (_dio == null) {
      throw Exception(
        'HttpService not initialized. Call HttpService.init() before using.',
      );
    }
    return _dio!;
  }

  /// GET request
  Future<Response<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.get<T>(
      endpoint,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.post<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.put<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.patch<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// HEAD request
  Future<Response<T>> head<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await dio.head<T>(
      endpoint,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Download file
  Future<Response> download(
    String urlPath,
    String savePath, {
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    return await dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  /// Upload file using FormData
  Future<Response<T>> uploadFile<T>(
    String endpoint, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    return await dio.post<T>(
      endpoint,
      data: formData,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }

  /// Generic request method
  Future<Response<T>> request<T>(
    String endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await dio.request<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Add interceptor dynamically
  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  /// Remove interceptor
  void removeInterceptor(Interceptor interceptor) {
    dio.interceptors.remove(interceptor);
  }

  /// Clear all interceptors
  void clearInterceptors() {
    dio.interceptors.clear();
  }

  /// Update base options
  void updateBaseOptions({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, dynamic>? headers,
  }) {
    if (baseUrl != null) dio.options.baseUrl = baseUrl;
    if (connectTimeout != null) dio.options.connectTimeout = connectTimeout;
    if (receiveTimeout != null) dio.options.receiveTimeout = receiveTimeout;
    if (sendTimeout != null) dio.options.sendTimeout = sendTimeout;
    if (headers != null) dio.options.headers.addAll(headers);
  }

  /// Add authorization token to headers
  void setAuthToken(String token, {String type = 'Bearer'}) {
    dio.options.headers['Authorization'] = '$type $token';
  }

  /// Remove authorization token from headers
  void removeAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  /// Close Dio instance
  void close({bool force = false}) {
    dio.close(force: force);
  }
}
