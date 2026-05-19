import 'dart:convert';
import 'package:chat_app/src/core/network/api_exception.dart';
import 'package:chat_app/src/core/network/api_success.dart';
import 'package:http/http.dart' as http;

enum AuthType { bearer, token }

final String baseUrl = 'http://127.0.0.1:8000';

class ApiClient {
  final http.Client _client;
  String? _token;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  String? get token => _token;
  void setToken(String? token) => _token = token;

  http.Client get httpClient => _client;

  Map<String, String> buildHeaders({
    bool withAuth = false,
    AuthType authType = AuthType.bearer,
    String? contentType = 'application/json',
    Map<String, String>? extra,
  }) {
    final headers = <String, String>{};
    headers['Accept'] = 'application/json';
    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }

    if (withAuth && _token != null) {
      switch (authType) {
        case AuthType.bearer:
          headers['Authorization'] = 'Bearer $_token';
          break;
        case AuthType.token:
          headers['token'] = _token!;
          break;
      }
    }

    if (extra != null) {
      headers.addAll(extra);
    }

    return headers;
  }

  Uri buildUri(
    String path, {
    Map<String, String>? queryParameters,
    AuthType authType = AuthType.bearer,
  }) {
    return Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
  }

  ApiSuccess<dynamic> decodeResponse(
    int statusCode,
    String body, {
    bool allowEmpty = true,
  }) {
    if (statusCode >= 200 && statusCode < 300) {
      if (body.isEmpty && allowEmpty) {
        return ApiSuccess(
          statusCode: statusCode,
          message: 'Success',
          data: null,
        );
      }

      final decoded = jsonDecode(body);

      if (decoded is Map<String, dynamic>) {
        return ApiSuccess(
          statusCode: statusCode,
          message: decoded['message']?.toString() ?? 'Success',
          data: decoded['data'],
          rawBody: decoded,
        );
      }

      return ApiSuccess(
        statusCode: statusCode,
        message: 'Success',
        data: decoded,
      );
    }

    dynamic decodedBody;
    try {
      decodedBody = body.isNotEmpty ? jsonDecode(body) : null;
    } catch (_) {
      decodedBody = body;
    }

    final message = decodedBody is Map<String, dynamic>
        ? (decodedBody['message']?.toString() ?? 'Unknown error')
        : 'Unknown error';

    throw ApiException(statusCode, message, decodedBody);
  }

  Future<ApiSuccess<dynamic>> get(
    String path, {
    Map<String, String>? queryParameters,
    bool withAuth = true,
    AuthType authType = AuthType.bearer,
  }) async {
    final uri = buildUri(
      path,
      queryParameters: queryParameters,
      authType: authType,
    );

    final res = await _client.get(
      uri,
      headers: buildHeaders(withAuth: withAuth, authType: authType),
    );

    return decodeResponse(res.statusCode, res.body);
  }

  Future<ApiSuccess<dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
    bool withAuth = true,
    AuthType authType = AuthType.bearer,
  }) async {
    final uri = buildUri(
      path,
      queryParameters: queryParameters,
      authType: authType,
    );

    final res = await _client.post(
      uri,
      headers: buildHeaders(withAuth: withAuth, authType: authType),
      body: body != null ? jsonEncode(body) : null,
    );

    return decodeResponse(res.statusCode, res.body);
  }

  Future<ApiSuccess<dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
    bool withAuth = true,
    AuthType authType = AuthType.bearer,
  }) async {
    final uri = buildUri(
      path,
      queryParameters: queryParameters,
      authType: authType,
    );

    final res = await _client.put(
      uri,
      headers: buildHeaders(withAuth: withAuth, authType: authType),
      body: body != null ? jsonEncode(body) : null,
    );

    return decodeResponse(res.statusCode, res.body);
  }

  Future<ApiSuccess<dynamic>> delete(
    String path, {
    Map<String, String>? queryParameters,
    bool withAuth = true,
    AuthType authType = AuthType.bearer,
  }) async {
    final uri = buildUri(
      path,
      queryParameters: queryParameters,
      authType: authType,
    );

    final res = await _client.delete(
      uri,
      headers: buildHeaders(withAuth: withAuth, authType: authType),
    );

    return decodeResponse(res.statusCode, res.body);
  }

  void close() {
    _client.close();
  }
}
