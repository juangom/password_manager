import 'package:dartz/dartz.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/values/password_value.dart';

abstract class StorageRepository {
  Future<Option<Failure>> addPassword(
    String path,
    PasswordValue password,
  );
  Future<Either<Failure, Password>> getPassword(String path);
  Future<Option<Failure>> deletePassword(String path);
  Future<Option<Failure>> deleteAll();
  Future<Option<Failure>> updatePassword(
    String path,
    PasswordValue newPassword,
  );
}
