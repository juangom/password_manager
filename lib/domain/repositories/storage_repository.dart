import 'package:dartz/dartz.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/values/password_path.dart';
import 'package:password_manager/domain/values/password_value.dart';

abstract class StorageRepository {
  Future<Option<Failure>> addPassword(
    PasswordPath path,
    PasswordValue password,
  );
  Future<Either<Failure, Password>> getPassword(PasswordPath path);
  Future<Option<Failure>> deletePassword(PasswordPath path);
  Future<Option<Failure>> deleteAll();
  Future<Option<Failure>> updatePassword(
    PasswordPath path,
    PasswordValue newPassword,
  );
}
