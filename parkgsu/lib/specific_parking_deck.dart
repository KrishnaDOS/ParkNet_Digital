import 'package:flutter/material.dart';
import 'reservation.dart'; // Import the reservation page.
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

class SpecificParkingDeckScreen extends StatefulWidget {
  const SpecificParkingDeckScreen({super.key});

  @override
  _SpecificParkingDeckScreenState createState() =>
      _SpecificParkingDeckScreenState();
}

class _SpecificParkingDeckScreenState extends State<SpecificParkingDeckScreen> {
  String _deckName = '';
  String _deckInfo = '';
  bool _isLoading = false;
  int _openSpots = 0;

  Future<void> _searchParkingDeck() async {
    setState(() {
      _isLoading = true;
      _deckInfo = '';
    });

    var collection = FirebaseFirestore.instance.collection('parkingDecks');

    try {
      var querySnapshot = await collection.get();

      if (querySnapshot.docs.isNotEmpty) {
        var deckData;
        for (var doc in querySnapshot.docs) {
          if ((doc.data()['deck_name'] as String).toLowerCase() ==
              _deckName.toLowerCase()) {
            deckData = doc.data();
            break;
          }
        }

        if (deckData != null) {
          int spotCount = deckData['spot_count'] ?? 0;
          int reservedCount = deckData['reserved_count'] ?? 0;
          int hcapCount = deckData['hcap_spot'] ?? 0;
          int openSpots = spotCount - hcapCount - reservedCount;

          setState(() {
            _deckInfo = 'Parking Deck Name: ${deckData['deck_name']}\n'
                'Total Spots: $spotCount\n'
                'Reserved Spots: $reservedCount\n'
                'Open Spots: $openSpots';
            _openSpots = openSpots;
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

  final List<String> PDecks = [
    //'B Deck',
    //'C Deck',
    //'E Deck',
    'G Deck',
   // 'H Deck',
    'K Deck',
   // 'L Deck',
    'M Deck',
    'N Deck',
    'S Deck',
    'T Deck'
   // 'Z Deck'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Search Specific Parking Deck',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 4,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              DropdownButton(
                hint: Text('Select Parking Deck',
                    style: TextStyle(color: Colors.white)),
                value: _deckName.isEmpty ? null : _deckName,
                items: PDecks.map(
                    (e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) {
                  setState(() {
                    _deckName = value!;
                  });
                },
                dropdownColor: Colors.blueGrey[700],
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _searchParkingDeck,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.blueAccent[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Search',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
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
      ),
      bottomNavigationBar: _deckInfo.isNotEmpty && !_isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _openSpots > 0
                    ? () {
                        // Navigate to the duration selection page instead of payment
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReserveSpotScreen(
                              selectedDeck:
                                  _deckName, // Passing deck name to the duration page
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor:
                      _openSpots > 0 ? Colors.blueAccent[700] : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Reserve Spot',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          : null,
    );
  }
}
