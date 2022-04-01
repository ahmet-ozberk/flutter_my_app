import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:my_app/components/button/button.dart';
import 'package:my_app/components/custom_normal_appbar/custom_normal_appbar.dart';
import 'package:my_app/components/text_input/text_input.dart';
import 'package:my_app/constant/cons.dart';
import 'package:my_app/riverpod/riverpod_manager.dart';

class TaskAdd extends ConsumerStatefulWidget {
  const TaskAdd({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskAddState();
}

class _TaskAddState extends ConsumerState<TaskAdd> {
  @override
  void initState() {
    ref.read(taskAddRiverpod).titleController.clear();
    ref.read(taskAddRiverpod).descriptionController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var read = ref.read(taskAddRiverpod);
    return GrockKeyboardClose(
      child: Scaffold(
        appBar: CustomNormalAppBar(),
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
                ),
                Cons.mediumSpace,
                TextInput(
                  controller: read.descriptionController,
                  placeHolder: "Task Açıklaması",
                  maxLines: 5,
                ),
                const Spacer(),
                SafeArea(
                    child: Button(
                        text: "Oluştur", onPressed: () => read.addTask())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text note(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Ekleyeceğiniz task'ın varsayılan olarak durumu ",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.5),
                ),
          ),
          TextSpan(
              text: "'tamamlanmadı' ",
              style: Theme.of(context).textTheme.bodyLarge),
          TextSpan(
            text: 'olarak oluşturulacaktır.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.5),
                ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
