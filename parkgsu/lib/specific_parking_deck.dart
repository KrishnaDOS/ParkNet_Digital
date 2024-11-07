import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecificParkingDeckScreen extends StatefulWidget {
  @override
  _SpecificParkingDeckScreenState createState() =>
      _SpecificParkingDeckScreenState();
}

class _SpecificParkingDeckScreenState extends State<SpecificParkingDeckScreen> {
  TextEditingController _searchController = TextEditingController();
  String _deckName = '';
  String _deckInfo = '';
  bool _isLoading = false;

  Future<void> _searchParkingDeck() async {
    setState(() {
      _isLoading = true;
      _deckInfo = '';
    });

    var collection = FirebaseFirestore.instance.collection('parkingDecks');

    try {
      var querySnapshot =
          await collection.get();  // Get all documents first

      if (querySnapshot.docs.isNotEmpty) {
        // Iterate over all documents to perform a case-insensitive search
        var deckData;
        for (var doc in querySnapshot.docs) {
          if ((doc.data()['deck_name'] as String).toLowerCase() == _deckName.toLowerCase()) {
            deckData = doc.data();
            break;
          }
        }

        if (deckData != null) {
          int spotCount = deckData['spot_count'] ?? 0;
          int reservedCount = deckData['reserved_count'] ?? 0;
          int openSpots = spotCount - reservedCount;

          setState(() {
            _deckInfo = 'Parking Deck Name: ${deckData['deck_name']}\n'
                'Total Spots: $spotCount\n'
                'Reserved Spots: $reservedCount\n'
                'Open Spots: $openSpots';
          });
        } else {
          setState(() {
            _deckInfo = 'No parking deck found with that name.';
          });
        }
      } else {
        setState(() {
          _deckInfo = 'No parking decks available.';
        });
      }
    } catch (e) {
      setState(() {
        _deckInfo = 'Error fetching data. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Search Specific Parking Deck',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter parking deck name',
                hintStyle: TextStyle(color: Colors.grey[300]),
                filled: true,
                fillColor: Colors.blueGrey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                _deckName = value.trim();
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _deckName.isNotEmpty && !_isLoading
                  ? _searchParkingDeck
                  : null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent[700]),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              ),
              child: Text(
                _isLoading ? 'Searching...' : 'Search',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _deckInfo,
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
}
