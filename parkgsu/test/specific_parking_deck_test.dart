import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:parkgsu/specific_parking_deck.dart'; // Update with actual import

// Import the generated mocks file
import 'specific_parking_deck_screen_test.mocks.dart'; // Automatically generated mocks file

// Annotate the classes that you want to mock
@GenerateMocks([FirebaseFirestore, CollectionReference, QuerySnapshot, QueryDocumentSnapshot])
void main() {
  group('SpecificParkingDeckScreen Tests', () {

    testWidgets('Test: Search for valid parking deck', (WidgetTester tester) async {
      // Arrange: Create the mock objects
      var mockDoc = MockQueryDocumentSnapshot();
      var mockCollection = MockCollectionReference<Map<String, dynamic>>();  // Correct the type
      var mockQuerySnapshot = MockQuerySnapshot();

      // Mock `get()` to return a Future of mockQuerySnapshot
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);

      // Mock the `docs` property to return a list with a single mock document
      when(mockQuerySnapshot.docs).thenReturn([mockDoc]);

      // Mock the data of the document
      when(mockDoc.data()).thenReturn({
        'deck_name': 'G Deck',
        'spot_count': 100,
        'reserved_count': 20,
        'hcap_spot': 5,
      });

      // Mock Firestore collection call to return the mocked collection
      var mockFirebaseFirestore = MockFirebaseFirestore();
      when(mockFirebaseFirestore.collection('parkingDecks')).thenReturn(mockCollection);

      // Act: Run the widget inside a MaterialApp and simulate user interactions
      await tester.pumpWidget(MaterialApp(
        home: SpecificParkingDeckScreen(),
      ));

      // Simulate selecting a deck and pressing the search button
      await tester.tap(find.text('Select Parking Deck'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('G Deck'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      // Assert: Verify the UI shows the correct data
      expect(find.text('Parking Deck Name: G Deck'), findsOneWidget);
      expect(find.text('Total Spots: 100'), findsOneWidget);
      expect(find.text('Reserved Spots: 20'), findsOneWidget);
      expect(find.text('Open Spots: 75'), findsOneWidget);
    });
  });
}