// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../api/api_manager.dart' as _i149;
import '../../api/data_source_impl/auth_data_source_impl.dart' as _i1033;
import '../../api/data_source_impl/movies_list_data_source_impl.dart' as _i116;
import '../../data/data_source/auth_data_source.dart' as _i862;
import '../../data/data_source/movies_list_data_source.dart' as _i1043;
import '../../data/repo_impl/auth_repo_impl.dart' as _i540;
import '../../data/repo_impl/movies_repo_impl.dart' as _i274;
import '../../domain/repos/auth_repo.dart' as _i595;
import '../../domain/repos/movies_repo.dart' as _i958;
import '../../domain/use_case/login_use_case.dart' as _i461;
import '../../domain/use_case/movies_list.dart' as _i687;
import '../../presentation/ui/home_screen/cubit/home_screen_view_model.dart'
    as _i976;
import '../../ui/login_screen/login_view_model.dart' as _i103;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i149.ApiManager>(() => _i149.ApiManager());
    gh.factory<_i1043.MoviesListDataSource>(
      () => _i116.MoviesListDataSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i862.AuthDataSource>(
      () => _i1033.AuthDataSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i595.AuthRepo>(
      () => _i540.AuthRepoImpl(gh<_i862.AuthDataSource>()),
    );
    gh.factory<_i958.MoviesRepo>(
      () => _i274.MoviesRepoImpl(gh<_i1043.MoviesListDataSource>()),
    );
    gh.factory<_i461.LoginUseCase>(
      () => _i461.LoginUseCase(gh<_i595.AuthRepo>()),
    );
    gh.factory<_i687.MoviesListUseCase>(
      () => _i687.MoviesListUseCase(gh<_i958.MoviesRepo>()),
    );
    gh.factory<_i103.LoginViewModel>(
          () => _i103.LoginViewModel(gh<_i461.LoginUseCase>()),
    );
    gh.singleton<_i976.HomeScreenViewModel>(
      () => _i976.HomeScreenViewModel(gh<_i687.MoviesListUseCase>()),
    );
    return this;
  }
}
