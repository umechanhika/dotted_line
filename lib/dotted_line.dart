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
    this.dashGapColor = Colors.white,
  });

  final Axis direction;
  final double lineLength;
  final double lineThickness;

  final double dashLength;
  final Color dashColor;

  final double dashGapLength;
  final Color dashGapColor;

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
      width: direction == Axis.horizontal ? dashLength : lineThickness,
      height: direction == Axis.vertical ? dashLength : lineThickness,
      color: dashColor,
    );
  }

  Widget _buildDashGap() {
    return Container(
      width: direction == Axis.horizontal ? dashGapLength : lineThickness,
      height: direction == Axis.vertical ? dashGapLength : lineThickness,
      color: dashGapColor,
    );
  }
}
