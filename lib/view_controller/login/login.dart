import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import '../../assets.dart';
import '../../components/text_input/text_input.dart';
import '../../constant/cons.dart';
import '../../riverpod/riverpod_manager.dart';
import '../register/register.dart';

import '../../components/button/button.dart';

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(loginRiverpod);
    var watch = ref.watch(loginRiverpod);
    return GrockScrollEffect(
      child: GrockKeyboardClose(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: [20, (Grock.height * 0.1).toInt()].horizontalAndVerticalP,
            child: Column(
              children: [
                Center(
                  child: Lottie.asset(Assets.lottie.loginJSON,
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
                    "Hesabın yok mu? Kayıt Ol",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => Grock.toRemove(Register(), type: NavType.fade),
                ),
                Cons.largeSpace,
                Cons.mediumSpace,
                Button(text: "Giriş Yap", onPressed: () => read.fetch()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
