// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/data/core/unauthorised_exception.dart';

class ApiClient {
  final Client _client;
  ApiClient(
    this._client,
  );

  Future<dynamic> get(String path, {Map<dynamic, dynamic>? params}) async {
    final url = Uri.parse(getPath(path, params));
    final response = await _client.get(url, headers: {
      'Content-Type': 'application/json',
    });


    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, {Map<dynamic, dynamic>? params}) async {
    final url = Uri.parse(getPath(path, null));
    final response = await _client.post(
      url,
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, Map<dynamic, dynamic>? params) {
    var uri = Uri.parse(ApiConstants.BASE_URL + path);
    if (params != null) {
      uri = uri.replace(queryParameters: {
        'api_key': ApiConstants.API_KEY,
        ...params,
      });
    } else {
      uri = uri.replace(queryParameters: {'api_key': ApiConstants.API_KEY});
    }
    return uri.toString();
  }

  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
    Request request = Request('DELETE', Uri.parse(getPath(path, null)));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(params);
    final response = await _client.send(request).then(
          (value) => Response.fromStream(value),
        );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
