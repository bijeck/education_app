import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late CacheFirstTime usecase;
  late OnBoardingRepo repo;
  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTime(repo);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer] '
    'and return the right data',
    () async {
      when(
        () => repo.cacheFirstTimer(),
      ).thenAnswer(
        (_) async => Left(
          CacheFailure(
            message: 'Unknown Error Occurred',
            statusCode: 500,
          ),
        ),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            CacheFailure(
              message: 'Unknown Error Occurred',
              statusCode: 500,
            ),
          ),
        ),
      );

      verify(() => repo.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
