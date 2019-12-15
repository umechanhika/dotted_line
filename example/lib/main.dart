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
  Axis direction = Axis.horizontal;
  double lineLength = double.infinity;
  double lineThickness = 1.0;

  double dashLength = 4.0;
  Color dashColor = Colors.black;

  double dashGapLength = 4.0;
  Color dashGapColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_TITLE)),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: DottedLine(
                direction: direction,
                lineLength: lineLength,
                lineThickness: lineThickness,
                dashLength: dashLength,
                dashColor: dashColor,
                dashGapLength: dashGapLength,
                dashGapColor: dashGapColor,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(),
                    _buildTitle(context, 'Line'),
                    _buildItem('Direction', _buildDirectionDropDownButton()),
                    _buildItem('Line length', _buildLineLengthDropButton()),
                    _buildItem(
                        'Line thickness', _buildLineThicknessDropButton()),
                    Divider(),
                    _buildTitle(context, 'Dash'),
                    _buildItem('Dash length', _buildDashLengthDropButton()),
                    _buildItem('Dash color', _buildDashColorDropButton()),
                    Divider(),
                    _buildTitle(context, 'DashGap'),
                    _buildItem(
                        'Dash gap length', _buildDashGapLengthDropButton()),
                    _buildItem(
                        'Dash gap color', _buildDashGapColorDropButton()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _buildTitle(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.headline);
  }

  Widget _buildItem(String title, DropdownButton dropdownButton) {
    return Row(
      children: <Widget>[
        SizedBox(width: 120, child: Text(title)),
        dropdownButton,
      ],
    );
  }

  Widget _buildDirectionDropDownButton() {
    return DropdownButton(
      value: direction,
      items: _buildDropDownMenuItems([
        Axis.horizontal,
        Axis.vertical,
      ]),
      onChanged: (value) {
        setState(() {
          direction = value;
        });
      },
    );
  }

  Widget _buildLineLengthDropButton() {
    return DropdownButton(
      value: lineLength,
      items: _buildDropDownMenuItems([
        50.0,
        150.0,
        250.0,
        double.infinity,
      ]),
      onChanged: (value) {
        setState(() {
          lineLength = value;
        });
      },
    );
  }

  Widget _buildLineThicknessDropButton() {
    return DropdownButton(
      value: lineThickness,
      items: _buildDropDownMenuItems([
        1.0,
        10.0,
        100.0,
        200.0,
        double.infinity,
      ]),
      onChanged: (value) {
        setState(() {
          lineThickness = value;
        });
      },
    );
  }

  Widget _buildDashLengthDropButton() {
    return DropdownButton(
      value: dashLength,
      items: _buildDropDownMenuItems([
        4.0,
        8.0,
        16.0,
        24.0,
      ]),
      onChanged: (value) {
        setState(() {
          dashLength = value;
        });
      },
    );
  }

  Widget _buildDashColorDropButton() {
    return DropdownButton(
      value: dashColor,
      items: _buildDropDownMenuItems(
        [
          Colors.black,
          Colors.blue[500],
          Colors.red[500],
          Colors.amber[500],
          Colors.green[500],
        ],
        labels: [
          'black',
          'blue',
          'red',
          'amber',
          'green',
        ],
      ),
      onChanged: (value) {
        setState(() {
          dashColor = value;
        });
      },
    );
  }

  Widget _buildDashGapLengthDropButton() {
    return DropdownButton(
      value: dashGapLength,
      items: _buildDropDownMenuItems([
        4.0,
        8.0,
        16.0,
        24.0,
      ]),
      onChanged: (value) {
        setState(() {
          dashGapLength = value;
        });
      },
    );
  }

  Widget _buildDashGapColorDropButton() {
    return DropdownButton(
      value: dashGapColor,
      items: _buildDropDownMenuItems(
        [
          Colors.white,
          Colors.blue[500],
          Colors.red[500],
          Colors.amber[500],
          Colors.green[500],
        ],
        labels: [
          'white',
          'blue',
          'red',
          'amber',
          'green',
        ],
      ),
      onChanged: (value) {
        setState(() {
          dashGapColor = value;
        });
      },
    );
  }

  List<Widget> _buildDropDownMenuItems<T>(
    List<T> values, {
    List<String> labels,
  }) =>
      values
          .asMap()
          .map((index, value) => MapEntry(
              index,
              DropdownMenuItem<T>(
                value: value,
                child: value is Color && labels != null
                    ? Row(children: <Widget>[
                        SizedBox(width: 52.0, child: Text(labels[index])),
                        Container(color: value, width: 24.0, height: 24.0),
                      ])
                    : Text(value.toString()),
              )))
          .values
          .toList();
}
