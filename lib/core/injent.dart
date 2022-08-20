import 'package:get_it/get_it.dart';
import 'package:password_manager/domain/repositories/password_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';
import 'package:password_manager/infra/repositories/password_metadata/password_list_repository.dart';
import 'package:password_manager/infra/repositories/storage/secure_storage.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerFactory<PasswordListRepository>(
      () => MoorPasswordListRepository());
  getIt.registerFactory<StorageRepository>(() => SecureStorageRepository());
}
