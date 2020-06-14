import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

const String _TITLE = 'DottedLine Demo';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _TITLE,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final space = SizedBox(height: 50);
    return Scaffold(
      appBar: AppBar(title: Text(_TITLE)),
      body: Column(
        children: <Widget>[
          space,
          Text("Default"),
          DottedLine(),
          space,
          Text("Dash length changed"),
          DottedLine(dashLength: 30),
          space,
          Text("Dashgap length changed"),
          DottedLine(dashLength: 30, dashGapLength: 30),
          space,
          Text("Line thickness changed"),
          DottedLine(
            dashLength: 30,
            dashGapLength: 30,
            lineThickness: 50,
          ),
          space,
          Text("Dash and dashgap color changed"),
          DottedLine(
            dashLength: 30,
            dashGapLength: 30,
            lineThickness: 50,
            dashColor: Colors.blue,
            dashGapColor: Colors.red,
          ),
          space,
          Text("Line direction and line length changed"),
          DottedLine(
            dashLength: 30,
            dashGapLength: 30,
            lineThickness: 50,
            dashColor: Colors.blue,
            dashGapColor: Colors.red,
            direction: Axis.vertical,
            lineLength: 150,
          ),
        ],
      ),
    );
  }
}
