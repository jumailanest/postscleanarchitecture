// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:postscleanarchitecture/core/network/network.dart' as _i165;
import 'package:postscleanarchitecture/core/network/network_info.dart' as _i327;
import 'package:postscleanarchitecture/features/posts/application/postbloc/posts_bloc.dart'
    as _i864;
import 'package:postscleanarchitecture/features/posts/data/datsources/posts_remote_datasource.dart'
    as _i655;
import 'package:postscleanarchitecture/features/posts/data/repositories/posts_repository.dart'
    as _i107;
import 'package:postscleanarchitecture/features/posts/domain/repositories/i_post_repo.dart'
    as _i381;
import 'package:postscleanarchitecture/features/posts/domain/usecases/posts_usecase.dart'
    as _i986;
import 'package:postscleanarchitecture/injection_container/injectable.dart'
    as _i838;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i327.NetworkInfo>(
        () => _i327.NetworkInfoImpl(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i165.NetworkService>(
        () => _i165.HttpNetworkService(gh<_i327.NetworkInfo>()));
    gh.lazySingleton<_i655.PostRemoteDataSource>(() =>
        _i655.PostRemoteDatasourceImpl(
            networkService: gh<_i165.NetworkService>()));
    gh.lazySingleton<_i381.IPostsRepo>(() => _i107.PostsRepository(
        remoteDataSource: gh<_i655.PostRemoteDataSource>()));
    gh.factory<_i986.PostsUseCase>(
        () => _i986.PostsUseCase(postsRepo: gh<_i381.IPostsRepo>()));
    gh.factory<_i864.PostsBloc>(
        () => _i864.PostsBloc(gh<_i986.PostsUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i838.RegisterModule {}
