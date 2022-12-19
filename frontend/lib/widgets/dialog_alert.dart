import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogAlert extends StatelessWidget {
  final String title;
  final String content;
  final Function actionOk;

  const DialogAlert({
    super.key,
    required this.title,
    required this.content,
    required this.actionOk,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context, 'Cancel'),
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {
                actionOk,
                Navigator.pop(context, 'OK'),
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: Text(title),
    );
  }
}
