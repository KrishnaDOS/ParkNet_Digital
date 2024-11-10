import 'package:flutter/material.dart';
import 'payment_page.dart';

class ReserveSpotScreen extends StatefulWidget {
  final String selectedDeck;

  const ReserveSpotScreen({super.key, required this.selectedDeck});

  @override
  _ReserveSpotScreenState createState() => _ReserveSpotScreenState();
}

class _ReserveSpotScreenState extends State<ReserveSpotScreen> {
  double _hours = 1;
  double _cost = 3.0;

  void _updateCost(double hours) {
    setState(() {
      _hours = hours;
      _cost = 3 + (2 * (_hours - 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text('Reserve Parking Spot'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Deck: ${widget.selectedDeck}', style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 20),
            Text('Select Duration: ${_hours.toStringAsFixed(0)} hour(s)', style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 20),
            Slider(
              value: _hours,
              min: 1,
              max: 12,
              divisions: 11,
              label: '${_hours.toStringAsFixed(0)} hours',
              onChanged: _updateCost,
              activeColor: Colors.blueAccent[700],
              inactiveColor: Colors.blueGrey[700],
            ),
            SizedBox(height: 20),
            Text('Cost: \$${_cost.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage(amount: _cost)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent[700],
              ),
              child: Text('Proceed to Payment', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}