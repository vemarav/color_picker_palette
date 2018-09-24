import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({this.color, this.onTap, this.size, this.child})
      : assert(
  color != null,
  "Provide Color for CircleButton \n Example: " +
    "\n\n CircleButton(color: Colors.blue)");

  final Function onTap;
  final double size;
  final Widget child;
  final Color color;
  static const double DEFAULT_SIZE = 50.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: child,
        margin: EdgeInsets.all(4.0),
        width: size ?? DEFAULT_SIZE,
        height: size ?? DEFAULT_SIZE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
