# color_picker_palette

A color picker palette with custom colors.

# Usage

> You can refer `color_picker_palette/example`.
```dart
colorPickerPalette = new ColorPickerPalette(
  size: 30.0,
  onChange: setColorState,
  colors: colors,
  buttonType: ButtonType.circular,
);
  
setColorState() {
  setState(() {
    color = colorPickerPalette.color();
  });
}
```

> Feel free contribute or raise issues.
