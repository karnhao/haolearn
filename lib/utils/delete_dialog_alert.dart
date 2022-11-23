import 'package:flutter/material.dart';
import 'package:haolearn/services/storage_service.dart';

class DeleteConfirm extends StatelessWidget {
  Function() function;
  DeleteConfirm({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        size: 30,
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Comfirm delete?'),
          content: const Text('This will gone forever.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                function();
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
