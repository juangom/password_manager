import 'package:dartz/dartz.dart';
import 'package:password_manager/core/failure.dart';
import 'package:password_manager/domain/entities/password.dart';

abstract class CopyRepository {
  Future<Option<Failure>> copy(Password password);
}
