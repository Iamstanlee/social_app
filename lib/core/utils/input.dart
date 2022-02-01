import 'package:flutter/services.dart';

class InputUtils {
  InputUtils._();
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
  }
}
