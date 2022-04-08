import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class _LogoAnimated extends AnimatedWidget {
  static final _alignmentTween = AlignmentTween(
    begin: Alignment.center,
    end: Alignment.topCenter,
  );
  static final _sizeTween = Tween<double>(begin: 80.0, end: 48.0);

  _LogoAnimated({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Container(
      alignment: _alignmentTween.evaluate(animation),
      margin: EdgeInsets.symmetric(vertical: 100.0),
      constraints: BoxConstraints(minHeight: 48.0),
      child: Image.asset(
        'icons/ic_jewel.png',
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
      ),
    );
  }
}

/// Displays the square logo with an opening animation
class AnimatedSquareLogo extends StatefulWidget {
  /// initialize with a callback
  AnimatedSquareLogo({
    this.onLogoAnimated,
  });

  /// callback that fires after the logo animation is finished
  final VoidCallback? onLogoAnimated;

  _LogoState createState() => _LogoState();
}

class _LogoState extends State<AnimatedSquareLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation.addStatusListener((var status) {
      if (status == AnimationStatus.completed) {
        widget.onLogoAnimated!();
      }
    });
    controller.forward();
  }

  Widget build(BuildContext context) => _LogoAnimated(animation: animation);

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}