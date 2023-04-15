import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ErrorReceiver extends GetxController {
  final ValueNotifier<String?> _errorNotifier = ValueNotifier<String?>(null);

  String? get error => _errorNotifier.value;

  ValueNotifier get notifier => _errorNotifier;

  void onError(String errorMessage) {
    _errorNotifier.value = errorMessage;
    Future.delayed(const Duration(seconds: 3), () {
      _errorNotifier.value = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _errorNotifier.dispose();
  }

  String errorString() {
    final message = 'Error: $error';
    return message;
  }
}
