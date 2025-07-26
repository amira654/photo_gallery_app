// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:photo_gallery/core/di/network_module.dart' as _i405;
import 'package:photo_gallery/features/home/data/data_sources/local/photo_local_data_source.dart'
    as _i984;
import 'package:photo_gallery/features/home/data/data_sources/remote/photo_api_service.dart'
    as _i407;
import 'package:photo_gallery/features/home/data/repositories/photo_repository_impl.dart'
    as _i846;
import 'package:photo_gallery/features/home/domain/repositories/photo_repository.dart'
    as _i650;
import 'package:photo_gallery/features/home/domain/use_cases/get_photos_usecase.dart'
    as _i78;
import 'package:photo_gallery/features/home/presentation/cubit/photo_cubit.dart'
    as _i303;

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
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i984.PhotoLocalDataSource>(
        () => networkModule.photoLocalDataSource());
    gh.lazySingleton<_i407.PhotoApiService>(
        () => networkModule.photoApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i650.PhotoRepository>(() => _i846.PhotoRepositoryImpl(
          gh<_i407.PhotoApiService>(),
          gh<_i984.PhotoLocalDataSource>(),
        ));
    gh.lazySingleton<_i78.GetPhotosUseCase>(
        () => _i78.GetPhotosUseCase(gh<_i650.PhotoRepository>()));
    gh.factory<_i303.PhotoCubit>(
        () => _i303.PhotoCubit(gh<_i78.GetPhotosUseCase>()));
    return this;
  }
}

class _$NetworkModule extends _i405.NetworkModule {}
