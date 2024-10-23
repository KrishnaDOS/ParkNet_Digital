import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // Dark background
      appBar: AppBar(
        title: const Text(
          'Local Events',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700], // Dark blue app bar
        elevation: 4,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Here you can find nearby parking for local events!',
            style: TextStyle(
              fontSize: 18, 
              color: Colors.white, // White text
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center, // Center-align text
          ),
        ),
      ),
    );
  }
}