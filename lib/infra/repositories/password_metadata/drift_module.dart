import 'package:injectable/injectable.dart';
import 'package:password_manager/infra/repositories/password_metadata/drift/tables.dart';

@module
abstract class DriftModule {
  Database get db => Database();
}
