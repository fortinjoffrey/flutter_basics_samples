import 'package:dio/dio.dart';
import 'package:flutter_basics_samples/core/network/models/request_key.dart';

class RequestCanceller {
  final _tokens = <RequestKey, CancelToken>{};

  CancelToken create(RequestKey key) {
    // _tokens[key]?.cancel();
    final token = CancelToken();
    _tokens[key] = token;
    return token;
  }

  void cancel(RequestKey key) {
    _tokens[key]?.cancel();
    _tokens.remove(key);
  }

  void remove(RequestKey key) {
    _tokens.remove(key);
  }

  void cancelAll() {
    for (final token in _tokens.values) {
      token.cancel();
    }
    _tokens.clear();
  }
}
