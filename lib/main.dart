import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Tip Calculator',
    home: TipCalculator(),
  ));
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({Key? key}) : super(key: key);

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final billAmountController = TextEditingController();
  String selectedService = 'Normal Service';
  double tipPercentage = 0.15;
  double tipAmount = 0.0;

  void calculateTip() {
    setState(() {
      double billAmount = double.tryParse(billAmountController.text) ?? 0.0;
      tipAmount = billAmount * tipPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: billAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Bill Amount',
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedService,
              onChanged: (String? newValue) {
                setState(() {
                  selectedService = newValue!;
                  // Adjust tip percentage based on service level
                  tipPercentage = (selectedService == 'Outstanding Service') ? 0.20 : 0.15;
                });
                calculateTip();
              },
              items: <String>['Normal Service', 'Outstanding Service']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calculateTip();
              },
              child: const Text('Calculate Tip'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Tip Amount: \$${tipAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}