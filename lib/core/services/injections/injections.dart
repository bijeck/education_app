import 'package:education_app/core/services/injections/injections.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt
    ..init()
    ..initAuthScope();
  await getIt.initOn_boardingScope();
}
