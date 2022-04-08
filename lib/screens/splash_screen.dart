import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:square_reader_sdk/reader_sdk.dart';

import 'widgets/animated_square_logo.dart';
import 'widgets/buttons.dart';
import 'widgets/square_logo.dart';

/// A screen that shows an animated square logo and asks for square permissions
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool _hasAnimated = false;
  bool _isCheckingPermissions = true;

  void initState() {
    super.initState();
  }

  Future _checkStatusAndNavigate() async {
    if (await ReaderSdk.isAuthorized) {
      Navigator.popAndPushNamed(context, '/checkout');
      return;
    }
    var permissionsStatus = await _permissionsStatus;
    var hasPermissions = permissionsStatus[0] == PermissionStatus.granted &&
        permissionsStatus[1] == PermissionStatus.granted;
    if (hasPermissions) {
      Navigator.popAndPushNamed(context, '/authorize');
    } else {
      setState(() {
        _isCheckingPermissions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _isCheckingPermissions
            ? ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: AnimatedSquareLogo(onLogoAnimated: () {
                  _checkStatusAndNavigate();
                }))
            : _PermissionSettings(),
      );
}

class _PermissionSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SquareLogo(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Grant Reader SDK the required permissions.',
            textAlign: TextAlign.center,
          ),
        ),
        Container(child: _ButtonContainer())
        // Container(child: Container())
      ]);
}

class _ButtonContainer extends StatefulWidget {
  @override
  _ButtonContainerState createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<_ButtonContainer> {
  bool _hasLocationAccess = false;
  String _locationButtonText = 'Enable Location Access';

  bool _hasMicrophoneAccess = false;
  String _microphoneButtonText = 'Enable Microphone Access';

  // @override
  void initState() {
    super.initState();
    checkPermissionsAndNavigate();
  }

  void requestPermission(Permission permission) async {
    switch (await permission.status) {
      //Works in ios
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
        //This condition is to check 'Don't ask again' on android'
        if (await permission.request().isPermanentlyDenied) {
          openAppSettings();
        }
        break;
    }

    checkPermissionsAndNavigate();
  }

  void onRequestLocationPermission() {
    requestPermission(Permission.locationWhenInUse);
  }

  void onRequestAudioPermission() {
    requestPermission(Permission.microphone);
  }

  void checkPermissionsAndNavigate() async {
    var permissionsStatus = await _permissionsStatus;

    // discard if wiget has been removed while waiting
    if (!mounted) return;

    updateLocationStatus(permissionsStatus[0]);
    updateMicrophoneStatus(permissionsStatus[1]);

    if (_hasLocationAccess && _hasMicrophoneAccess) {
      Navigator.popAndPushNamed(context, '/authorize');
    }
  }

  void updateLocationStatus(PermissionStatus status) {
    setState(() {
      _hasLocationAccess = status == PermissionStatus.granted;

      switch (status) {
        case PermissionStatus.granted:
          _locationButtonText = 'Location Enabled';
          break;
        case PermissionStatus.permanentlyDenied:
          _locationButtonText = 'Enable Location in Settings';
          break;
        case PermissionStatus.restricted:
          _locationButtonText = 'Location permission is restricted';
          break;
        case PermissionStatus.denied:
          _locationButtonText = 'Enable Location Access';
          break;
        case PermissionStatus.limited:
          _microphoneButtonText = 'Location permission is limited';
      }
    });
  }

  void updateMicrophoneStatus(PermissionStatus status) {
    setState(() {
      _hasMicrophoneAccess = status == PermissionStatus.granted;

      switch (status) {
        case PermissionStatus.granted:
          _microphoneButtonText = 'Microphone Enabled';
          break;
        case PermissionStatus.permanentlyDenied:
          _microphoneButtonText = 'Enable Microphone in Settings';
          break;
        case PermissionStatus.restricted:
          _microphoneButtonText = 'Microphone permission is restricted';
          break;
        case PermissionStatus.denied:
          _microphoneButtonText = 'Enable Microphone Access';
          break;
        case PermissionStatus.limited:
          _microphoneButtonText = 'Microphone permission is limited';
      }
    });
  }

  @override
  Widget build(BuildContext context) => SQButtonContainer(buttons: [
        SQOutlineButton(
          text: _microphoneButtonText,
          onPressed: _hasMicrophoneAccess ? null : onRequestAudioPermission,
        ),
        SQOutlineButton(
            text: _locationButtonText,
            onPressed: _hasLocationAccess ? null : onRequestLocationPermission),
      ]);
}

Future<List<PermissionStatus>> get _permissionsStatus async {
  var locationPermission = await Permission.locationWhenInUse.status;
  var microphonePermission = await Permission.microphone.status;
  return [locationPermission, microphonePermission];
}
