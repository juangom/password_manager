import 'package:injectable/injectable.dart';
import 'package:password_manager/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:password_manager/domain/entities/password.dart';
import 'package:password_manager/domain/repositories/copy_repository.dart';
import 'package:password_manager/infra/repositories/copy/clipboard_copier.dart';

@Injectable(as: CopyRepository)
class FlutterServicesCopyRepository extends CopyRepository {
  FlutterServicesCopyRepository({
    required FlutterServicesClipboardCopier clipboardCopier,
  }) : _clipboardCopier = clipboardCopier;
  final FlutterServicesClipboardCopier _clipboardCopier;
  @override
  Future<Option<Failure>> copy(Password password) async {
    try {
      await _clipboardCopier.copyToClipboard(password);
      return none();
    } catch (e) {
      return some(Failure(msg: e.toString()));
    }
  }
}
