import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCircularProgress(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator(),);
      });
}