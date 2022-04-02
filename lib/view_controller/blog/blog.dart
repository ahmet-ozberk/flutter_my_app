import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/assets.dart';

import '../../components/waiting_view.dart';

class Blog extends ConsumerStatefulWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlogState();
}

class _BlogState extends ConsumerState<Blog> {
  @override
  Widget build(BuildContext context) {
    return WaitingView();
  }
}


