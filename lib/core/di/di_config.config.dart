// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:geolocator/geolocator.dart' as _i699;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:permission_handler/permission_handler.dart' as _i292;
import 'package:satagro/core/di/service_module.dart' as _i1061;
import 'package:satagro/presentation/map/cubit/map_page_cubit.dart' as _i807;
import 'package:satagro/presentation/table/cubit/table_page_cubit.dart'
    as _i773;

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
    final serviceModule = _$ServiceModule();
    gh.factory<_i292.Permission>(() => serviceModule.permission);
    gh.factory<_i699.GeolocatorPlatform>(() => serviceModule.geolocator);
    gh.factory<_i773.TablePageCubit>(() => _i773.TablePageCubit());
    gh.factory<_i807.MapPageCubit>(() => _i807.MapPageCubit(
          gh<_i292.Permission>(),
          gh<_i699.GeolocatorPlatform>(),
        ));
    return this;
  }
}

class _$ServiceModule extends _i1061.ServiceModule {}
