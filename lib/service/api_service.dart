import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';
import '../components/logg.dart';
import '../constant/cons.dart';

class Service<T> {
  final dio = Dio();

  Future<T?> get(
      {required String url,
      bool? token,
      Function(Map<String, dynamic> type)? fromJson,
      String? throwMessage}) async {
    Response? response;
    try {
      response = await dio.get(Cons.baseUrl + url,
          options: token == false ? null : options());

      if (response.statusCode == HttpStatus.ok) {
        if (fromJson != null) {
          return fromJson(response.data);
        }
        return response.data;
      } else {
        throw (throwMessage ?? 'Veri Yüklenirken bir hata oluştu.');
      }
    } catch (error) {
      Grock.back();
      logg("Get İşleminde Hata: " + error.toString());
      throw (error.toString());
    }
  }

  Future<T?> post(
      {required String url,
      bool? token,
      Map<String, dynamic>? data,
      Function(Map<String, dynamic> type)? fromJson,
      String? throwMessage}) async {
    var response;
    try {
      response = await dio.post(Cons.baseUrl + url,
          data: data, options: token == false ? null : options());

      if (response.statusCode == HttpStatus.ok) {
        if (fromJson != null) {
          return fromJson(response.data);
        }
        return response.data;
      } else {
        throw (throwMessage ?? 'Veri Yüklenirken bir hata oluştu.');
      }
    } catch (error) {
      Grock.back();
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
