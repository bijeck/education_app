// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:education_app/core/services/module.dart' as _i21;
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart'
    as _i13;
import 'package:education_app/src/auth/data/repos/auth_repo_impl.dart' as _i15;
import 'package:education_app/src/auth/domain/repos/auth_repo.dart' as _i14;
import 'package:education_app/src/auth/domain/usecases/forgot_password.dart'
    as _i16;
import 'package:education_app/src/auth/domain/usecases/sign_in.dart' as _i17;
import 'package:education_app/src/auth/domain/usecases/sign_up.dart' as _i18;
import 'package:education_app/src/auth/domain/usecases/update_user.dart'
    as _i19;
import 'package:education_app/src/auth/presentation/bloc/auth_bloc.dart'
    as _i20;
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_datasources.dart'
    as _i7;
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_imp.dart'
    as _i9;
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart'
    as _i8;
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_time.dart'
    as _i10;
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart'
    as _i11;
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart'
    as _i12;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
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
    gh.lazySingleton<_i3.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i4.FirebaseFirestore>(
        () => registerModule.firebaseFirestore);
    gh.lazySingleton<_i5.FirebaseStorage>(() => registerModule.firebaseStorage);
    gh.lazySingleton<_i6.HiveInterface>(() => registerModule.hiveInterface);
    return this;
  }

// initializes the registration of on_boarding-scope dependencies inside of GetIt
  _i1.GetIt initOn_boardingScope({_i1.ScopeDisposeFunc? dispose}) {
    return _i2.GetItHelper(this).initScope(
      'on_boarding',
      dispose: dispose,
      init: (_i2.GetItHelper gh) {
        gh.lazySingleton<_i7.OnBoardingLocalDatasource>(
            () => _i7.OnBoardingLocalDatasourceImpl(gh<_i6.HiveInterface>()));
        gh.lazySingleton<_i8.OnBoardingRepo>(
            () => _i9.OnBoardingRepoImpl(gh<_i7.OnBoardingLocalDatasource>()));
        gh.lazySingleton<_i10.CacheFirstTime>(
            () => _i10.CacheFirstTime(gh<_i8.OnBoardingRepo>()));
        gh.lazySingleton<_i11.CheckIfUserIsFirstTimer>(
            () => _i11.CheckIfUserIsFirstTimer(gh<_i8.OnBoardingRepo>()));
        gh.factory<_i12.OnBoardingCubit>(() => _i12.OnBoardingCubit(
              cacheFirstTimer: gh<_i10.CacheFirstTime>(),
              checkIfUserIsFirstTimer: gh<_i11.CheckIfUserIsFirstTimer>(),
            ));
      },
    );
  }

// initializes the registration of auth-scope dependencies inside of GetIt
  _i1.GetIt initAuthScope({_i1.ScopeDisposeFunc? dispose}) {
    return _i2.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i2.GetItHelper gh) {
        gh.lazySingleton<_i13.AuthRemoteDataSource>(
            () => _i13.AuthRemoteDataSourceImpl(
                  authClient: gh<_i3.FirebaseAuth>(),
                  cloudStoreClient: gh<_i4.FirebaseFirestore>(),
                  dbClient: gh<_i5.FirebaseStorage>(),
                ));
        gh.lazySingleton<_i14.AuthRepo>(
            () => _i15.AuthRepoImpl(gh<_i13.AuthRemoteDataSource>()));
        gh.lazySingleton<_i16.ForgotPassword>(
            () => _i16.ForgotPassword(gh<_i14.AuthRepo>()));
        gh.lazySingleton<_i17.SignIn>(() => _i17.SignIn(gh<_i14.AuthRepo>()));
        gh.lazySingleton<_i18.SignUp>(() => _i18.SignUp(gh<_i14.AuthRepo>()));
        gh.lazySingleton<_i19.UpdateUser>(
            () => _i19.UpdateUser(gh<_i14.AuthRepo>()));
        gh.factory<_i20.AuthBloc>(() => _i20.AuthBloc(
              signIn: gh<_i17.SignIn>(),
              signUp: gh<_i18.SignUp>(),
              forgotPassword: gh<_i16.ForgotPassword>(),
              updateUser: gh<_i19.UpdateUser>(),
            ));
      },
    );
  }
}

class _$RegisterModule extends _i21.RegisterModule {}
