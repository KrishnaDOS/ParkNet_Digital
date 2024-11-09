import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'registration.dart';
import 'login.dart';
import 'dashboard.dart';
import 'parking_reservation.dart';
import 'nearest_parking_deck.dart';
import 'specific_parking_deck.dart';
import 'reservation.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/dashboard': (context) => Dashboard(),
        '/parkingReservation': (context) => ParkingReservation(),
        '/nearestParkingDeck': (context) => NearestParkingDeckScreen(),
        '/specificParkingDeck': (context) => SpecificParkingDeckScreen(),
        '/reserveSpot': (context) {
          // Ensure selectedDeck is passed when navigating
          final String selectedDeck =
              ModalRoute.of(context)!.settings.arguments as String? ??
                  'Unknown Deck';
          return ReserveSpotScreen(
            selectedDeck: selectedDeck, // Pass selectedDeck here
          );
        },
      },
    );
  }
}
