import 'package:flutter/material.dart';

class AppSnackbar {
  static void success({
    required BuildContext context,
    required String message,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: behavior,
        duration: duration,
      ),
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: behavior,
        duration: duration,
      ),
    );
  }

  static void info({
    required BuildContext context,
    required String message,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        behavior: behavior,
        duration: duration,
      ),
    );
  }
}
