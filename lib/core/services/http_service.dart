import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tajwid/app/constants/api_urls.dart';
import 'package:tajwid/app/constants/http_codes.dart';
import 'package:tajwid/core/exceptions/http_exceptions.dart';
import 'package:tajwid/features/auth/provider/auth_provider.dart';

class HttpService {
  final String baseUrl;
  final Duration timeout;

  HttpService({
    this.baseUrl = baseURL,
    this.timeout = const Duration(seconds: 75),
  });

  void _log(String message) {
    print('[API LOG]: $message');
  }

  Future<dynamic> get(String path, {String tokenArg = ""}) async {
    try {
      final uri = Uri.parse(baseUrl + path);

      _log("GET Request: $uri");
      _log("Headers: Authorization: ${AuthProvider.token}");

      final response = await http
          .get(
            uri,
            headers: {
              'Authorization': "Bearer ${AuthProvider.token}",
              'Content-Type': 'application/json',
            },
          )
          .timeout(timeout);

      _log("Response Status: ${response.statusCode}");
      _log("Response Body: ${response.body}");

      _handleErrors(response.statusCode, json.decode(response.body));
      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  Future<dynamic> post(
    String path, {
    required Map<dynamic, dynamic> requestBody,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path);

      _log("POST Request: $uri");
      _log("Headers: Authorization: ${AuthProvider.token}");
      _log("Request Body: ${jsonEncode(requestBody)}");

      final response = await http
          .post(
            uri,
            body: jsonEncode(requestBody),
            headers: {
              'Authorization': "Bearer ${AuthProvider.token}",
              'Content-Type': 'application/json',
            },
          )
          .timeout(timeout);

      _log("Response Status: ${response.statusCode}");
      _log("Response Body: ${response.body}");

      _handleErrors(response.statusCode, json.decode(response.body));
      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  Future<dynamic> postMultipart(
    String path, {
    required Map<String, File> files,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + path);

      _log("POST Multipart Request: $uri");
      _log("Headers: Authorization: ${AuthProvider.token}");
      // _log("Fields: $fields");
      _log("Files: ${files.keys.toList()}");

      final request = http.MultipartRequest("POST", uri);

      // Add headers
      request.headers.addAll({'Authorization': "Bearer ${AuthProvider.token}"});

      // Add text fields
      // request.fields.addAll(fields);

      // Add files (if any)
      for (final entry in files.entries) {
        final file = await http.MultipartFile.fromPath(
          entry.key,
          entry.value.path,
        );
        request.files.add(file);
      }

      // Send request
      final streamedResponse = await request.send().timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);

      _log("Response Status: ${response.statusCode}");
      _log("Response Body: ${response.body}");

      _handleErrors(response.statusCode, json.decode(response.body));
      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  Future<dynamic> patch(String path, {required Map requestBody}) async {
    try {
      final uri = Uri.parse(baseUrl + path);

      _log("PATCH Request: $uri");
      _log("Headers: Authorization: ${AuthProvider.token}");
      _log("Request Body: $requestBody");

      final response = await http
          .patch(
            uri,
            body: jsonEncode(requestBody),
            headers: {
              'Authorization': "Bearer ${AuthProvider.token}",
              'Content-Type': 'application/json',
            },
          )
          .timeout(timeout);

      _log("Response Status: ${response.statusCode}");
      _log("Response Body: ${response.body}");

      _handleErrors(response.statusCode, json.decode(response.body));

      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  Future<dynamic> put(String path, {required Map requestBody}) async {
    try {
      final uri = Uri.parse(baseUrl + path);

      _log("PUT Request: $uri");
      _log("Headers: Authorization: ${AuthProvider.token}");
      _log("Request Body: $requestBody");

      final response = await http
          .put(
            uri,
            body: jsonEncode(requestBody),
            headers: {
              'Authorization': "Bearer ${AuthProvider.token}",
              'Content-Type': 'application/json',
            },
          )
          .timeout(timeout);

      _log("Response Status: ${response.statusCode}");
      _log("Response Body: ${response.body}");

      _handleErrors(response.statusCode, json.decode(response.body));

      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  // Future<dynamic> delete(String path, Map<String, dynamic> requestBody) async {
  //   try {
  //     final uri = Uri.parse(baseUrl + path);
  //     final token = AuthProvider.token;
  //     final response = await http.delete(uri, headers: {
  //       'Authorization': token,
  //       'Content-Type': 'application/json',
  //     }).timeout(timeout);
  //     _handleErrors(response);
  //     return json.decode(response.body);
  //   } on SocketException {
  //     throw const SocketException("No internet connection");
  //   } on TimeoutException {
  //     throw TimeoutException('API not responded in time');
  //   }
  // }

  void _handleErrors(int statusCode, Map<dynamic, dynamic> response) {
    final message = response["detail"];

    switch (statusCode) {
      case HttpCodes.OK:
      case HttpCodes.Accepted:
      case HttpCodes.Created:
        return;

      case HttpCodes.BadRequest:
        throw BadRequestException(message);

      case HttpCodes.Unauthorized:
      case HttpCodes.Forbidden:
        throw UnauthorizedException(message);

      case HttpCodes.NotFound:
        throw BadRequestException(message);

      case HttpCodes.InternalServerError:
      case HttpCodes.ServiceUnavailable:
      case HttpCodes.GatewayTimeout:
      default:
        throw UnknownException(message);
    }
  }
}
