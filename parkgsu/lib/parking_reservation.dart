import 'package:flutter/material.dart';

class ParkingReservation extends StatelessWidget {
  const ParkingReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
          title: const Text(
            'Parking Reservation',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[700],
          elevation: 4,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
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
              '/nearestParkingDeck',
            ),
            SizedBox(height: 20),
            _buildReservationOption(
              context,
              'Search Specific Parking Deck',
              Icons.domain,
              Colors.greenAccent,
              '/specificParkingDeck',
            ),
            SizedBox(height: 20),
            Text(
              'Choose an option to reserve parking.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationOption(BuildContext context, String title,
      IconData icon, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: Colors.blueGrey[800],
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
