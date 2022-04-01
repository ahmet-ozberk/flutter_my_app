import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';
import '../../components/loading_popup.dart';
import '../../components/logg.dart';
import '../../constant/message_cons.dart';
import '../../service/api_service.dart';
import '../login/model/login_model.dart';

import '../base_scaffold/base_scaffold.dart';

class RegisterRiverpod extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool obscureText = true;
  void setObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Map<String, dynamic> jsonData() {
    return {
      "email": usernameController.text,
      "name": nameController.text,
      "password": passwordController.text,
    };
  }

  bool isValid() {
    if (usernameController.text.isEmpty) {
      return false;
    } else if (passwordController.text.isEmpty) {
      return false;
    } else if (nameController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void fetch() {
    if (isValid()) {
      LoadingPopup();
      Service()
          .post(
              url: "register",
              data: jsonData(),
              token: false,
              fromJson: (json) => LoginModel.fromJson(json))
          .then((value) {
        Grock.back();
        if (value!.status!) {
          GetStorage().write("token", value.token!);
          logg(value.token!);
          Grock.toRemove(BaseScaffold(), type: NavType.fade);
        } else {
          ErrorMessage(
              title: "Hata",
              description:
                  value.message ?? "Kayıt yapılırken bir sorun oluştu.");
        }
      });
    } else {
      if (usernameController.text.isEmpty) {
        ErrorMessage(title: "Hata", description: "Email bilginizi girin.");
      } else if (passwordController.text.isEmpty) {
        ErrorMessage(title: "Hata", description: "Şifrenizi girin.");
      } else if (nameController.text.isEmpty) {
        ErrorMessage(title: "Hata", description: "İsminizi girin.");
      }
    }
  }
}
