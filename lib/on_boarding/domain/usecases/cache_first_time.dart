import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/on_boarding/domain/repos/on_boarding_repo.dart';

class CachFirstTime extends UsecaseWithoutParams<void> {
  const CachFirstTime(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() => _repo.cacheFirstTimer();
}
