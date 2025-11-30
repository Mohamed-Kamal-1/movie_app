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
import '../../api/data_source_impl/delete_account_source_impl.dart' as _i859;
import '../../api/data_source_impl/get_profile_impl.dart' as _i382;
import '../../api/data_source_impl/movies_list_data_source_impl.dart' as _i116;
import '../../api/data_source_impl/update_profile_source_impl.dart' as _i167;
import '../../data/data_source/auth_data_source.dart' as _i862;
import '../../data/data_source/delete_account_source.dart' as _i508;
import '../../data/data_source/get_profile_source.dart' as _i261;
import '../../data/data_source/movies_list_data_source.dart' as _i1043;
import '../../data/data_source/update_profile_source.dart' as _i709;
import '../../data/repo_impl/auth_repo_impl.dart' as _i540;
import '../../data/repo_impl/delete_profile_repo_impl.dart' as _i729;
import '../../data/repo_impl/get_profile_repo_impl.dart' as _i676;
import '../../data/repo_impl/movies_repo_impl.dart' as _i274;
import '../../data/repo_impl/update_profile_repo_impl.dart' as _i383;
import '../../domain/repos/auth_repo.dart' as _i595;
import '../../domain/repos/delete_account_repo.dart' as _i567;
import '../../domain/repos/movies_repo.dart' as _i958;
import '../../domain/repos/profile_repo.dart' as _i862;
import '../../domain/repos/update_profile_repo.dart' as _i152;
import '../../domain/use_case/delete_account_use_case.dart' as _i686;
import '../../domain/use_case/login_use_case.dart' as _i461;
import '../../domain/use_case/movies_list.dart' as _i687;
import '../../domain/use_case/profile_use_case.dart' as _i591;
import '../../domain/use_case/update_profile_use_case.dart' as _i786;
import '../../presentation/ui/home_screen/cubit/home_screen_view_model.dart'
    as _i976;
import '../../presentation/ui/home_screen/cubit/watch_now_view_model.dart'
    as _i185;
import '../../presentation/ui/home_screen/provider/watch_now_section_view_model.dart'
    as _i863;
import '../../presentation/ui/home_screen/tabs/search_tab/cubit/search_screen_view_model.dart'
    as _i341;
import '../../ui/login_screen/login_view_model.dart' as _i103;
import '../../ui/UpdateProfile/bloc/profile_view_model.dart' as _i1046;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i149.ApiManager>(() => _i149.ApiManager());
    gh.factory<_i261.GetProfileSource>(
      () => _i382.GetProfileDataSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i709.UpdateProfileSource>(
      () => _i167.UpdateProfileSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i1043.MoviesListDataSource>(
      () => _i116.MoviesListDataSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i862.AuthDataSource>(
      () => _i1033.AuthDataSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i595.AuthRepo>(
      () => _i540.AuthRepoImpl(gh<_i862.AuthDataSource>()),
    );
    gh.factory<_i508.DeleteAccountSource>(
      () => _i859.DeleteAccountSoucreImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i958.MoviesRepo>(
      () => _i274.MoviesRepoImpl(gh<_i1043.MoviesListDataSource>()),
    );
    gh.factory<_i862.ProfileRepo>(
      () => _i676.GetProfileRepoImpl(gh<_i261.GetProfileSource>()),
    );
    gh.factory<_i152.UpdateProfileRepo>(
      () => _i383.UpdateProfileRepoImpl(gh<_i709.UpdateProfileSource>()),
    );
    gh.factory<_i567.DeleteAccountRepo>(
      () => _i729.DeleteAccountRepoImpl(gh<_i508.DeleteAccountSource>()),
    );
    gh.factory<_i591.ProfileUseCase>(
      () => _i591.ProfileUseCase(gh<_i862.ProfileRepo>()),
    );
    gh.factory<_i461.LoginUseCase>(
      () => _i461.LoginUseCase(gh<_i595.AuthRepo>()),
    );
    gh.factory<_i686.DeleteAccountUseCase>(
      () => _i686.DeleteAccountUseCase(gh<_i567.DeleteAccountRepo>()),
    );
    gh.factory<_i687.MoviesListUseCase>(
      () => _i687.MoviesListUseCase(gh<_i958.MoviesRepo>()),
    );
    gh.factory<_i786.UpdateProfileUseCase>(
      () => _i786.UpdateProfileUseCase(gh<_i152.UpdateProfileRepo>()),
    );
    gh.factory<_i1046.ProfileViewModel>(
      () => _i1046.ProfileViewModel(
        gh<_i591.ProfileUseCase>(),
        gh<_i786.UpdateProfileUseCase>(),
        gh<_i686.DeleteAccountUseCase>(),
        gh<_i687.MoviesListUseCase>(),
      ),
    );
    gh.factory<_i103.LoginViewModel>(
      () => _i103.LoginViewModel(gh<_i461.LoginUseCase>()),
    );
    gh.factory<_i976.HomeScreenViewModel>(
      () => _i976.HomeScreenViewModel(gh<_i687.MoviesListUseCase>()),
    );
    gh.factory<_i863.WatchNowSectionViewModel>(
      () => _i863.WatchNowSectionViewModel(gh<_i687.MoviesListUseCase>()),
    );
    gh.factory<_i341.SearchScreenViewModel>(
      () => _i341.SearchScreenViewModel(gh<_i687.MoviesListUseCase>()),
    );
    gh.factory<_i185.WatchNowViewModel>(
      () => _i185.WatchNowViewModel(gh<_i687.MoviesListUseCase>()),
    );
    return this;
  }
}
