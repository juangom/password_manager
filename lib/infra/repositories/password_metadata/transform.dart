import 'package:drift/drift.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';
import 'package:password_manager/infra/repositories/password_metadata/drift/tables.dart';

PasswordMetadata toDomain(Password dbMetadata) => PasswordMetadata(
      id: dbMetadata.id,
      name: dbMetadata.name,
      username: dbMetadata.username,
      created: dbMetadata.created,
      url: dbMetadata.url,
      notes: dbMetadata.notes,
    );

PasswordsCompanion toCompanion(PasswordMetadataValue metadata) =>
    PasswordsCompanion(
      name: Value(metadata.name),
      username: Value(metadata.username),
      url: Value(metadata.url ?? ''),
      notes: Value(metadata.notes ?? ''),
    );

Password toDB(PasswordMetadata metadata) => Password(
      id: metadata.id,
      name: metadata.name,
      username: metadata.username,
      url: metadata.url ?? '',
      notes: metadata.notes ?? '',
      created: metadata.created,
    );
