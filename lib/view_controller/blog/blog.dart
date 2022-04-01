import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Blog extends ConsumerStatefulWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlogState();
}

class _BlogState extends ConsumerState<Blog> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}