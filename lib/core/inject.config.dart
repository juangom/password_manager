// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../domain/repositories/password_repository.dart' as _i5;
import '../domain/repositories/storage_repository.dart' as _i7;
import '../infra/repositories/password_metadata/drift/tables.dart' as _i3;
import '../infra/repositories/password_metadata/drift_module.dart' as _i9;
import '../infra/repositories/password_metadata/password_list_repository.dart'
    as _i6;
import '../infra/repositories/storage/secure_storage.dart' as _i8;
import '../infra/repositories/storage/secure_storage_module.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final driftModule = _$DriftModule();
  final secureStorageModule = _$SecureStorageModule();
  gh.factory<_i3.Database>(() => driftModule.db);
  gh.factory<_i4.FlutterSecureStorage>(() => secureStorageModule.storage);
  gh.factory<_i5.PasswordListRepository>(
      () => _i6.DriftPasswordListRepository(db: get<_i3.Database>()));
  gh.factory<_i7.StorageRepository>(() =>
      _i8.SecureStorageRepository(storage: get<_i4.FlutterSecureStorage>()));
  return get;
}

class _$DriftModule extends _i9.DriftModule {}

class _$SecureStorageModule extends _i10.SecureStorageModule {}
