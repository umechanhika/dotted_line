library dotted_line;

import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({
    this.direction = Axis.horizontal,
    this.lineLength = double.infinity,
    this.lineThickness = 1.0,
    this.dashLength = 4.0,
    this.dashColor = Colors.black,
    this.dashGapLength = 4.0,
    this.dashGapColor = Colors.transparent,
    this.dashRadius = 0.0,
    this.dashGapRadius = 0.0,
  });

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
    return Container(
      width: direction == Axis.horizontal ? lineLength : lineThickness,
      height: direction == Axis.vertical ? lineLength : lineThickness,
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemBuilder: (_, index) {
              return index % 2 == 0 ? _buildDash() : _buildDashGap();
            },
            scrollDirection: direction,
            physics: NeverScrollableScrollPhysics(),
          )),
    );
  }

  Widget _buildDash() {
    return Container(
      decoration: BoxDecoration(
        color: dashColor,
        borderRadius: BorderRadius.circular(dashRadius),
      ),
      width: direction == Axis.horizontal ? dashLength : lineThickness,
      height: direction == Axis.vertical ? dashLength : lineThickness,
    );
  }

  Widget _buildDashGap() {
    return Container(
      decoration: BoxDecoration(
        color: dashGapColor,
        borderRadius: BorderRadius.circular(dashGapRadius),
      ),
      width: direction == Axis.horizontal ? dashGapLength : lineThickness,
      height: direction == Axis.vertical ? dashGapLength : lineThickness,
    );
  }
}
