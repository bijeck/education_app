import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_datasources.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_imp.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDatasource extends Mock
    implements OnBoardingLocalDatasource {}

void main() {
  late OnBoardingLocalDatasource datasource;
  late OnBoardingRepo repo;

  setUp(() {
    datasource = MockOnBoardingLocalDatasource();
    repo = OnBoardingRepoImpl(datasource);
  });

  test('should be subclass of OnBoardingRepo', () {
    expect(repo, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    test(
      'should complete successfully when call to local source is successful',
      () async {
        when(() => datasource.cacheFirstTimer()).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repo.cacheFirstTimer();

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => datasource.cacheFirstTimer());
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'should return [CacheFailure] when call to local source is '
      'unsuccessful',
      () async {
        when(() => datasource.cacheFirstTimer()).thenThrow(
          const CacheException(message: 'Insufficient storage'),
        );

        final result = await repo.cacheFirstTimer();

        expect(
          result,
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        );
        verify(() => datasource.cacheFirstTimer());
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should return true when user is first timer',
      () async {
        when(() => datasource.checkIfUserIsFirstTimer())
            .thenAnswer((_) async => Future.value(true));

        final result = await repo.checkIfUserIsFirstTimer();

        expect(result, equals(const Right<dynamic, bool>(true)));

        verify(() => datasource.checkIfUserIsFirstTimer()).called(1);

        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'should return false when user is not first timer',
      () async {
        when(() => datasource.checkIfUserIsFirstTimer())
            .thenAnswer((_) async => Future.value(false));

        final result = await repo.checkIfUserIsFirstTimer();

        expect(result, equals(const Right<dynamic, bool>(false)));

        verify(() => datasource.checkIfUserIsFirstTimer()).called(1);

        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'should return a CacheFailure when call to local data source '
      'is unsuccessful',
      () async {
        when(() => datasource.checkIfUserIsFirstTimer()).thenThrow(
          const CacheException(
            message: 'Insufficient permissions',
            statusCode: 403,
          ),
        );

        final result = await repo.checkIfUserIsFirstTimer();

        expect(
          result,
          equals(
            Left<CacheFailure, bool>(
              CacheFailure(
                message: 'Insufficient permissions',
                statusCode: 403,
              ),
            ),
          ),
        );

        verify(() => datasource.checkIfUserIsFirstTimer()).called(1);

        verifyNoMoreInteractions(datasource);
      },
    );
  });
}
