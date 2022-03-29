import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/components/text_input/logg.dart';
import 'package:my_app/constant/cons.dart';

class Service<T> {
  final dio = Dio();

  Future<T?> post(
      {required String url,
      bool? token,
      Map<String, dynamic>? data,
      Function(Map<String, dynamic> type)? fromJson,
      String? throwMessage}) async {
    var response;
    try {
      if (token != null) {
        response = await dio.post(Cons.baseUrl + url,
            data: data, options: token == false ? null : options());
      } else {
        response = await dio.post(url, data: data);
      }
      if (response.statusCode == HttpStatus.ok) {
        if (fromJson != null) {
          return fromJson(response.data);
        }
        return response.data;
      } else {
        throw (throwMessage ?? 'Veri Yüklenirken bir hata oluştu.');
      }
    } catch (error) {
      logg("Post İşleminde Hata: " + error.toString());
      throw (error.toString());
    }
  }

  Options options() {
    return Options(
      headers: {
        "Authorization": "Bearer ${GetStorage().read("token")}",
      },
    );
  }
}
