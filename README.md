![logo.png](https://github.com/umechanhika/dotted_line/blob/master/image/github-social-preview.png "logo.png")

---

# About

This package allows you to draw dotted lines with Flutter.

![screenshot.png](https://github.com/umechanhika/dotted_line/blob/master/image/screenshot.png "screenshot.png")

# Usage

| Parameter           |       Default        |                              Description |
|---------------------|:--------------------:|-----------------------------------------:|
| **direction**       |   Axis.horizontal    | The direction of the entire dotted line. |
| **alignment**       | WrapAlignment.center | The alignment of the entire dotted line. |
| **lineLength**      |   double.infinity    |    The length of the entire dotted line. |
| **lineThickness**   |         1.0          | The thickness of the entire dotted line. |
| **dashLength**      |         4.0          |                  The length of the dash. |
| **dashColor**       |     Colors.black     |                   The color of the dash. |
| **dashGradient**    |         null         |         The gradient colors of the dash. |
| **dashRadius**      |         0.0          |                  The radius of the dash. |
| **dashGapLength**   |         4.0          |              The length of the dash gap. |
| **dashGapColor**    |  Colors.transparent  |               The color of the dash gap. |
| **dashGapGradient** |         null         |     The gradient colors of the dash gap. |
| **dashGapRadius**   |         0.0          |              The radius of the dash gap. |

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
  alignment: WrapAlignment.center,
  lineLength: double.infinity,
  lineThickness: 1.0,
  dashLength: 4.0,
  dashColor: Colors.black,
  dashGradient: [Colors.red, Colors.blue],
  dashRadius: 0.0,
  dashGapLength: 4.0,
  dashGapColor: Colors.transparent,
  dashGapGradient: [Colors.red, Colors.blue],
  dashGapRadius: 0.0,
)
```

# Example
The sample code can be found under the `example` package.
You can try changing all parameters.
