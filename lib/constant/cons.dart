import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Cons {
  /// widgets
  static const smallSpace = SizedBox(height: 10);
  static const mediumSpace = SizedBox(height: 20);
  static const largeSpace = SizedBox(height: 30);

  /// url
  static const String baseUrl = "https://nottapp.herokuapp.com/";

  /// get token
  static Options getToken() {
    final token = GetStorage().read("token");
    return Options(headers: {"Authorization": "Bearer $token"});
  }
}
