import 'package:flutter/material.dart';
import 'package:srr_management/theme/style.dart';

Future<String?> declinePopUp(BuildContext context,value, {required Function() onClickYes}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Text('$value?', style: kHeaderStyle()),
      content: Text('You are sure you want to $value this?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onClickYes,
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}
