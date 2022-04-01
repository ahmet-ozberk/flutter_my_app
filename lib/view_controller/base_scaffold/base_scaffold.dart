import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import '../../components/custom_appbar/custom_appbar.dart';
import '../../riverpod/riverpod_manager.dart';

class BaseScaffold extends ConsumerStatefulWidget {
  const BaseScaffold({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends ConsumerState<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    var read = ref.read(baseScaffoldRiverpod);
    var watch = ref.watch(baseScaffoldRiverpod);
    return GrockKeyboardClose(
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: watch.bottomBarTitleColor(),
          items: read.items,
          currentIndex: watch.currentIndex,
          onTap: (index) => watch.setCurrentIndex(index),
        ),
        body: watch.body(),
      ),
    );
  }
}
