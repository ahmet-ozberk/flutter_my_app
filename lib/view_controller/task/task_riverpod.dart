import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:my_app/components/loading_popup.dart';
import 'package:my_app/constant/message_cons.dart';
import 'package:my_app/model/is_complete_model.dart';
import 'package:my_app/model/task_model.dart';
import 'package:my_app/service/api_service.dart';

class TaskRiverpod extends ChangeNotifier {
  FocusNode focusNode = FocusNode();
  bool? isLoading;
  List<TaskModelDataComplated?> taskComplatedList = [];
  List<TaskModelDataNotComplated?> taskNotComplatedList = [];
  List<TaskModelDataComplated?> taskComplatedSearchList = [];
  List<TaskModelDataNotComplated?> taskNotComplatedSearchList = [];
  TextEditingController searchController = TextEditingController();
  bool taskValue = true;
  bool isCompleteSearch = false;
  bool isNotCompleteSearch = false;

  void searchIsComplete() {
    isCompleteSearch = true;
    notifyListeners();
    taskComplatedList.forEach((element) {
      if (taskComplatedSearchList
              .where((elementIn) => elementIn!.id! == element!.id)
              .length ==
          0) {
        if (element!.title!
            .trim()
            .toLowerCase()
            .contains(searchController.text.trim().toLowerCase())) {
          taskComplatedSearchList.add(element);
          notifyListeners();
        }
      }
    });
  }

  void searchIsCompleteClear() {
    searchController.clear();
    isCompleteSearch = false;
    notifyListeners();
  }

  void searchIsNotCompleteClear() {
    searchController.clear();
    isNotCompleteSearch = false;
    notifyListeners();
  }

  void searchIsNotComplete() {
    isNotCompleteSearch = true;
    notifyListeners();
    taskNotComplatedList.forEach((element) {
      if (taskNotComplatedSearchList
              .where((elementIn) => elementIn!.id! == element!.id)
              .length ==
          0) {
        if (element!.title!
            .trim()
            .toLowerCase()
            .contains(searchController.text.trim().toLowerCase())) {
          taskNotComplatedSearchList.add(element);
          notifyListeners();
        }
      }
    });
  }

  void setTaskValue() {
    taskValue = !taskValue;
    searchController.clear();
    notifyListeners();
    isNotCompleteSearch = false;
    isCompleteSearch = false;
    focusNode.unfocus();
    notifyListeners();
  }

  void isComplete(TaskModelDataNotComplated model) {
    changeompleteStatus(id: model.id!);
    model.isComplete = true;
    taskNotComplatedList.remove(model);
    taskComplatedList.add(TaskModelDataComplated(
        id: model.id,
        title: model.title,
        description: model.description,
        isComplete: model.isComplete,
        createdAt: model.createdAt));
    notifyListeners();
  }

  void isNotComplete(TaskModelDataComplated model) {
    changeompleteStatus(id: model.id!);
    model.isComplete = false;
    taskComplatedList.remove(model);
    taskNotComplatedList.add(TaskModelDataNotComplated(
        id: model.id,
        title: model.title,
        description: model.description,
        isComplete: model.isComplete,
        createdAt: model.createdAt));
    notifyListeners();
  }

  void changeompleteStatus({required int id}) {
    LoadingPopup();
    Service<IsCompleteModel>()
        .post(
            url: "iscompleted",
            data: {"id": id},
            fromJson: (json) => IsCompleteModel.fromJson(json),
            throwMessage: "Durum değiştirme işlemi başarısız oldu.")
        .then((value) {
      Grock.back();
      if (value!.status!) {
        SuccessMessage(
            title: "Başarılı",
            description: value.message ?? "Durum değiştirildi.");
      }
    });
  }

  void getData() {
    Service<TaskModel>()
        .get(url: "list", fromJson: (json) => TaskModel.fromJson(json))
        .then((value) {
      if (value!.status!) {
        taskComplatedList = value.data!.complated!;
        taskNotComplatedList = value.data!.notComplated!;
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        ErrorMessage(
            title: "Hata", description: value.message ?? "Bir sorun oluştu.");
      }
    });
  }
}
