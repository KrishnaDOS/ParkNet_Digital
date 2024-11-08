import 'dart:math';

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
      var querySnapshot = await collection.get();

      if (querySnapshot.docs.isNotEmpty) {
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

  final List<String> PDecks = [
    'B Deck',
    'C Deck',
    'E Deck',
    'G Deck',
    'H Deck',
    'K Deck',
    'L Deck',
    'M Deck',
    'N Deck',
    'R Deck',
    'S Deck',
    'T Deck',
    'U Deck',
    'V Deck',
    'Z Deck',
  ];

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
      body: Center(
        child: SingleChildScrollView(
        //padding: const EdgeInsets.all(55.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            DropdownButton(
              //isDense: true,
              hint: Text('Select Parking Deck', style: TextStyle(color: Colors.white)),
              value: _deckName.isEmpty ? null : _deckName,
              items: PDecks.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Get Info', style: TextStyle(fontSize: 18)),
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
    ));
  }
}