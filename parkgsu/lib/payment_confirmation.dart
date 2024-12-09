import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentConfirmation extends StatelessWidget {
  final String parkingDeckName;

  // Generate random confirmation number and gate PIN once as final variables
  final String confirmationNumber =
      Random().nextInt(1000000).toString().padLeft(6, '0');
  final String gatePin = Random().nextInt(10000).toString().padLeft(4, '0');

  PaymentConfirmation({super.key, required this.parkingDeckName});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    final currentDateTime = DateTime.now();
    final formattedDate = DateFormat('MMMM d, yyyy').format(currentDateTime);
    final formattedTime =
        DateFormat('hh:mm a z').format(currentDateTime); // 12-hour clock with time zone

    // Save data to Firestore
    void saveConfirmationToFirestore() async {
      try {
        await FirebaseFirestore.instance.collection('reservations').add({
          'confirmationNumber': confirmationNumber,
          'parkingDeckName': parkingDeckName,
          'gatePin': gatePin,
          'date': formattedDate,
          'time': formattedTime,
          'timestamp': currentDateTime, // For sorting/filtering purposes
        });
        print('Reservation saved successfully.');
      } catch (e) {
        print('Error saving reservation: $e');
      }
    }

    // Save the data when the widget is displayed for the first time
    saveConfirmationToFirestore();

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Payment Confirmation',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align from the top
        children: [
          SizedBox(height: 225), // Increased gap here after the header

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Payment Successful!',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                SizedBox(height: 20),

                // Parking Deck Name
                Text(
                  'Parking Deck: $parkingDeckName',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 10),

                // Gate PIN
                Text(
                  'Gate PIN: $gatePin',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 10),

                // Confirmation Number
                Text(
                  'Confirmation Number: $confirmationNumber',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 10),

                // Date
                Text(
                  'Date: $formattedDate',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 10),

                // Time
                Text(
                  'Time: $formattedTime',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          Spacer(),

          // Go to Dashboard button spanning full width
          Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/dashboard', (route) => false);
              },
              child: const Text(
                'Go to Dashboard',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
