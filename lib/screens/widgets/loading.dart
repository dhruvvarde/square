import 'package:flutter/material.dart';

/// displays a loading spinner
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: CircularProgressIndicator(
      value: null,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 7.0,
    ),
  );
}