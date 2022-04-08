import 'package:flutter/material.dart';

/// A static square logo
class SquareLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 100.0),
    child: Image.asset(
      'icons/ic_jewel.png',
      height: 48.0,
      width: 48.0,
    ),
  );
}