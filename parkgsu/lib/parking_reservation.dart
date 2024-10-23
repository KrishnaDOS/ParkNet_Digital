import 'package:flutter/material.dart';

class ParkingReservation extends StatelessWidget {
  const ParkingReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // Dark background
      appBar: AppBar(
        title: const Text(
          'Parking Reservation',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700], // Dark blue app bar
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildReservationOption(
              context, 
              'Search Nearest Parking Deck', 
              Icons.location_on, 
              Colors.lightBlueAccent, 
              '/nearestParkingDeck'
            ),
            SizedBox(height: 20),
            _buildReservationOption(
              context, 
              'Search Specific Parking Deck', 
              Icons.local_parking, 
              Colors.greenAccent, 
              '/specificParkingDeck'
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationOption(BuildContext context, String title, IconData icon, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navigate to respective route
      },
      child: Card(
        color: Colors.blueGrey[800], // Darker card background
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white, // White text
                  fontSize: 18,
                  fontWeight: FontWeight.w500, // Match the font weight and size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NearestParkingDeckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Nearest Parking Deck',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Nearest parking deck details will be shown here.',
            style: TextStyle(
              fontSize: 18, 
              color: Colors.white, // White text
              fontWeight: FontWeight.w500, // Match the weight and size
            ),
            textAlign: TextAlign.center, // Center-align text
          ),
        ),
      ),
    );
  }
}

class SpecificParkingDeckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Specific Parking Deck',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Specific parking deck search will be implemented here.',
            style: TextStyle(
              fontSize: 18, 
              color: Colors.white, 
              fontWeight: FontWeight.w500, // Match the font weight and size
            ),
            textAlign: TextAlign.center, // Center-align text
          ),
        ),
      ),
    );
  }
}
