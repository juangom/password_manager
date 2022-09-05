import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/infra/repositories/copy/clipboard_copier.dart';
import 'package:password_manager/infra/repositories/copy/copy.dart';

class MockFlutterServicesClipboardCopier extends Mock
    implements FlutterServicesClipboardCopier {}

void main() {
  group('Test FlutterServicesCopyRepository Success', () {
    MockFlutterServicesClipboardCopier mockFlutterServicesClipboardCopier =
        MockFlutterServicesClipboardCopier();

    FlutterServicesCopyRepository flutterServicesCopyRepository =
        FlutterServicesCopyRepository(
      clipboardCopier: mockFlutterServicesClipboardCopier,
    );

    when(() => mockFlutterServicesClipboardCopier.copyToClipboard(any()))
        .thenAnswer((_) async {});

    test('Test addPassword Success', () async {
      final result = await flutterServicesCopyRepository.copy('password');
      expect(result.isSome(), false);
    });
  });

  group('Test does not contain key', () {
    MockFlutterServicesClipboardCopier mockFlutterServicesClipboardCopier =
        MockFlutterServicesClipboardCopier();

    FlutterServicesCopyRepository flutterServicesCopyRepository =
        FlutterServicesCopyRepository(
      clipboardCopier: mockFlutterServicesClipboardCopier,
    );

    when(() => mockFlutterServicesClipboardCopier.copyToClipboard(any()))
        .thenThrow((_) => Exception('Fail'));

    test('Test addPassword Success', () async {
      final result = await flutterServicesCopyRepository.copy('password');
      expect(result.isSome(), true);
    });
  });
}
