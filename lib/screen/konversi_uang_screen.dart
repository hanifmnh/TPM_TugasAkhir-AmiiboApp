import 'package:flutter/material.dart';

class KonversiUangScreen extends StatefulWidget {
  const KonversiUangScreen({Key? key}) : super(key: key);

  @override
  _KonversiUangScreenState createState() => _KonversiUangScreenState();
}

class _KonversiUangScreenState extends State<KonversiUangScreen> {
  double _inputValue = 0;
  String _fromCurrency = 'IDR';
  String _toCurrency = 'USD';
  double _outputValue = 0;

  Map<String, double> conversionRates = {
    'IDR': 1,
    'USD': 0.000067,  // 1 IDR = 0.000067 USD
    'EUR': 0.000062,  // 1 IDR = 0.000062 EUR
    'MYR': 0.00031,   // 1 IDR = 0.00031 MYR
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Conversion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter the amount to convert:',
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  setState(() {
                    _inputValue = double.tryParse(value)!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                  items: <String>['IDR', 'USD', 'EUR', 'MYR']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toCurrency,
                  onChanged: (newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                  items: <String>['IDR', 'USD', 'EUR', 'MYR']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _convertCurrency();
              },
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Result: $_outputValue $_toCurrency',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _convertCurrency() {
    double fromRate = conversionRates[_fromCurrency]!;
    double toRate = conversionRates[_toCurrency]!;

    double convertedValue = (_inputValue / fromRate) * toRate;

    setState(() {
      _outputValue = convertedValue;
    });
  }
}
