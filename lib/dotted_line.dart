library dotted_line;

import 'package:flutter/material.dart';

/// Draw a dotted line.
///
/// Basic line settings
/// * [direction]
/// * [lineLength]
/// * [lineThickness]
/// Dash settings
/// * [dashLength]
/// * [dashColor]
/// * [dashGradient]
/// * [dashRadius]
/// Dash gap settings
/// * [dashGapLength]
/// * [dashGapColor]
/// * [dashGapRadius]
/// * [dashGapGradient]
class DottedLine extends StatelessWidget {
  /// Creates dotted line with the given parameters
  const DottedLine({
    Key? key,
    this.direction = Axis.horizontal,
    this.lineLength = double.infinity,
    this.lineThickness = 1.0,
    this.dashLength = 4.0,
    this.dashColor = Colors.black,
    this.dashGradient,
    this.dashGapLength = 4.0,
    this.dashGapColor = Colors.transparent,
    this.dashGapGradient,
    this.dashRadius = 0.0,
    this.dashGapRadius = 0.0,
  })  : assert(
            dashGradient == null || dashGradient.length == 2,
            'The dashGradient must have only two colors.\n'
            'The beginning color and the ending color of the gradient.'),
        assert(
            dashGapGradient == null || dashGapGradient.length == 2,
            'The dashGapGradient must have only two colors.\n'
            'The beginning color and the ending color of the gradient.'),
        super(key: key);

  /// The direction of the entire dotted line. Default [Axis.horizontal].
  final Axis direction;

  /// The length of the entire dotted line. Default [double.infinity].
  final double lineLength;

  /// The thickness of the entire dotted line. Default (1.0).
  final double lineThickness;

  /// The length of the dash. Default (4.0).
  final double dashLength;

  /// The color of the dash. Default [Colors.black].
  final Color dashColor;

  /// The gradient colors of the dash. Default null.
  /// The first color is beginning color, the second one is ending color.
  final List<Color>? dashGradient;

  /// The radius of the dash. Default (0.0).
  final double dashRadius;

  /// The length of the dash gap. Default (4.0).
  final double dashGapLength;

  /// The color of the dash gap. Default [Colors.transparent].
  final Color dashGapColor;

  /// The gradient colors of the dash gap. Default null.
  /// The first color is beginning color, the second one is ending color.
  final List<Color>? dashGapGradient;

  /// The radius of the dash gap. Default (0.0).
  final double dashGapRadius;

  @override
  Widget build(BuildContext context) {
    final isHorizontal = direction == Axis.horizontal;

    return SizedBox(
      width: isHorizontal ? lineLength : lineThickness,
      height: isHorizontal ? lineThickness : lineLength,
      child: LayoutBuilder(builder: (context, constraints) {
        final lineLength = _getLineLength(constraints, isHorizontal);
        final dashAndDashGapCount = _calculateDashAndDashGapCount(lineLength);
        final dashCount = dashAndDashGapCount[0];
        final dashGapCount = dashAndDashGapCount[1];

        return Wrap(
          direction: direction,
          children: List.generate(dashCount + dashGapCount, (index) {
            if (index % 2 == 0) {
              final dashColor = _getDashColor(dashCount, index ~/ 2);
              final dash = _buildDash(isHorizontal, dashColor);
              return dash;
            } else {
              final dashGapColor = _getDashGapColor(dashGapCount, index ~/ 2);
              final dashGap = _buildDashGap(isHorizontal, dashGapColor);
              return dashGap;
            }
          }).toList(growable: false),
        );
      }),
    );
  }

  /// If [lineLength] is [double.infinity],
  /// get the maximum value of the parent widget.
  /// And if the value is specified, use the specified value.
  double _getLineLength(BoxConstraints constraints, bool isHorizontal) {
    return lineLength == double.infinity
        ? isHorizontal
            ? constraints.maxWidth
            : constraints.maxHeight
        : lineLength;
  }

  /// Calculate the count of (dash + dashGap).
  ///
  /// example1) [lineLength] is 10, [dashLength] is 1, [dashGapLength] is 1.
  /// "- - - - - "
  /// example2) [lineLength] is 10, [dashLength] is 1, [dashGapLength] is 2.
  /// "-  -  -  -"
  List<int> _calculateDashAndDashGapCount(double lineLength) {
    var dashAndDashGapLength = dashLength + dashGapLength;
    var dashCount = lineLength ~/ dashAndDashGapLength;
    var dashGapCount = lineLength ~/ dashAndDashGapLength;
    if (dashLength <= lineLength % dashAndDashGapLength) {
      dashCount += 1;
    }
    return [dashCount, dashGapCount];
  }

  Widget _buildDash(bool isHorizontal, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(dashRadius),
      ),
      width: isHorizontal ? dashLength : lineThickness,
      height: isHorizontal ? lineThickness : dashLength,
    );
  }

  Color _getDashColor(int maxDashCount, int index) {
    return dashGradient == null
        ? dashColor
        : _calculateGradientColor(
            dashGradient![0],
            dashGradient![1],
            maxDashCount,
            index,
          );
  }

  Widget _buildDashGap(bool isHorizontal, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(dashGapRadius),
      ),
      width: isHorizontal ? dashGapLength : lineThickness,
      height: isHorizontal ? lineThickness : dashGapLength,
    );
  }

  Color _getDashGapColor(int maxDashGapCount, int index) {
    return dashGapGradient == null
        ? dashGapColor
        : _calculateGradientColor(
            dashGapGradient![0],
            dashGapGradient![1],
            maxDashGapCount,
            index,
          );
  }

  Color _calculateGradientColor(
    Color startColor,
    Color endColor,
    int maxItemCount,
    int index,
  ) {
    var diffAlpha = (endColor.alpha - startColor.alpha);
    var diffRed = (endColor.red - startColor.red);
    var diffGreen = (endColor.green - startColor.green);
    var diffBlue = (endColor.blue - startColor.blue);

    var amountOfChangeInAlphaPerItem = diffAlpha ~/ maxItemCount;
    var amountOfChangeInRedPerItem = diffRed ~/ maxItemCount;
    var amountOfChangeInGreenPerItem = diffGreen ~/ maxItemCount;
    var amountOfChangeInBluePerItem = diffBlue ~/ maxItemCount;

    return startColor
        .withAlpha(startColor.alpha + amountOfChangeInAlphaPerItem * index)
        .withRed(startColor.red + amountOfChangeInRedPerItem * index)
        .withGreen(startColor.green + amountOfChangeInGreenPerItem * index)
        .withBlue(startColor.blue + amountOfChangeInBluePerItem * index);
  }
}
