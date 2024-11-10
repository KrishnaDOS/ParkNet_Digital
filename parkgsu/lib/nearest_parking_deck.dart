import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'reservation.dart';

class NearestParkingDeckScreen extends StatefulWidget {
  const NearestParkingDeckScreen({super.key});

  @override
  _NearestParkingDeckScreenState createState() =>
      _NearestParkingDeckScreenState();
}

class _NearestParkingDeckScreenState extends State<NearestParkingDeckScreen> {
  String _locationMessage = "Finding nearest parking deck...";
  String _nearestDeckInfo = '';
  LatLng? _currentLocation;
  final MapController _mapController = MapController();
  bool _isLoading = false;
  String _nearestDeckName = '';
  int _openSpots = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          _locationMessage = 'Location permissions are denied.';
        });
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationMessage =
            'Current location: ${position.latitude}, ${position.longitude}';
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      if (_currentLocation != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapController.move(_currentLocation!, 15);
        });
        _findNearestParkingDeck();
      }
    } catch (e) {
      setState(() {
        _locationMessage = 'Failed to get location: $e';
      });
      print("Error fetching location: $e");
    }
  }

  Future<void> _findNearestParkingDeck() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var collection = FirebaseFirestore.instance.collection('parkingDecks');
      var querySnapshot = await collection.get();

      if (querySnapshot.docs.isNotEmpty) {
        var nearestDeck = querySnapshot.docs.first;
        for (var doc in querySnapshot.docs) {
          nearestDeck = doc;
        }

        var deckData = nearestDeck.data();
        int spotCount = deckData['spot_count'] ?? 0;
        int reservedCount = deckData['reserved_count'] ?? 0;
        int openSpots = spotCount - reservedCount;

        setState(() {
          _nearestDeckInfo = 'Parking Deck Name: ${deckData['deck_name']}\n'
              'Total Spots: $spotCount\n'
              'Reserved Spots: $reservedCount\n'
              'Open Spots: $openSpots';
          _nearestDeckName = deckData['deck_name'];
          _openSpots = openSpots;
        });
      } else {
        setState(() {
          _nearestDeckInfo = 'No parking decks available.';
        });
      }
    } catch (e) {
      setState(() {
        _nearestDeckInfo = 'Error fetching data. Please try again.';
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
          'Nearest Parking Deck',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _locationMessage,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                _nearestDeckInfo.isNotEmpty
                    ? _nearestDeckInfo
                    : "Searching for nearest parking deck...",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _currentLocation == null
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: _currentLocation ?? LatLng(0, 0),
                          minZoom: 10.0,
                          maxZoom: 18.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.parkgsu',
                          ),
                          MarkerLayer(
                            markers: [
                              if (_currentLocation != null)
                                Marker(
                                  point: _currentLocation!,
                                  width: 30.0,
                                  height: 30.0,
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _nearestDeckName.isNotEmpty && _openSpots > 0 && !_isLoading
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReserveSpotScreen(
                        selectedDeck: _nearestDeckName,
                      ),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: _openSpots > 0 ? Colors.blueAccent[700] : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Reserve Spot',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
