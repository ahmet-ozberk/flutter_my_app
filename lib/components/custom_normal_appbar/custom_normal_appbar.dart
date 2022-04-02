import 'package:flutter/material.dart';

class CustomNormalAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  @override
  final Size preferredSize;

  CustomNormalAppBar({required this.title,Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 14,
            ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 22,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
