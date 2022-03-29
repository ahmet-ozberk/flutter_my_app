import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import '../assets.dart';

void LoadingPopup() {
  Grock.dialog(
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: Lottie.asset(Assets.lottie.loadingJSON),
      );
    },
  );
}
