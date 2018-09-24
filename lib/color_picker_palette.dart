library color_picker_palette;

import 'circle_button.dart';
import 'package:flutter/material.dart';

class ColorPickerPalette extends StatelessWidget {
  ColorPickerPalette({this.size, this.onChange, this.colors})
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
  final GlobalKey<_ColorPickerPaletteWidgetState> _widgetKey = GlobalKey();
  final double size;
  final List<Color> colors;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return _ColorPickerPaletteWidget(
      key: _widgetKey,
      size: size,
      callback: onChange,
      colors: colors,
    );
  }

  Color color() {
    return _widgetKey.currentState?.color ?? colors[0];
  }
}

class _ColorPickerPaletteWidget extends StatefulWidget {
  _ColorPickerPaletteWidget({Key key, this.size, this.callback, this.colors})
      : super(key: key);
  final double size;
  final List<Color> colors;
  final VoidCallback callback;

  @override
  State<StatefulWidget> createState() => _ColorPickerPaletteWidgetState(
        size: size,
        callback: callback,
        colors: colors,
      );
}

class _ColorPickerPaletteWidgetState extends State<_ColorPickerPaletteWidget> {
  _ColorPickerPaletteWidgetState({this.size, this.callback, this.colors});

  final VoidCallback callback;
  final List<Color> colors;
  final double size;
  static const double DEFAULT_SIZE = 50.0;
  Color color;
  TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    var containerSize = (size ?? DEFAULT_SIZE) + 16.0;
    _textController = TextEditingController(text: '');
    return Container(
      height: containerSize,
      child: ListView(
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        scrollDirection: Axis.horizontal,
        children: circleButtons(),
      ),
    );
  }

  List<Widget> circleButtons() {
    List<Widget> circleButtonWidgets = [];
    colors.forEach((color) {
      circleButtonWidgets.add(CircleButton(
        color: color,
        onTap: () {
          setState(() {
            this.color = color;
          });
          if (callback != null) {
            callback();
          } else {
            print(callback);
            print("TODO// message");
          }
        },
        size: size,
      ));
    });
    circleButtonWidgets.add(
      new CircleButton(
        size: size,
        child: Icon(
          Icons.add,
          color: Colors.grey.shade700,
        ),
        color: Colors.white,
        onTap: () {
          showColorDialog(context);
        },
      ),
    );
    return circleButtonWidgets;
  }

  Future<String> showColorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter HEX color code'),
            content: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2.0,
                      ),
                    ),
                    child: Text(
                      '#',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2.0,
                        ),
                      ),
                      child: EditableText(
                        controller: _textController,
                        cursorColor: Colors.black,
                        cursorWidth: 2.0,
                        focusNode: FocusNode(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Color _color =
                      new Color(int.parse("0xFF${_textController.text}"));
                  setState(() {
                    color = _color;
                    colors.add(_color);
                  });
                  callback();
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
