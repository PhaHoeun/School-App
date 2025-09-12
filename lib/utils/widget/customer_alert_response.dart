import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomerAlertResponse {
  static showError(BuildContext context, {String? message}) {
    return showTopSnackBar(
      Overlay.of(context),
      curve: Curves.ease,
      animationDuration: const Duration(milliseconds: 500),
      CustomSnackBar.error(message: message ?? ''),
    );
  }

  static showSuccess(BuildContext context, {String? message}) {
    return showTopSnackBar(
      Overlay.of(context),
      curve: Curves.ease,
      animationDuration: const Duration(milliseconds: 500),
      CustomSnackBar.error(message: message ?? ''),
    );
  }
}
