import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import 'view_controller/splash.dart';

import 'assets.dart';
import 'components/button/button.dart';

void main() async {
  await GetStorage.init();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        padding: [20, 20].horizontalAndVerticalP,
        color: CupertinoColors.destructiveRed,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(Assets.lottie.errorJSON),
              SizedBox(height: Grock.height * 0.1),
              Text(
                details.toString().substring(0, 100),
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Grock.height * 0.05),
              Button(
                text: "Geri Dön",
                onPressed: () => Grock.back(),
                bgColor: CupertinoColors.darkBackgroundGray,
              ),
            ],
          ),
        ),
      ),
    );
  };
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.snackbarMessengerKey,
      title: 'Benim Uygulamam',
      theme: ThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: const Splash(),
    );
  }
}
