# color_picker_palette 0.1.0

A color picker palette with custom colors.

## Usage

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

## Contributing

We encourage you contribute to color_picker_palette flutter package.

## License

color_picker_palette is released under [MIT License](https://opensource.org/licenses/MIT)
