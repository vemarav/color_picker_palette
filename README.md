# color_picker_palette 0.1.3

A color picker palette with custom colors.

## Usage
Using `color_picker_palette` you can provide
user with list of custom colors to choose.

It will show a horizontal list of colors including
a button to add custom colors for user.

Long press will remove color from the list.

You can refer [color_picker_palette/example](https://github.com/vemarav/color_picker_palette/tree/master/example)

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
