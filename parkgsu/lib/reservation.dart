import 'package:flutter/material.dart';

class ReserveSpotScreen extends StatefulWidget {
  final String selectedDeck; // Parameter for selected deck

  // Constructor to accept selectedDeck
  const ReserveSpotScreen({Key? key, required this.selectedDeck})
      : super(key: key);

  @override
  _ReserveSpotScreenState createState() => _ReserveSpotScreenState();
}

class _ReserveSpotScreenState extends State<ReserveSpotScreen> {
  double _hours = 1;
  double _cost = 3.0; // Initial cost for 1 hour

  void _updateCost(double hours) {
    setState(() {
      _hours = hours;
      _cost = 3 + (2 * (_hours - 1)); // $3 for 1 hour, $2 per additional hour
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Reserve Parking Spot',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected parking deck
            Text(
              'Selected Deck: ${widget.selectedDeck}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            // Slider to select parking hours
            Text(
              'Select Duration: ${_hours.toStringAsFixed(0)} hours',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            Slider(
              value: _hours,
              min: 1,
              max: 12,
              divisions: 11,
              label: '${_hours.toStringAsFixed(0)} hours',
              onChanged: (value) {
                _updateCost(value);
              },
              activeColor: Colors.blueAccent[700],
              inactiveColor: Colors.blueGrey[700],
            ),
            SizedBox(height: 20),
            // Display the cost
            Text(
              'Cost: \$${_cost.toStringAsFixed(2)}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            // Reserve Button
            ElevatedButton(
              onPressed: () {
                // Implement the reservation logic here
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Reserve Spot',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
