import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/domain/repositories/password_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';

class MockPasswordListRepository extends Mock
    implements PasswordListRepository {}

class MockStorageRepository extends Mock implements StorageRepository {}

final getIt = GetIt.instance;
void configure() {
  getIt.registerFactory<PasswordListRepository>(
      () => MockPasswordListRepository());
  getIt.registerFactory<StorageRepository>(() => MockStorageRepository());
}

void main() {
  configure();
  testWidgets('Test HomePage', (tester) async {
    // await tester.pumpWidget(const MainApp());
    // await tester.pumpAndSettle();
    // final finder = find.byElementType(HomePage);
    // expect(finder, findsOneWidget);
  });
}
