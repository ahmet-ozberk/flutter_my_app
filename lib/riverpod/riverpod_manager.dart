import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/view_controller/base_scaffold/base_scaffold_riverpod.dart';
import 'package:my_app/view_controller/login/login_riverpod.dart';
import 'package:my_app/view_controller/register/register_riverpod.dart';


final loginRiverpod = ChangeNotifierProvider((_) => LoginRiverpod());
final registerRiverpod = ChangeNotifierProvider((_) => RegisterRiverpod());
final baseScaffoldRiverpod = ChangeNotifierProvider((_) => BaseScaffoldRiverpod());