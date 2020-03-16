import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxShadow buildBoxShadow(double verticalMove) {
  return BoxShadow(
    color: Colors.grey,
    blurRadius: 1.5,
    spreadRadius: 1.5,
    offset: Offset(
      1.5, // horizontal move
      verticalMove, // vertica move
    ),
  );
}
