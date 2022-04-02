import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:my_app/components/loading_popup.dart';
import 'package:my_app/constant/message_cons.dart';
import 'package:my_app/model/is_complete_model.dart';
import 'package:my_app/service/api_service.dart';
import 'package:my_app/view_controller/base_scaffold/base_scaffold.dart';

class TaskAddRiverpod extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isValid() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        titleController.text.length < 3 ||
        descriptionController.text.length < 3) {
      return false;
    }
    return true;
  }

  void deleteTask({required int id}) {
    LoadingPopup();
    Service<IsCompleteModel>()
        .post(
            url: "delete",
            fromJson: (json) => IsCompleteModel.fromJson(json),
            data: {"id": id},
            throwMessage: "Silme işleminde bir sorun oluştu.")
        .then((value) {
      Grock.back();
      if (value!.status!) {
        SuccessMessage(
            title: "Başarılı",
            description: value.message ?? "Silme işlemi başarılı.");
        Future.delayed(const Duration(milliseconds: 2600), () {
          Grock.toRemove(BaseScaffold());
        });
      } else {
        ErrorMessage(
            title: "Başarısız",
            description:
                "Silme işleminde bir sorun çıktı, lütfen tekrar deneyin.");
      }
    });
  }

  void updateTask({required int id}) {
    if (isValid()) {
      LoadingPopup();
      Service<IsCompleteModel>()
          .post(
              url: "update",
              data: {
                "id": id,
                "title": titleController.text,
                "description": descriptionController.text,
              },
              fromJson: (json) => IsCompleteModel.fromJson(json),
              throwMessage: "Oluşturulurken bir sorun oluştu.")
          .then((value) {
        Grock.back();
        if (value!.status!) {
          SuccessMessage(title: "Başarılı", description: "Task güncellendi.");
          Future.delayed(const Duration(milliseconds: 2600), () {
            Grock.toRemove(BaseScaffold());
          });
        } else {
          ErrorMessage(
              title: "Hata",
              description: value.message ??
                  "Güncellenirken bir sorun oluştu, tekrar deneyin.");
        }
      });
    } else {
      ErrorMessage(
          title: "Hata",
          description:
              "Lütfen bilgileri en az 3 karakter olacak şekilde eksiksiz doldurun. ");
    }
  }

  void addTask() {
    if (isValid()) {
      LoadingPopup();
      Service<IsCompleteModel>()
          .post(
              url: "add",
              data: {
                "title": titleController.text,
                "description": descriptionController.text,
              },
              fromJson: (json) => IsCompleteModel.fromJson(json),
              throwMessage: "Oluşturulurken bir sorun oluştu.")
          .then((value) {
        Grock.back();
        if (value!.status!) {
          SuccessMessage(title: "Başarılı", description: "Task oluşturuldu.");
          Future.delayed(const Duration(milliseconds: 2600), () {
            Grock.toRemove(BaseScaffold());
          });
        } else {
          ErrorMessage(
              title: "Hata",
              description: value.message ??
                  "Oluşturulurken bir sorun oluştu, tekrar deneyin.");
        }
      });
    } else {
      ErrorMessage(
          title: "Hata",
          description:
              "Lütfen bilgileri en az 3 karakter olacak şekilde eksiksiz doldurun. ");
    }
  }
}
