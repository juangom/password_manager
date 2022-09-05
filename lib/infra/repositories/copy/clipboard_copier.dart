import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@injectable
class FlutterServicesClipboardCopier {
  Future<void> copyToClipboard(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }
}
