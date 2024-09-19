import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _numberFrom = 0;
  String _resultMessage = '';  // Initialize to an empty string
  String _fromUnit = 'meters';
  String _toUnit = 'kilometers';

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  final List<List<double>> _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.001, 0, 0, 0.00220462, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  ];

  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];

    if (nFrom != null && nTo != null) {
      var multiplier = _formulas[nFrom][nTo];
      var result = value * multiplier;

      if (result == 0) {
        _resultMessage = 'This conversion cannot be performed';
      } else {
        _resultMessage = '$value $from are $result $to';
      }
    } else {
      _resultMessage = 'Invalid conversion';
}
    
    setState(() {});
}

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unit Converter'),
),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  _numberFrom = double.tryParse(value) ?? 0;
                },
                style: inputStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter value'),
),
              DropdownButton<String>(
                value: _fromUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    _fromUnit = newValue!;
                  });
                },
                items: _measures.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: _toUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    _toUnit = newValue!;
                  });
                },
                items: _measures.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  convert(_numberFrom, _fromUnit, _toUnit);
                },
                child: Text('Convert'),
              ),
              Text(
                _resultMessage,
                style: TextStyle(fontSize: 20),
),
],
),
),
),
);
}
}
