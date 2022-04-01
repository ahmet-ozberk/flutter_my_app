import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/assets.dart';

class ApiCall {
  static Widget init({required bool? isLoading, required Widget child}) {
    if (isLoading == null) {
      return Center(
          child: Container(
        color: Theme.of(Grock.snackbarMessengerKey.currentContext!)
            .scaffoldBackgroundColor,
        child: Center(
          child: Lottie.asset(Assets.lottie.loadingJSON),
        ),
      ));
    } else if (isLoading) {
      return child;
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
                size: Grock.height * 0.1,
              ),
              Text("Bir sorun oluştu, daha sonra tekrar deneyin."),
            ],
          ),
        ),
      );
    }
  }
}
