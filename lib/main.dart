import 'package:flutter/material.dart';
import 'screens/authorize_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/manual_authorize_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(ExampleApp());

/// The root of this example app
class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: _buildTheme(),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/authorize': (context) => AuthorizeScreen(),
          '/authorize/manual': (context) => ManualAuthorizeScreen(),
          '/checkout': (context) => CheckoutScreen(),
        },
      );
}

// override default theme
ThemeData _buildTheme() {
  var base = ThemeData.light();
  return base.copyWith(
    backgroundColor: Color.fromRGBO(64, 135, 225, 1.0),
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: Color.fromRGBO(64, 135, 225, 1.0),
    buttonTheme: ButtonThemeData(
      height: 64.0,
    ),
    hintColor: Colors.transparent,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
        button: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        )),
  );
}
