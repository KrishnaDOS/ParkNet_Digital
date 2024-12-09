import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyReservationsPage extends StatelessWidget {
  const MyReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'My Reservations',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reservations')
            .orderBy('timestamp', descending: true) // Order by timestamp
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No reservations found.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          final reservations = snapshot.data!.docs;

          // Separate current and past reservations
          final now = DateTime.now();
          final currentReservations = reservations.where((doc) {
            final timestamp = (doc['timestamp'] as Timestamp).toDate();
            return timestamp.isAfter(now);
          }).toList();

          final pastReservations = reservations.where((doc) {
            final timestamp = (doc['timestamp'] as Timestamp).toDate();
            return timestamp.isBefore(now);
          }).toList();

          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              _buildSectionTitle('My Current Reservations'),
              ...currentReservations.map((doc) => _buildReservationCard(doc)),
              SizedBox(height: 20),
              _buildSectionTitle('Past Reservations'),
              ...pastReservations.map((doc) => _buildReservationCard(doc)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildReservationCard(QueryDocumentSnapshot doc) {
    return Card(
      color: Colors.blueGrey[800],
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          'Parking Deck: ${doc['parkingDeckName']}',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirmation: ${doc['confirmationNumber']}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Gate PIN: ${doc['gatePin']}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Date: ${doc['date']}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Time: ${doc['time']}',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}