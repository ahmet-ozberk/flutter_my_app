import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/assets.dart';
import 'package:my_app/components/text_input/button/button.dart';
import 'package:my_app/components/text_input/text_input.dart';
import 'package:my_app/constant/cons.dart';
import 'package:my_app/riverpod/riverpod_manager.dart';
import 'package:my_app/view_controller/login/login.dart';

class Register extends ConsumerWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(registerRiverpod);
    var watch = ref.watch(registerRiverpod);
    return GrockScrollEffect(
      child: GrockKeyboardClose(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: [20, (Grock.height * 0.1).toInt()].horizontalAndVerticalP,
            child: Column(
              children: [
                Center(
                  child: Lottie.asset(Assets.lottie.registerJSON,
                      width: Grock.width * 0.6),
                ),
                Cons.largeSpace,
                Cons.largeSpace,
                TextInput(
                  controller: read.usernameController,
                  suffixIcon: const Icon(CupertinoIcons.person),
                  placeHolder: "Kullanıcı Adı veya E-Posta",
                ),
                Cons.smallSpace,
                TextInput(
                  controller: read.nameController,
                  suffixIcon: const Icon(CupertinoIcons.person_alt_circle),
                  placeHolder: "İsim ve Soyisim",
                ),
                Cons.smallSpace,
                TextInput(
                  controller: read.passwordController,
                  suffixIcon: GrockContainer(
                    onTap: () => read.setObscureText(),
                    child: Icon(
                      watch.obscureText
                          ? CupertinoIcons.padlock
                          : CupertinoIcons.lock_open,
                    ),
                  ),
                  obsText: watch.obscureText,
                  placeHolder: "Şifre",
                ),
                Cons.mediumSpace,
                CupertinoButton(
                  child: const Text(
                    "Zaten hesabın var mı? Giriş Yap",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => Grock.toRemove(Login(), type: NavType.fade),
                ),
                 Cons.largeSpace,
                  Cons.mediumSpace,
                Button(text: "Kayıt Ol", onPressed: () => read.fetch()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
