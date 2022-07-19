import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

class ApiBaseHandler {
  final http.Client client;

  ApiBaseHandler({required this.client});

  final _keepAliveHeaders = {
    'Connection': 'keep-alive',
    'Keep-Alive': 'timeout=5, max=100',
  };

  Uri _getUriFromString(String url) {
    return Uri.parse(url);
  }

  /// performs GET request to the given [url] with the given [headers].
  ///
  /// throws Customized Exceptions for all status codes.
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    String? token,
  }) async {
    final response = await client.get(
      _getUriFromString(url),
      headers: (headers?..addAll(_keepAliveHeaders)) ??
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            ..._keepAliveHeaders,
          },
    );

    return _handleResponse(url, token, response);
  }

  /// performs POST request to the given [url] with the given [headers] and [body].
  ///
  /// throws Customized Exceptions for all status codes.
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    String? token,
    String? storeId,
    String? areaId,
    required String langCode,
  }) async {
    final response = await client.post(
      _getUriFromString(url),
      headers: (headers?..addAll(_keepAliveHeaders)) ??
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            ..._keepAliveHeaders,
          },
      body: jsonEncode(body),
    );

    return _handleResponse(url, token, response);
  }

  /// performs PUT request to the given [url] with the given [headers] and [body].
  ///
  /// throws Customized Exceptions for all status codes.
  Future<dynamic> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    String? storeId,
    String? areaId,
    required String token,
    required String langCode,
  }) async {
    final response = await client.put(
      _getUriFromString(url),
      headers: (headers?..addAll(_keepAliveHeaders)) ??
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            ..._keepAliveHeaders,
          },
      body: jsonEncode(body),
    );

    return _handleResponse(url, token, response);
  }

  /// performs PATCH request to the given [url] with the given [headers] and [body].
  ///
  /// throws Customized Exceptions for all status codes.
  Future<dynamic> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    String? storeId,
    String? areaId,
    String? token,
    required String langCode,
  }) async {
    final response = await client.patch(
      _getUriFromString(url),
      headers: (headers?..addAll(_keepAliveHeaders)) ??
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            ..._keepAliveHeaders,
          },
      body: jsonEncode(body),
    );

    return _handleResponse(url, token, response);
  }

  /// performs DELETE request to the given [url] with the given [headers].
  ///
  /// throws Customized Exceptions for all status codes.
  Future<dynamic> delete(
    String url, {
    Map<String, String>? headers,
    String? storeId,
    String? areaId,
    String? token,
    required String langCode,
  }) async {
    final response = await client.delete(
      _getUriFromString(url),
      headers: (headers?..addAll(_keepAliveHeaders)) ??
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            ..._keepAliveHeaders,
          },
    );

    return _handleResponse(url, token, response);
  }

  /// handles http responses and return the parsedJson in case of the response success.
  ///
  /// throws a customized [Exception] based on the response status code
  dynamic _handleResponse(String url, String? token, http.Response response) {
    if (ApiEndpoints.isDebugging) {
      var time = DateTime.now();
      log(
        url + ' token: ' + token.toString(),
        name: '${time.hour}:${time.minute}:${time.second}:${time.millisecond}',
      );

      debugPrint(url.split('/').last + ' Response: ${response.body}');
      debugPrint(url.split('/').last + ' Status code: ${response.statusCode}');
    }

    final parsedJson = json.decode(utf8.decode(response.bodyBytes));

    return _handleResponseStatusCode(
      parsedJson,
      response.statusCode,
      response.request,
      response.headers,
    );
  }

  /// handels the http response by returning the parsedJson when the request successed.
  /// and throws Customized Exceptions for all other status codes.
  ///
  dynamic _handleResponseStatusCode(
    parsedJson,
    statusCode,
    http.BaseRequest? request,
    responseHeaders,
  ) async {
    if (ApiEndpoints.isDebugging) {
      debugPrint(parsedJson.toString());
      debugPrint('Status Code: $statusCode');
    }

    switch (statusCode) {
      case 200: // Status code OK
      case 201: // Status code Created
        return parsedJson;
      case 500:
        throw ServerException(
          message:
              'An Error occurres while performing your request. please try again later.',
        );
      default:
        throw ServerException(message: _extractErrorMessage(parsedJson));
    }
  }

  /// extracts and returns the error message from the response.
  ///
  /// returns a custom default message when there are now error messages found in the response.
  String _extractErrorMessage(Map<String, dynamic> parsedJson) {
    //! Here we can add the logic to extract the error message from the API Error Response.
    //! if the structure is the same for all API Errors responses.

    if (parsedJson['errors'] != null) {
      return parsedJson['errors']?.toString() ??
          'We have an error performing this operation. please try again later.';
    }

    if (parsedJson['message'] != null) {
      return parsedJson['message']?.toString() ??
          'We have an error performing this operation. please try again later.';
    }

    if (parsedJson['error'] != null) {
      return parsedJson['error']?.toString() ??
          'We have an error performing this operation. please try again later.';
    }

    return parsedJson.toString();
  }
}
