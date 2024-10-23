import 'package:flutter/material.dart';
import 'events.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // Dark background
      appBar: AppBar(
        title: const Text(
          'ParkGSU Dashboard',
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
            _buildDashboardItem(
              context, 
              'Parking Reservation', 
              Icons.local_parking, 
              Colors.lightBlueAccent, 
              () {
                Navigator.pushNamed(context, '/parkingReservation');
              }
            ),
            SizedBox(height: 20),
            _buildDashboardItem(
              context, 
              'Customer Support', 
              Icons.support_agent, 
              Colors.redAccent, 
              () {
                // Add customer support route or function
              }
            ),
            SizedBox(height: 20),
            _buildDashboardItem(
              context, 
              'Local Event Finder', 
              Icons.event, 
              Colors.greenAccent, 
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventsPage()),
                );
              }
            ),
            SizedBox(height: 30),
            _buildLogoutButton(context), // Logout button at the bottom
          ],
        ),
      ),
    );
  }

  // Updated dashboard item card
  Widget _buildDashboardItem(
      BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated logout button
  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add logout functionality
      },
      child: Card(
        color: Colors.redAccent, // Red background for logout button
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            'Logout',
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
