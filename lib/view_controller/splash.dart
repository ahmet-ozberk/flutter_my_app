import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import '../assets.dart';

import 'base_scaffold/base_scaffold.dart';
import 'login/login.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  String? token;
  final box = GetStorage();
  @override
  void initState() {
    token = box.read('token');
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (token == null) {
        Grock.toRemove(Login(), type: NavType.bottomToTop);
      } else {
        Grock.toRemove(BaseScaffold(), type: NavType.bottomToTop);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(Assets.lottie.splashJSON),
      ),
    );
  }
}
