import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastMassege {
  void toastMsg(BuildContext context, String title, String description,
      ToastificationType type) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.minimal,
      title: Text(title),
      description: Text(description),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
      dragToClose: true,
      showProgressBar: false,
    );
  }
}
