import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Returns the fill colors of every dash/gap [Container], in render order.
List<Color> _containerColors(WidgetTester tester) {
  final colors = <Color>[];
  for (final c in tester.widgetList<Container>(find.byType(Container))) {
    final decoration = c.decoration;
    if (decoration is BoxDecoration && decoration.color != null) {
      colors.add(decoration.color!);
    }
  }
  return colors;
}

void main() {
  testWidgets('renders with default parameters', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DottedLine())),
    );

    expect(find.byType(DottedLine), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('applies the solid dashColor to dashes', (tester) async {
    const dashColor = Color(0xFF00FF00);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DottedLine(lineLength: 100, dashColor: dashColor),
        ),
      ),
    );

    expect(_containerColors(tester), contains(dashColor));
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashGradient interpolates from the start to the end color',
      (tester) async {
    const start = Color(0xFFFF0000); // red
    const end = Color(0xFF0000FF); // blue

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 300,
            child: DottedLine(
              lineLength: 300,
              dashLength: 10,
              dashGapLength: 10,
              dashGradient: const [start, end],
            ),
          ),
        ),
      ),
    );

    // Gaps default to transparent; keep only the opaque dashes.
    final dashes =
        _containerColors(tester).where((c) => c != Colors.transparent).toList();

    expect(dashes.length, greaterThan(1));
    // The first dash sits at t = 0, so it equals the start color exactly.
    expect(dashes.first, start);
    // The gradient must actually vary across the line.
    expect(dashes.toSet().length, greaterThan(1));
    expect(dashes.last, isNot(start));
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders vertically without error', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DottedLine(direction: Axis.vertical, lineLength: 100),
        ),
      ),
    );

    expect(find.byType(DottedLine), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('wraps the line in a RepaintBoundary when enabled',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DottedLine(addRepaintBoundary: true, lineLength: 100),
        ),
      ),
    );

    // The RepaintBoundary should be an ancestor of the line's SizedBox.
    expect(
      find.ancestor(
        of: find.byType(SizedBox),
        matching: find.byType(RepaintBoundary),
      ),
      findsWidgets,
    );
    expect(tester.takeException(), isNull);
  });

  test('asserts that dashGradient has exactly two colors', () {
    expect(
      () => DottedLine(dashGradient: const [Colors.red]),
      throwsAssertionError,
    );
  });

  test('asserts that dashGapGradient has exactly two colors', () {
    expect(
      () => DottedLine(dashGapGradient: const [Colors.red]),
      throwsAssertionError,
    );
  });
}
