import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Status { warning, error, success, info }

class CustomSnackeBar {
  static void show(
      {required BuildContext context,
      required String message,
      required status}) {
    AnimatedSnackBar.material(
      
      message,
      type: status == Status.warning
          ? AnimatedSnackBarType.warning
          : status == Status.error
              ? AnimatedSnackBarType.error
              : status == Status.success
                  ? AnimatedSnackBarType.success
                  : AnimatedSnackBarType.info,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
      duration: const Duration(seconds: 2)
    ).show(context);
  }
}
