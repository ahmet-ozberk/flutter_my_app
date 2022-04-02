import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/components/waiting_view.dart';

class Flutter extends ConsumerStatefulWidget {
  const Flutter({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlogState();
}

class _BlogState extends ConsumerState<Flutter> {
  @override
  Widget build(BuildContext context) {
    return WaitingView();
  }
}
