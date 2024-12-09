import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer_support.dart';
import 'events.dart';
import 'my_reservations.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'ParkGSU Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Start from the top
          children: [
            // Loyalty Points Text Field at the top
            _buildLoyaltyPointsDisplay(context),
            SizedBox(height: 2.5),

            _buildDashboardItem(context, 'My Reservations',
                Icons.history, Colors.orangeAccent, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyReservationsPage()),
              );
            }),
            SizedBox(height: 20),
            _buildDashboardItem(context, 'Parking Reservation',
                Icons.local_parking, Colors.lightBlueAccent, () {
              Navigator.pushNamed(context, '/parkingReservation');
            }),
            SizedBox(height: 20),
            _buildDashboardItem(context, 'Local Event Finder',
                Icons.event, Colors.greenAccent, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventsPage()),
              );
            }),
            SizedBox(height: 20),
            _buildDashboardItem(context, 'Customer Support',
                Icons.support_agent, Colors.redAccent, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerSupportPage()),
              );
            }),
            SizedBox(height: 20),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  // Loyalty Points display method
  Widget _buildLoyaltyPointsDisplay(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text(
            'Loyalty Points: 0',
            style: TextStyle(color: Colors.white, fontSize: 18),
          );
        }

        final loyaltyPoints = snapshot.data!['loyaltyPoints'] ?? 0;

        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'My Loyalty Points: $loyaltyPoints',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[200],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboardItem(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(
              context, '/'); // Redirect to login or home screen
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error logging out: $e')),
          );
        }
      },
      child: Card(
        color: Colors.redAccent,
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
