import 'package:injectable/injectable.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:password_manager/domain/repositories/password_repository.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';
import 'package:password_manager/infra/repositories/password_metadata/drift/tables.dart';
import 'package:password_manager/infra/repositories/password_metadata/transform.dart';

@Injectable(as: PasswordListRepository)
class DriftPasswordListRepository extends PasswordListRepository {
  DriftPasswordListRepository({
    required Database db,
  }) : _db = db;

  final Database _db;

  @override
  Future<Either<Failure, List<PasswordMetadata>>> loadPasswords() async {
    try {
      final result = await _db.allPasswords;
      return right(result.map((p) => toDomain(p)).toList());
    } catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PasswordMetadata>> addPassword(
      PasswordMetadataValue passwordValue) async {
    try {
      final result = await _db.add(toCompanion(passwordValue));
      return right(toDomain(result));
    } catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Option<Failure>> deletePassword(PasswordMetadata passwordMetadata) async {
    try {
      final result = await _db.remove(toDB(passwordMetadata));
      if (result == 1) {
        return none();
      }
      if (result == 0) {
        return some(Failure(msg: 'No passwords were deleted'));
      } else {
        return some(Failure(msg: 'Unexpected error'));
      }
    } catch (e) {
      return some(Failure(msg: e.toString()));
    }
  }
}
