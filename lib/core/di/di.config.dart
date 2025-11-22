// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../auth/data/auth_data_source/AuthDataSourceImpl.dart' as _i571;
import '../../auth/data/auth_repository_impl/auth_repository_impl.dart'
    as _i342;
import '../../auth/domain/auth_repository/auth_repository.dart' as _i967;
import '../../auth/presentation/auth_cubit/register_cubit.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i571.AuthDataSourceImpl>(
      () => _i571.AuthDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i291.RegisterCubit>(
      () => _i291.RegisterCubit(gh<_i967.AuthRepository>()),
    );
    gh.lazySingleton<_i342.AuthRepositoryImpl>(
      () => _i342.AuthRepositoryImpl(gh<_i571.AuthDataSourceImpl>()),
    );
    return this;
  }
}
