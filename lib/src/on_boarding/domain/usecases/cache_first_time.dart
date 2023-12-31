import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(scope: 'on_boarding')
class CacheFirstTime extends UsecaseWithoutParams<void> {
  const CacheFirstTime(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() => _repo.cacheFirstTimer();
}
