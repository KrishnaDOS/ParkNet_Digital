import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecificParkingDeckScreen extends StatefulWidget {
  const SpecificParkingDeckScreen({super.key});

  @override
  _SpecificParkingDeckScreenState createState() =>
      _SpecificParkingDeckScreenState();
}

class _SpecificParkingDeckScreenState extends State<SpecificParkingDeckScreen> {
  final TextEditingController _searchController = TextEditingController();
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
          await collection.where('deck_name', isEqualTo: _deckName).get();

      if (querySnapshot.docs.isNotEmpty) {
        var deckData = querySnapshot.docs.first.data();
        var parkingSpotsCollection = collection
            .doc(querySnapshot.docs.first.id)
            .collection('parkingSpots');
        var parkingSpotsSnapshot = await parkingSpotsCollection.get();

        List<String> spotsDetails = [];
        for (var spot in parkingSpotsSnapshot.docs) {
          var spotData = spot.data();
          spotsDetails
              .add('Spot ID: ${spot.id}, Level: ${spotData['level_no']}');
        }

        setState(() {
          _deckInfo = 'Parking Deck Name: ${deckData['deck_name']}\n'
              'Admin ID: ${deckData['admin_id']}\n'
              'Created At: ${deckData['created_at']}\n'
              'Level Count: ${deckData['level_count']}\n'
              'Location ID: ${deckData['location_id']}\n'
              'Spot Count: ${deckData['spot_count']}\n\n'
              'Parking Spots:\n${spotsDetails.join('\n')}';
        });
      } else {
        setState(() {
          _deckInfo = 'No parking deck found with that name.';
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
                backgroundColor:
                    WidgetStateProperty.all(Colors.blueAccent[700]),
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
