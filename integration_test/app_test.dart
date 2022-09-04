import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:integration_test/integration_test.dart';
import 'package:password_manager/core/inject.dart';
import 'package:password_manager/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  configureDependencies(Environment.test);
  testWidgets(
    'An empty password list should not show any items in the home page',
    (tester) async {
      await tester.pumpWidget(const MainApp());
    },
  );
}
