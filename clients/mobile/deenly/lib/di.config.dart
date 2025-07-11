// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/zikr/data/datasources/local/zikr_local_datasource.dart'
    as _i610;
import 'features/zikr/data/repositories/zikr_datasource_repository.dart'
    as _i928;
import 'features/zikr/usecases/zikr_usecase.dart' as _i727;

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
    gh.singleton<_i928.ZikrDatasourceRepository>(
        () => _i610.ZikrLocalDatasource());
    gh.singleton<_i727.ZikrUsecase>(
        () => _i727.ZikrUsecase(gh<_i928.ZikrDatasourceRepository>()));
    return this;
  }
}
