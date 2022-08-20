import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:password_manager/domain/repositories/password_repository.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';

class MoorPasswordListRepository extends PasswordListRepository {
  @override
  Future<Either<Failure, PasswordMetadata>> addPassword(
      PasswordMetadataValue passwordValue) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PasswordMetadata>>> deletePassword(
      PasswordMetadata password) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PasswordMetadata>>> loadPasswords() async {
    return right([]);
  }
}
