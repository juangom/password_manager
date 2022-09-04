import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/repositories/copy_repository.dart';

@Injectable(as: CopyRepository)
class FlutterServicesCopyRepository extends CopyRepository {
  @override
  Future<Option<Failure>> copy(Password password) async {
    try {
      Clipboard.setData(ClipboardData(text: password));
      return none();
    } catch (e) {
      return some(Failure(msg: e.toString()));
    }
  }
}
