import 'package:education_app/core/errors/exceptions.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class OnBoardingLocalDatasource {
  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'first_timer';
const String cachedBox = 'CachedBox';

@LazySingleton(as: OnBoardingLocalDatasource)
class OnBoardingLocalDatasourceImpl extends OnBoardingLocalDatasource {
  OnBoardingLocalDatasourceImpl(this.hive);
  final HiveInterface hive;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      final box = await _openBox(cachedBox);
      await box.put(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      final box = await _openBox(cachedBox);
      return await box.get(kFirstTimerKey, defaultValue: true) as bool;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  Future<Box<dynamic>> _openBox(String type) async {
    try {
      final box = await hive.openBox<dynamic>(type);
      return box;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
