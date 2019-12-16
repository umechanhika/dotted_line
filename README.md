# About

This package allows you to draw dotted lines with Flutter.

![screenshot.png](https://github.com/umechanhika/dotted_line/blob/master/image/screenshot.png "screenshot.png")

# Usage

| Parameter         | Default         | Description                              |
| ----------------- | :-------------: | ---------------------------------------: |
| **direction**     | Axis.horizontal | The direction of the entire dotted line. |
| **lineLength**    | double.infinity | The length of the entire dotted line.    |
| **lineThickness** | 1.0             | The thickness of the entire dotted line. |
| **dashLength**    | 4.0             | The length of the dash.                  |
| **dashColor**     | Colors.black    | The color of the dash.                   |
| **dashGapLength** | 4.0             | The length of the dash gap.              |
| **dashGapColor**  | Colors.white    | The color of the dash gap.               |

This can be used without parameters.

```
import 'package:dotted_line/dotted_line.dart';

DottedLine()
```

You can also customize by specifying parameters.

```
import 'package:dotted_line/dotted_line.dart';

DottedLine(
  direction: Axis.horizontal,
  lineLength: double.infinity,
  lineThickness: 1.0,
  dashLength: 4.0,
  dashColor: Colors.black,
  dashGapLength: 4.0,
  dashGapColor: Colors.white,
)
```

# Example
The sample code can be found under the `example` package.
You can try changing all parameters.