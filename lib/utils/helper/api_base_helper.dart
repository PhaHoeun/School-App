import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_app/cores/auth/auth_provider/auth_provider.dart';

import '../../constrants/api_service.dart';

class ErrorModel {
  final int? statusCode;
  final dynamic bodyString;
  const ErrorModel({this.statusCode, this.bodyString});
}

enum METHODE { get, post, delete, update }

class ApiBaseHelper {
  final AuthProvider authProvider; // always points to AuthProvider
  final Duration timeout = const Duration(seconds: 90);
  String? baseurl = ApiService.baseUrl;

  ApiBaseHelper(this.authProvider);

  /// Always reads the latest token from authProvider
  Future<Map<String, String>> headerDefault({
    bool isAuthorize = true,
    String token = '',
  }) async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (isAuthorize && token.isNotEmpty) 'Authorization': token,
    };
  }

  Future<dynamic> onNetworkRequesting({
    required String url,
    Map<String, String>? header,
    Map<String, dynamic>? body,
    required METHODE methode,
    bool isAuthorize = true,
    String otherBaseUrl = '',
    String token = '',
    bool isRouteToLoginWhen401or403 = true,
  }) async {
    final fullUrl = otherBaseUrl.isEmpty ? "$baseurl$url" : "$otherBaseUrl$url";
    final headerDefault = await this.headerDefault(
      isAuthorize: isAuthorize,
      token: token,
    );

    http.Response response;

    try {
      switch (methode) {
        case METHODE.get:
          response = await http
              .get(Uri.parse(fullUrl), headers: header ?? headerDefault)
              .timeout(timeout);
          break;
        case METHODE.post:
          if (body == null) return Future.error('Body required');
          response = await http
              .post(
                Uri.parse(fullUrl),
                headers: header ?? headerDefault,
                body: json.encode(body),
              )
              .timeout(timeout);
          break;
        case METHODE.delete:
          response = await http
              .delete(Uri.parse(fullUrl), headers: header ?? headerDefault)
              .timeout(timeout);
          break;
        case METHODE.update:
          if (body == null) return Future.error('Body required');
          response = await http
              .put(
                Uri.parse(fullUrl),
                headers: header ?? headerDefault,
                body: json.encode(body),
              )
              .timeout(timeout);
          break;
      }

      return _returnResponse(response, isRouteToLoginWhen401or403);
    } catch (e) {
      return Future.error(e);
    }
  }

  dynamic _returnResponse(
    http.Response response,
    bool isRouteToLoginWhen401or403,
  ) {
    final statusCode = response.statusCode;
    final bodyString = response.body.isNotEmpty
        ? json.decode(response.body)
        : null;

    if (statusCode >= 200 && statusCode < 300) {
      return bodyString;
    } else if (statusCode == 401 || statusCode == 403) {
      if (isRouteToLoginWhen401or403) authProvider.signOut();
      return Future.error(
        ErrorModel(statusCode: statusCode, bodyString: bodyString),
      );
    } else {
      return Future.error(
        ErrorModel(statusCode: statusCode, bodyString: bodyString),
      );
    }
  }
}
