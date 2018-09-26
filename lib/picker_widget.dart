import 'custom_button.dart';
import 'color_picker_palette.dart';
import 'package:flutter/material.dart';

class ColorPickerPaletteWidget extends StatefulWidget {
  ColorPickerPaletteWidget(
      {Key key, this.size, this.callback, this.colors, this.buttonType})
      : super(key: key);
  final double size;
  final List<Color> colors;
  final VoidCallback callback;
  final ButtonType buttonType;

  @override
  State<StatefulWidget> createState() => ColorPickerPaletteWidgetState(
        size: size,
        callback: callback,
        colors: colors,
        buttonType: buttonType,
      );
}

class ColorPickerPaletteWidgetState extends State<ColorPickerPaletteWidget> {
  ColorPickerPaletteWidgetState(
      {this.size, this.callback, this.colors, this.buttonType});

  final VoidCallback callback;
  final List<Color> colors;
  final double size;
  final ButtonType buttonType;
  static const double DEFAULT_SIZE = 50.0;
  Color color;
  _AddColorDialog _addColorDialog;
  GlobalKey<_AddColorDialogState> _addColorDialogKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addColorDialog = _AddColorDialog(
      key: _addColorDialogKey,
      onChange: onDialogResult,
    );
  }

  @override
  Widget build(BuildContext context) {
    var containerSize = (size ?? DEFAULT_SIZE) + 16.0;
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
    List<Widget> buttonWidgets = [];
    colors.forEach((color) {
      buttonWidgets.add(
        CustomButton(
          buttonType: buttonType,
          color: color,
          onTap: () {
            setState(() {
              this.color = color;
            });
            invokeCallback();
          },
          size: size,
          onLongPress: () {
            if (this.color == color) {
              setState(() {
                this.color = colors[0];
                colors.remove(color);
              });
            } else {
              setState(() {
                colors.remove(color);
              });
            }
            invokeCallback();
          },
        ),
      );
    });
    buttonWidgets.add(
      CustomButton(
        buttonType: buttonType,
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
    return buttonWidgets;
  }

  Future<String> showColorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _addColorDialog;
      },
    );
  }

  void onDialogResult() {
    setState(() {
      color = _addColorDialogKey.currentState.color;
      colors.add(color);
    });
    invokeCallback();
  }

  void invokeCallback() {
    if (callback != null) {
      callback();
    } else {
      print("warning: onChange Callback Not implemented"
          "You can provide method #onChange as\n"
          "  onChangeColor() {"
          "    TODO// setState"
          "  }"
          "\n"
          "_picker = ColorPickerPalette(..., onChange: onChangeColor)");
    }
  }
}

class _AddColorDialog extends StatefulWidget {
  _AddColorDialog({Key key, this.onChange}) : super(key: key);
  final VoidCallback onChange;

  @override
  State<StatefulWidget> createState() =>
      _AddColorDialogState(callback: onChange);
}

class _AddColorDialogState extends State<_AddColorDialog> {
  _AddColorDialogState({this.callback});
  final VoidCallback callback;
  Color color;
  TextEditingController _textController;
  String _error;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: alertTitle(),
      content: alertContent(),
      actions: <Widget>[
        okButton(),
        cancelButton(),
      ],
    );
  }

  Widget alertTitle() {
    return Text('Enter HEX color code');
  }

  Widget spanHash() {
    return Container(
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
    );
  }

  Widget spanInput() {
    return Expanded(
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget alertContent() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              spanHash(),
              spanInput(),
            ],
          ),
          errorWidget(),
        ],
      ),
    );
  }

  Widget errorWidget() {
    if (_error != null) {
      return Container(
        padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: Text(
          _error ?? '',
          style: TextStyle(
            color: Colors.red.shade700,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget okButton() {
    return FlatButton(
      child: Text(
        'OK',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: onSaveColor,
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text(
        'CANCEL',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed: onCancelColor,
    );
  }

  void onSaveColor() {
    try {
      if (_textController.text.length != 6) throw FormatException;
      Color _color = new Color(int.parse("0xFF${_textController.text}"));
      setState(() {
        color = _color;
        _error = null;
      });
      callback();
      Navigator.pop(context);
    } catch (exception) {
      setState(() {
        _error = 'Input is invalid';
      });
    }
  }

  void onCancelColor() {
    Navigator.pop(context);
  }
}
