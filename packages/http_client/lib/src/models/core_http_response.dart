class CoreHttpResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  final Map<String, dynamic> headers;
  final bool isRedirect;
  final Uri realUri;
  final Map<String, dynamic> extra;

  const CoreHttpResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.headers = const {},
    this.isRedirect = false,
    required this.realUri,
    this.extra = const {},
  });

  @override
  String toString() {
    return 'CoreHttpResponse('
        'data: $data, '
        'statusCode: $statusCode, '
        'statusMessage: $statusMessage, '
        'headers: $headers, '
        'isRedirect: $isRedirect, '
        'realUri: $realUri'
        ')';
  }
} 