import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

import 'package:my_app/components/button/button.dart';
import 'package:my_app/components/custom_normal_appbar/custom_normal_appbar.dart';
import 'package:my_app/components/text_input/text_input.dart';
import 'package:my_app/constant/cons.dart';
import 'package:my_app/riverpod/riverpod_manager.dart';

class TaskAdd extends ConsumerStatefulWidget {
  final int? id;
  final String? title;
  final String? description;
  final bool isEdit;
  TaskAdd({
    this.id,
    this.title,
    this.description,
    this.isEdit = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskAddState();
}

class _TaskAddState extends ConsumerState<TaskAdd> {
  @override
  void initState() {
    ref.read(taskAddRiverpod).titleController.clear();
    ref.read(taskAddRiverpod).descriptionController.clear();
    if (widget.title != null && widget.description != null) {
      ref.read(taskAddRiverpod).titleController.text = widget.title!;
      ref.read(taskAddRiverpod).descriptionController.text =
          widget.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var read = ref.read(taskAddRiverpod);
    return GrockKeyboardClose(
      child: Scaffold(
        appBar: CustomNormalAppBar(
          title: widget.isEdit ? "Güncelle" : "Oluştur",
        ),
        body: GrockScrollEffect(
          child: Padding(
            padding: 15.allP,
            child: Column(
              children: [
                note(context),
                Cons.largeSpace,
                TextInput(
                  controller: read.titleController,
                  placeHolder: "Task Başlığı",
                  maxLines: 1,
                ),
                Cons.mediumSpace,
                TextInput(
                  controller: read.descriptionController,
                  placeHolder: "Task Açıklaması",
                  maxLines: 5,
                ),
                const Spacer(),
                Button(
                  text: "Sil",
                  onPressed: () => read.deleteTask(id: widget.id!),
                  bgColor: CupertinoColors.systemRed,
                ),
                Cons.smallSpace,
                Visibility(
                  visible: !widget.isEdit,
                  child: SafeArea(
                      child: Button(
                          text: "Oluştur", onPressed: () => read.addTask())),
                ),
                Visibility(
                  visible: widget.isEdit,
                  child: SafeArea(
                      child: Button(
                          text: "Güncelle",
                          onPressed: () => read.updateTask(id: widget.id!))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text note(BuildContext context) {
    return Text(
      widget.isEdit ? "Hemen Task'ını Güncelle" : "Hemen Yeni Bir Task Oluştur",
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }
}
