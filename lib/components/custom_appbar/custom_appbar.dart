import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';
import 'package:my_app/riverpod/riverpod_manager.dart';
import 'package:my_app/view_controller/splash.dart';

class CustomAppBar extends ConsumerWidget with PreferredSizeWidget {
  final Size preferredSize;

  CustomAppBar() : preferredSize = Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watch = ref.watch(baseScaffoldRiverpod);
    var read = ref.read(baseScaffoldRiverpod);
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: [20, 10].horizontalAndVerticalP,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
                boxShadow: [
                  BoxShadow(
                    color: watch.appBarTitleColor(),
                    offset: Offset(10, watch.appBarTitleShadow()),
                    blurRadius: 10,
                  ),
                ]),
            child: Text(
              watch.appBarTitle(),
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              GetStorage().remove("token");
              Grock.toRemove(Splash());
            },
            icon: Icon(CupertinoIcons.arrow_right_square_fill),
            iconSize: 34,
          ),
        ],
      ),
    );
  }
}
