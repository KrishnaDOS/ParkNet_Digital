import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DirectionsScreen extends StatefulWidget {
  final String selectedDeck;

  const DirectionsScreen({super.key, required this.selectedDeck});

  @override
  _DirectionsScreenState createState() => _DirectionsScreenState();
}

class _DirectionsScreenState extends State<DirectionsScreen> {
  
  String? latitude;
  String? longitude;

  
  Future<void> getDataBasedOnFieldValue() async {
    var collection = FirebaseFirestore.instance.collection('parkingDecks');
    QuerySnapshot querySnapshot = await collection.where('deck_name', isEqualTo: widget.selectedDeck).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;

      setState(() {
        latitude = docSnapshot['latitude'].toString();
        longitude = docSnapshot['longitude'].toString();
      });

      
      if (latitude != null && longitude != null) {
        String url = 'https://www.google.com/maps/dir/?api=1&origin=&destination=$latitude,+$longitude';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: url),
          ),
        );
      }
    } else {
      print('No document found with deck_name: ${widget.selectedDeck}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directions Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: getDataBasedOnFieldValue,
          child: Text('Show Directions'),
        ),
      ),
    );
  }
}


class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebView')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
