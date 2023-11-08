// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:education_app/core/services/module.dart' as _i10;
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_datasources.dart'
    as _i4;
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_imp.dart'
    as _i6;
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart'
    as _i5;
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_time.dart'
    as _i7;
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart'
    as _i8;
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.HiveInterface>(() => registerModule.hiveInterface);
    gh.lazySingleton<_i4.OnBoardingLocalDatasource>(
        () => _i4.OnBoardingLocalDatasourceImpl(gh<_i3.HiveInterface>()));
    gh.lazySingleton<_i5.OnBoardingRepo>(
        () => _i6.OnBoardingRepoImpl(gh<_i4.OnBoardingLocalDatasource>()));
    gh.lazySingleton<_i7.CacheFirstTime>(
        () => _i7.CacheFirstTime(gh<_i5.OnBoardingRepo>()));
    gh.lazySingleton<_i8.CheckIfUserIsFirstTimer>(
        () => _i8.CheckIfUserIsFirstTimer(gh<_i5.OnBoardingRepo>()));
    gh.factory<_i9.OnBoardingCubit>(() => _i9.OnBoardingCubit(
          cacheFirstTimer: gh<_i7.CacheFirstTime>(),
          checkIfUserIsFirstTimer: gh<_i8.CheckIfUserIsFirstTimer>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
