import 'package:flutter/material.dart';

class AlertErrorLogin extends StatelessWidget {
  AlertErrorLogin({
    Key? key,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
  }) : super(key: key);

  final Duration duration;
  final double deltaX;
  final Curve curve;
  double shake(double animation) => 2 * (0.5 - (0.5 - curve.transform(animation)).abs());
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: key,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(deltaX * shake(animation), 0),
        child: child,
      ),
      child: const Text(
        'Email or Password is Incorrect',
        style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
