import 'package:flutter/material.dart';

Future<void> showLoadingDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) => const Center(
            child: CircularProgressIndicator(strokeWidth: 4),
          ));
}
