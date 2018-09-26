import 'package:flutter/material.dart';
import 'package:color_picker_palette/color_picker_palette.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ColorPickerPalette colorPickerPalette;
  Color color;
  List<Color> colors = [];

  @override
  void initState() {
    super.initState();
    colors.add(Theme.of(context).primaryColor);
    colors.add(Colors.black);
    colors.add(Colors.white);
    color = colors[0];
    colorPickerPalette = new ColorPickerPalette(
      size: 30.0,
      onChange: setColorState,
      colors: colors,
      buttonType: ButtonType.circular,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          title: Text(
            'Color Picker Palette',
            style: TextStyle(color: Color(color.value - 10010110)),
          ),
        ),
        body: new Container(
          constraints: BoxConstraints.expand(),
          color: color,
          child: new Column(
            children: <Widget>[
              colorPickerPalette,
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  colorPickerPalette.color().toString(),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setColorState() {
    setState(() {
      color = colorPickerPalette.color();
    });
  }
}
