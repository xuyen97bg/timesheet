import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../model/error_response.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  late String scheme, host;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 90;

  String token = "";
  final Map<String, String> _mainHeaders = {};

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN) ??
        "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    Uri uri = Uri.parse(appBaseUrl);
    scheme = uri.scheme;
    host = uri.host;
    if (Foundation.kDebugMode) {
      print('Token: $token');
    }
    updateHeader(
      token,
      null,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE)
    );
  }

  void updateHeader(
      String token, List<int>? zoneIDs, String? languageCode) {
    _mainHeaders['Content-Type'] = 'application/json; charset=utf-8';
    _mainHeaders['Authorization'] = token;
    _mainHeaders[AppConstants.LOCALIZATION_KEY]
    = languageCode ?? AppConstants.languages[0].languageCode;
  }

  Future<Response> getData(String path,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) async {
    try {
      Uri mUri = Uri(queryParameters: queryParameters,scheme: scheme,host: host,path: path);
      if (Foundation.kDebugMode) {
        print('====> API Call: $mUri\nHeader: $_mainHeaders');
      }
      Http.Response _response = await Http.get(mUri, headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, path);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(
      {required String path, dynamic body, Map<String, String>? headers,Map<String, dynamic>? queryParameters }) async {
    try {
      Uri mUri = Uri(scheme: scheme,host: host,path: path, queryParameters: queryParameters);
      _mainHeaders['Content-Type'] = 'application/json; charset=utf-8';
      _mainHeaders['Authorization'] = token;
      if (Foundation.kDebugMode) {
        print('====> API Call: $mUri\nHeader: $_mainHeaders');
        try{
          print('====> API Body: ${body.toString()}');
          print('====> API Body: ${jsonEncode(body).toString()}');

        }catch(ex){
          print('API body error ${ex.toString()}');
        }

      }
      Http.Response _response = await Http.post(
          mUri,
          body:jsonEncode(body).toString(),
          headers: headers ?? _mainHeaders
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, path);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postLogin(String uri, dynamic body) async {
    _mainHeaders['Content-Type'] = 'application/x-www-form-urlencoded';
    _mainHeaders['Authorization'] = 'Basic Y29yZV9jbGllbnQ6c2VjcmV0';
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: ${jsonEncode(body).toString()}');
      }
      Http.Response _response = await Http.post(
          Uri.parse(appBaseUrl + uri),
          body: body,
          headers: _mainHeaders
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String path, Map<String, String> body, List<MultipartBody> multipartBody,
      {required Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $path\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + path));
      _request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List _list = await multipart.file.readAsBytes();
          _request.files.add(Http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            _list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, path);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(
      {required String path, dynamic body, Map<String, String>? headers}) async {
    _mainHeaders['Content-Type'] = 'application/json; charset=utf-8';
    _mainHeaders['Authorization'] = token;
    try {
      print('putData');
      Uri uri = Uri(scheme: scheme,host: host,path: path);
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.put(
        uri,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, path);
    } catch (e) {
      print('$e');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {required Map<String, String> headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {}
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors![0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if (Foundation.kDebugMode) {
      print(
          '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }

}


class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
