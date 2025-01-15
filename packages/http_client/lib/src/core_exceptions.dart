import 'package:http_client/src/response.dart';

enum CoreHttpClientExceptionType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badResponse,
  cancel,
  connectionError,
  emptyResponse,
  unknown,
}

class CoreHttpClientException implements Exception {
  final Uri uri;
  final String method;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final dynamic data;
  final Response? response;
  final CoreHttpClientExceptionType type;
  final Object? error;
  final StackTrace stackTrace;
  final String? message;

  const CoreHttpClientException({
    required this.uri,
    required this.method,
    this.headers,
    this.queryParameters,
    this.data,
    this.response,
    required this.type,
    this.error,
    required this.stackTrace,
    this.message,
  });

  int? get statusCode => response?.statusCode;
  Map<String, dynamic>? get responseHeaders => response?.headers;
  dynamic get responseData => response?.data;

  @override
  String toString() {
    return 'CoreHttpClientException('
        'type: $type, '
        'uri: $uri, '
        'method: $method, '
        'headers: $headers, '
        'queryParameters: $queryParameters, '
        'data: $data, '
        'response: $response, '
        'error: $error, '
        'message: $message'
        ')';
  }
}
