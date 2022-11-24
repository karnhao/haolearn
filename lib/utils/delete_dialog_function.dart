import 'package:flutter/material.dart';

Future<void> showDeleteDialog(BuildContext context,
    {Function() onDeleteConfirm = none, Function onDeleteDeny = none}) async {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Comfirm delete?'),
      content: const Text('This will gone forever.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            onDeleteDeny();
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onDeleteConfirm();
            Navigator.pop(context, 'OK');
          },
          child:
              const Text('Confirm Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

void none() {}
