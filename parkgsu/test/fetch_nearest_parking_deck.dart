import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'fetch_nearest_parking_deck.mocks.dart';

@GenerateMocks([GeolocatorPlatform, FirebaseFirestore, QuerySnapshot, QueryDocumentSnapshot])
void main() {
  late MockGeolocatorPlatform mockGeolocator;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockGeolocator = MockGeolocatorPlatform();
    mockFirestore = MockFirebaseFirestore();
  });

  group('Fetch Nearest Parking Deck Tests', () {
    test('Fetch nearest parking deck based on GPS location', () async {
      final mockUserLocation = Position(
        latitude: 33.7490,
        longitude: -84.3880,
        timestamp: DateTime.now(),
        accuracy: 5.0,
        altitude: 10.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 5.0,
        altitudeAccuracy: 3.0,
        headingAccuracy: 0.0,
        isMocked: false,
      );

      when(mockGeolocator.getCurrentPosition()).thenAnswer((_) async => mockUserLocation);

      final mockParkingDecks = [
        {'name': 'Deck A', 'latitude': 33.7500, 'longitude': -84.3870, 'distance': 0.5},
        {'name': 'Deck B', 'latitude': 33.7510, 'longitude': -84.3890, 'distance': 1.0},
        {'name': 'Deck C', 'latitude': 33.7520, 'longitude': -84.3900, 'distance': 2.0},
      ];

      final mockQuerySnapshot = MockQuerySnapshot();
      final mockDocumentSnapshots = mockParkingDecks.map((data) {
        final mockDocument = MockQueryDocumentSnapshot();
        when(mockDocument.data()).thenReturn(data);
        return mockDocument;
      }).toList();

      when(mockQuerySnapshot.docs).thenReturn(mockDocumentSnapshots);
      when(mockFirestore.collection('parking_decks').get())
          .thenAnswer((_) async => mockQuerySnapshot as QuerySnapshot<Map<String, dynamic>>);

      final userLocation = await mockGeolocator.getCurrentPosition();
      final parkingDecks = (await mockFirestore.collection('parking_decks').get()).docs;

      parkingDecks.sort((a, b) {
        final distanceA = (a.data()['latitude'] - userLocation.latitude).abs() +
            (a.data()['longitude'] - userLocation.longitude).abs();
        final distanceB = (b.data()['latitude'] - userLocation.latitude).abs() +
            (b.data()['longitude'] - userLocation.longitude).abs();
        return distanceA.compareTo(distanceB);
      });

      final nearestDeck = parkingDecks.first;

      expect(nearestDeck.data()['name'], 'Deck A');
      expect(nearestDeck.data()['distance'], 0.5);
    });
  });
}
