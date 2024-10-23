import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Events'),
      ),
      body: Center(
        child: Text(
          'Here you can find local events!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
