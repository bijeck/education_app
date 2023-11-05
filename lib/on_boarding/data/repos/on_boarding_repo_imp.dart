import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/on_boarding/data/datasources/on_boarding_local_datasources.dart';
import 'package:education_app/on_boarding/domain/repos/on_boarding_repo.dart';

class OnBoardingRepoImpl extends OnBoardingRepo {
  OnBoardingRepoImpl(this._datasource);

  final OnBoardingLocalDatasource _datasource;
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _datasource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _datasource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
