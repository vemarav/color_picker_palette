library color_picker_palette;

import 'package:flutter/material.dart';
import 'package:color_picker_palette/picker_widget.dart';

enum ButtonType { circular, rounded, rectangle }

class ColorPickerPalette extends StatelessWidget {
  ColorPickerPalette({this.size, this.onChange, this.colors, this.buttonType})
      : assert(
            colors != null,
            "-------------------------------------------------"
            "\n\nError\n"
            "\tPlease provide colors property in Constructor\n"
            "\t\tExample\n"
            "\t\t1. picker = ColorPickerPalette("
            "\t\t\t\tcolors: [Colors.white, Colors.blue, Colors.red, Colors.green]\n"
            "\t\t\t);\n"
            "\t\t2. picker = ColorPickerPalette(colors: Colors.primaries)\n\n"
            "-------------------------------------------------"),
        assert(
            colors.isNotEmpty,
            "-------------------------------------------------"
            "\n\nError\n"
            "\tProvide at least one color in List\n"
            "\t\tpicker = ColorPickerPaletter(colors: [Colors.blue]);\n"
            "-------------------------------------------------");
  final GlobalKey<ColorPickerPaletteWidgetState> _widgetKey = GlobalKey();
  final double size;
  final List<Color> colors;
  final VoidCallback onChange;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return ColorPickerPaletteWidget(
      key: _widgetKey,
      size: size,
      callback: onChange,
      colors: colors,
      buttonType: buttonType,
    );
  }

  Color color() {
    return _widgetKey.currentState?.color ?? colors[0];
  }
}
