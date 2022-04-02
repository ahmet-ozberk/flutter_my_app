import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/assets.dart';
import 'package:my_app/components/api_call.dart';
import 'package:my_app/components/task_card.dart';
import 'package:my_app/components/text_input/text_input.dart';
import 'package:my_app/riverpod/riverpod_manager.dart';
import 'package:my_app/view_controller/task/task_riverpod.dart';
import 'package:my_app/view_controller/task_add/task_add.dart';

class Task extends ConsumerStatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskState();
}

class _TaskState extends ConsumerState<Task> {
  @override
  void initState() {
    ref.read(taskRiverpod).isLoading = null;
    ref.read(taskRiverpod).getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(taskRiverpod);
    var read = ref.read(taskRiverpod);
    return ApiCall.init(
      isLoading: watch.isLoading,
      child: Scaffold(
        floatingActionButton: Tooltip(
          message: "Task Ekle",
          child: GrockContainer(
            onTap: () => Grock.to(TaskAdd()),
            child: Lottie.asset(Assets.lottie.taskAddJSON,
                width: Grock.width * 0.2),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: [15, 15, 15, 0].paddingLTRB,
                  child: Text(
                    "Merhaba, ${GetStorage().read("email") ?? "isimsiz"} 👋🏼",
                    style: Theme.of(context).textTheme.headline4,
                  )),
              currentTaskButton(watch),
              isSearch(),
              watch.taskValue
                  ? isCompleteTasks(read)
                  : isNotComplatedTasks(read),
            ],
          ),
        ),
      ),
    );
  }

  Widget isSearch() {
    if (ref.watch(taskRiverpod).taskValue) {
      return searchBar(
        onTap: (value) => ref.read(taskRiverpod).searchIsComplete(),
        onClear: () => ref.read(taskRiverpod).searchIsCompleteClear(),
      );
    } else {
      return searchBar(
        onTap: (value) => ref.read(taskRiverpod).searchIsNotComplete(),
        onClear: () => ref.read(taskRiverpod).searchIsNotCompleteClear(),
      );
    }
  }

  Widget searchBar({
    required Function(String value) onTap,
    required Function onClear,
  }) {
    return Padding(
      padding: [15, 15, 15, 10].paddingLTRB,
      child: TextInput(
        maxLines: 1,
        focusNode: ref.watch(taskRiverpod).focusNode,
        placeHolder: "Ara",
        controller: ref.read(taskRiverpod).searchController,
        suffixIcon: IconButton(
          icon: const Icon(
            CupertinoIcons.delete_left,
            size: 22,
          ),
          onPressed: () => onClear(),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => onTap(value),
      ),
    );
  }

  Padding currentTaskButton(TaskRiverpod watch) {
    return Padding(
      padding: [15, 15, 15, 0].paddingLTRB,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: taskButton(
                isSelected: watch.taskValue,
                title: "tamamlandı",
                icon: CupertinoIcons.check_mark),
          ),
          const Spacer(),
          Expanded(
            flex: 8,
            child: taskButton(
                isSelected: !watch.taskValue,
                title: "tamamlanmadı",
                icon: CupertinoIcons.clear_thick),
          ),
        ],
      ),
    );
  }

  GridView isNotComplatedTasks(TaskRiverpod read) {
    return GridView.custom(
      shrinkWrap: true,
      padding: [15, 10, 15, 15].paddingLTRB,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: const [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = read.isNotCompleteSearch
              ? read.taskNotComplatedSearchList[index]!
              : read.taskNotComplatedList[index]!;
          return TaskCard(
            id: item.id!,
            title: item.title!,
            description: item.description!,
            isComplete: item.isComplete!,
            createdAt: item.createdAt!,
            onChanged: () => read.isComplete(item),
          );
        },
        childCount: read.isNotCompleteSearch
            ? read.taskNotComplatedSearchList.length
            : read.taskNotComplatedList.length,
      ),
    );
  }

  GridView isCompleteTasks(TaskRiverpod read) {
    return GridView.custom(
      shrinkWrap: true,
      padding: [15, 10, 15, 15].paddingLTRB,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: const [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = read.isCompleteSearch
              ? read.taskComplatedSearchList[index]!
              : read.taskComplatedList[index]!;
          return TaskCard(
            id: item.id!,
            title: item.title!,
            description: item.description!,
            isComplete: item.isComplete!,
            createdAt: item.createdAt!,
            onChanged: () => read.isNotComplete(item),
          );
        },
        childCount: read.isCompleteSearch
            ? read.taskComplatedSearchList.length
            : read.taskComplatedList.length,
      ),
    );
  }

  Widget taskButton({
    required bool isSelected,
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => ref.watch(taskRiverpod).setTaskValue(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
            borderRadius: 10.allBR,
            color: isSelected
                ? CupertinoColors.activeBlue
                : Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ]),
        padding: 10.allP,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isSelected ? Colors.white : Colors.black54,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
