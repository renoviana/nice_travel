import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

void removerDialog(BuildContext context, String title, Function onDelete) {
  showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
            image: new Image.asset("noo.gif"),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: Text(
              'Esse dia será apagado e não poderá ser revertido.',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            entryAnimation: EntryAnimation.BOTTOM_LEFT,
            onOkButtonPressed: () => Function.apply(onDelete, []),
          ));
}

void publishDialog(BuildContext context, String title, Function onPublish) {
  showDialog(
      context: context,
      builder: (_) => AssetGiffyDialog(
            image: new Image.asset("yes.gif"),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: Text(
              'Não será possível possível despublicar.',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            entryAnimation: EntryAnimation.BOTTOM_LEFT,
            onOkButtonPressed: () => Function.apply(onPublish, []),
          ));
}
