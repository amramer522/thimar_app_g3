import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_log/quick_log.dart';
Logger log = const Logger("");

class DioHelper {
  static final _dio = Dio(BaseOptions(baseUrl: "https://thimar.amr.aait-d.com/api/", headers: {
    "Accept": "application/json",
    "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGhpbWFyLmFtci5hYWl0LWQuY29tXC9hcGlcL2xvZ2luIiwiaWF0IjoxNzA1MzQ1ODA4LCJleHAiOjE3MzY4ODE4MDgsIm5iZiI6MTcwNTM0NTgwOCwianRpIjoiU3pWcWJNNTJ0UmJVYk5rbiIsInN1YiI6MzkwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.FtxC_UX9HY-BmgbsonZ0bW9rcZaG4DQa9tlvC1v_AqE"
  }));

  // todo search for interceptor

  static Future<CustomResponse> send(String path, {Map<String, dynamic>? data}) async {
    try {

      final response = await _dio.post(path, data: FormData.fromMap(data ?? {}));
      printResponse(response);

      return CustomResponse(isSuccess: true, msg: response.data["message"], data: response.data);
    } on DioException catch (ex) {
      print(ex.message);
      print(ex.response);
      printResponse(ex.response!);

      return CustomResponse(isSuccess: false, msg: ex.response?.data["message"], data: ex.response?.data);
    }
  }

  static Future<CustomResponse> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      // print(response.data);
      printResponse(response);
      return CustomResponse(isSuccess: true, msg: response.data["message"], data: response.data);

    } on DioException catch (ex) {
      print(ex.message);
      print(ex.response);
      printResponse(ex.response!);
      return CustomResponse(isSuccess: false, msg: ex.message, data: ex.response?.data);

    }
  }

  static MultipartFile convertPathToMultiPart(String imagePath) {
    return MultipartFile.fromFileSync(imagePath, filename: imagePath.split("/").last);
  }
 static printResponse(Response response) {
    print("Hello from printResponse");
    log.warning("---------------------Start Of Request Details ---------------------------");
    log.warning("\x1B[31m(${response.requestOptions.method}) ( ${response.requestOptions.baseUrl + response.requestOptions.path} )");
    log.info("\x1B[50m( Headers )\x1B[0m");
    if (response.requestOptions.headers.isNotEmpty) {
      response.requestOptions.headers.forEach((key, value) {
        log.info("\x1B[15m$key : $value\x1B[0m");
      });
    } else {
      log.info("\x1B[15mNo Headers\x1B[0m");
    }
    if (response.requestOptions.method == "GET") {
      log.fine("\x1B[15m( Query Parameters )\x1B");
      if (response.requestOptions.queryParameters.isNotEmpty) {
        response.requestOptions.queryParameters.forEach((key, value) {
          log.fine("\x1B[15m$key : $value\x1B[0m");
        });
      } else {
        log.fine("\x1B[15mNo Parameters\x1B[0m");
      }
    } else {
      log.fine("\x1B[15m( Data )\x1B");
      FormData data = response.requestOptions.data;
      if (data.fields.isNotEmpty) {
        data.fields.forEach((element) {
          log.fine("\x1B[15m${element.key} : ${element.value}\x1B[0m");
        });
      } else {
        log.fine("\x1B[15mNo Data\x1B[0m");
      }
    }

    log.fine("\x1B[15m--------------------- Response ---------------------------\x1B[0m");
    var resp = jsonEncode(response.data);
    resp.replaceAll("]", "\n]\n").replaceAll("[", "\n[\n").replaceAll("{", "\n{\n").replaceAll("}", "\n}\n").split(",").forEach((element) {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern.allMatches(element).forEach((match) => debugPrint(match.group(0)));
    });
    log.debug("---------------------End Of Request Details ---------------------------");
  }
}

class CustomResponse {
  late bool isSuccess;
  late String? msg;
  late dynamic data;

  CustomResponse({required this.isSuccess, required this.msg, required this.data});
}
