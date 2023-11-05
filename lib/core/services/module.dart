import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  HiveInterface get hiveInterface => Hive;
}

class $RegisterModule extends RegisterModule {}
