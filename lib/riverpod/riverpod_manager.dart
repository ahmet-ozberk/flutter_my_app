import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_controller/base_scaffold/base_scaffold_riverpod.dart';
import '../view_controller/login/login_riverpod.dart';
import '../view_controller/register/register_riverpod.dart';
import '../view_controller/task/task_riverpod.dart';
import '../view_controller/task_add/task_add_riverpod.dart';


final loginRiverpod = ChangeNotifierProvider((_) => LoginRiverpod());
final registerRiverpod = ChangeNotifierProvider((_) => RegisterRiverpod());
final baseScaffoldRiverpod = ChangeNotifierProvider((_) => BaseScaffoldRiverpod());
final taskRiverpod = ChangeNotifierProvider((_) => TaskRiverpod());
final taskAddRiverpod = ChangeNotifierProvider((_) => TaskAddRiverpod());