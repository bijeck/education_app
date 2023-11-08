import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_datasources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box<dynamic> {}

void main() {
  late HiveInterface mockHive;
  late Box<dynamic> mockBox;
  late OnBoardingLocalDatasource localDataSource;

  setUp(() async {
    mockHive = MockHiveInterface();
    mockBox = MockHiveBox();
    localDataSource = OnBoardingLocalDatasourceImpl(mockHive);
  });

  group('cacheFirstTimer', () {
    test(
      'should call [Hive] to cache the data',
      () async {
        when(
          () => mockHive.openBox<dynamic>(any()),
        ).thenAnswer(
          (_) async => mockBox,
        );
        when(
          () => mockBox.put(any<String>(), any<bool>()),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        await localDataSource.cacheFirstTimer();
        verify(() => mockHive.openBox<dynamic>(cachedBox)).called(1);
        verify(() => mockBox.put(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(mockBox);
        verifyNoMoreInteractions(mockHive);
      },
    );

    test(
      'should throw a [CacheException] when open box for caching the data',
      () async {
        when(
          () => mockHive.openBox<dynamic>(any()),
        ).thenThrow(
          Exception(),
        );

        final methodCall = localDataSource.cacheFirstTimer;

        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => mockHive.openBox<dynamic>(cachedBox)).called(1);
        verifyNoMoreInteractions(mockHive);
      },
    );
    test(
      'should throw a [CacheException] when there is an error caching the data',
      () async {
        when(
          () => mockHive.openBox<dynamic>(any()),
        ).thenAnswer(
          (_) async => mockBox,
        );
        when(
          () => mockBox.put(any<String>(), any<bool>()),
        ).thenThrow(
          Exception(),
        );

        final methodCall = localDataSource.cacheFirstTimer;

        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => mockHive.openBox<dynamic>(cachedBox)).called(1);
        verifyNoMoreInteractions(mockBox);
        verifyNoMoreInteractions(mockHive);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should call [Hive] to check if user is first timer and '
      'return the right response from storage when data exists',
      () async {
        when(
          () => mockHive.openBox<dynamic>(any()),
        ).thenAnswer(
          (_) async => mockBox,
        );
        when(
          () => mockBox.get(any<String>(), defaultValue: true),
        ).thenAnswer(
          (_) async => Future.value(false),
        );

        final result = await localDataSource.checkIfUserIsFirstTimer();

        expect(result, false);

        verify(() => mockHive.openBox<dynamic>(cachedBox)).called(1);
        verify(() => mockBox.get(kFirstTimerKey, defaultValue: true)).called(1);
        verifyNoMoreInteractions(mockBox);
        verifyNoMoreInteractions(mockHive);
      },
    );

    test(
      'should return true if there is no data in storage',
      () async {
        when(
          () => mockHive.openBox<dynamic>(any()),
        ).thenAnswer(
          (_) async => mockBox,
        );
        when(
          () => mockBox.get(any<String>(), defaultValue: true),
        ).thenAnswer(
          (_) async => Future.value(true),
        );

        final result = await localDataSource.checkIfUserIsFirstTimer();

        expect(result, true);

        verify(() => mockHive.openBox<dynamic>(cachedBox)).called(1);
        verify(() => mockBox.get(kFirstTimerKey, defaultValue: true)).called(1);
        verifyNoMoreInteractions(mockBox);
        verifyNoMoreInteractions(mockHive);
      },
    );

    test(
      'should throw a [CacheException] when there is an error '
      'retrieving the data',
      () async {
        when(
          () => mockHive.openBox<dynamic>(any()),
        ).thenThrow(
          Exception(),
        );

        final methodCall = localDataSource.checkIfUserIsFirstTimer;

        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => mockHive.openBox<dynamic>(cachedBox)).called(1);
        verifyNoMoreInteractions(mockHive);
      },
    );

    test(
      'should throw a [CacheException] when there is an error get the data',
      () async {
        when(
          () => mockHive.openBox<dynamic>(any()),
        ).thenAnswer(
          (_) async => mockBox,
        );
        when(
          () => mockBox.get(any<String>(), defaultValue: true),
        ).thenThrow(
          Exception(),
        );

        final methodCall = localDataSource.checkIfUserIsFirstTimer;

        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => mockHive.openBox<dynamic>(cachedBox)).called(1);
        verifyNoMoreInteractions(mockBox);
        verifyNoMoreInteractions(mockHive);
      },
    );
  });
}
