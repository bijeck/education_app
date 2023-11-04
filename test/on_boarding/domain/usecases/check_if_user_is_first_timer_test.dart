import 'package:dartz/dartz.dart';
import 'package:education_app/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late CheckIfUserIsFirstTimer usecase;
  late OnBoardingRepo repo;
  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test(
    'should get a response from the [MockOnBoardingRepo]',
    () async {
      when(
        () => repo.checkIfUserIsFirstTimer(),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          const Right<dynamic, bool>(true),
        ),
      );

      verify(() => repo.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
