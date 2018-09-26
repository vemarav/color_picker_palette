import 'color_picker_palette.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.color,
      this.onTap,
      this.onLongPress,
      this.size,
      this.child,
      this.buttonType})
      : assert(
            color != null,
            "Provide Color for CircleButton \n Example: " +
                "\n\n CircleButton(color: Colors.blue)");

  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ButtonType buttonType;
  final double size;
  final Widget child;
  final Color color;
  static const String DEFAULT_TYPE = 'circular';
  static const double DEFAULT_SIZE = 50.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: child,
        margin: EdgeInsets.all(4.0),
        width: size ?? DEFAULT_SIZE,
        height: (size ?? DEFAULT_SIZE),
        decoration: selected(),
      ),
      onLongPress: onLongPress,
    );
  }

  Decoration selected() {
    switch (buttonType) {
      case ButtonType.circular:
        return circular();
      case ButtonType.rounded:
        return rounded();
      case ButtonType.rectangle:
        return rectangular();
      default:
        return circular();
    }
  }

  Decoration rectangular() {
    return BoxDecoration(
      color: color,
      border: Border.all(
        color: Colors.grey,
        width: 1.5,
      ),
    );
  }

  Decoration circular() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(
        color: Colors.grey,
        width: 1.5,
      ),
    );
  }

  Decoration rounded() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular((size / 100) * 25)),
      color: color,
      border: Border.all(
        color: Colors.grey,
        width: 1.5,
      ),
    );
  }
}
