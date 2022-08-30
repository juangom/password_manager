import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

part 'tables.g.dart';

const _uuid = Uuid();

class Passwords extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get username => text().withLength(min: 1, max: 100)();
  TextColumn get url => text().withLength(min: 1, max: 500)();
  TextColumn get notes => text().withLength(min: 1, max: 1000)();
  DateTimeColumn get created => dateTime().withDefault(currentDate)();
}

@DriftDatabase(tables: [Passwords])
class Database extends _$Database {
  Database() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<List<Password>> get allPasswords => (select(passwords)).get();
  Future<Password> add(PasswordsCompanion companion) =>
      into(passwords).insertReturning(companion);
  Future<int> remove(Password password) {
    return (delete(passwords)..where((tbl) => tbl.id.equals(password.id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
