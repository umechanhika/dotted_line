library dotted_line;

import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({
    Key key,
    this.direction = Axis.horizontal,
    this.lineLength = double.infinity,
    this.lineThickness = 1.0,
    this.dashLength = 4.0,
    this.dashColor = Colors.black,
    this.dashGapLength = 4.0,
    this.dashGapColor = Colors.transparent,
    this.dashRadius = 0.0,
    this.dashGapRadius = 0.0,
  }) : super(key: key);

  final Axis direction;
  final double lineLength;
  final double lineThickness;

  final double dashLength;
  final Color dashColor;
  final double dashRadius;

  final double dashGapLength;
  final Color dashGapColor;
  final double dashGapRadius;

  @override
  Widget build(BuildContext context) {
    final bool isHorizontal = direction == Axis.horizontal;
    final Widget dash = _buildDash(isHorizontal);
    final Widget dashGap = _buildDashGap(isHorizontal);

    return SizedBox(
      width: isHorizontal ? lineLength : lineThickness,
      height: isHorizontal ? lineThickness : lineLength,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double lineLength = _getLineLength(constraints, isHorizontal);
        final int dashAndDashGapCount =
            _calculateDashAndDashGapCount(lineLength);

        return Wrap(
          direction: direction,
          children: List.generate(dashAndDashGapCount, (index) {
            return index % 2 == 0 ? dash : dashGap;
          }).toList(growable: false),
        );
      }),
    );
  }

  /// If [lineLength] is [double.infinity], get the maximum value of the parent widget. And if the value is specified, use the specified value.
  double _getLineLength(BoxConstraints constraints, bool isHorizontal) {
    return this.lineLength == double.infinity
        ? isHorizontal ? constraints.maxWidth : constraints.maxHeight
        : this.lineLength;
  }

  /// Calculate the count of (dash + dashGap).
  ///
  /// example1) [lineLength] is 10, [dashLength] is 1, [dashGapLength] is 1.
  /// "- - - - - "
  /// example2) [lineLength] is 10, [dashLength] is 1, [dashGapLength] is 2.
  /// "-  -  -  -"
  int _calculateDashAndDashGapCount(double lineLength) {
    final double dashAndDashGapLength = dashLength + dashGapLength;
    double dashAndDashGapCount = lineLength / dashAndDashGapLength * 2;

    if (dashLength <= lineLength % dashAndDashGapLength) {
      dashAndDashGapCount += 1;
    }

    return dashAndDashGapCount.toInt();
  }

  Widget _buildDash(bool isHorizontal) {
    return Container(
      decoration: BoxDecoration(
        color: dashColor,
        borderRadius: BorderRadius.circular(dashRadius),
      ),
      width: isHorizontal ? dashLength : lineThickness,
      height: isHorizontal ? lineThickness : dashLength,
    );
  }

  Widget _buildDashGap(bool isHorizontal) {
    return Container(
      decoration: BoxDecoration(
        color: dashGapColor,
        borderRadius: BorderRadius.circular(dashGapRadius),
      ),
      width: isHorizontal ? dashGapLength : lineThickness,
      height: isHorizontal ? lineThickness : dashGapLength,
    );
  }
}
