import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'registration.dart';
import 'login.dart';
import 'dashboard.dart';
import 'parking_reservation.dart';
import 'nearest_parking_deck.dart';
import 'specific_parking_deck.dart';
import 'reservation.dart';
import 'payment_page.dart';
import 'payment_confirmation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          final String selectedDeck =
              ModalRoute.of(context)!.settings.arguments as String? ?? 'Unknown Deck';
          return ReserveSpotScreen(selectedDeck: selectedDeck);
        },
        '/payment': (context) {
          final double amount = ModalRoute.of(context)!.settings.arguments as double? ?? 0.0;
          return PaymentPage(amount: amount);
        },
        '/confirmation': (context) {
          final String qrData = ModalRoute.of(context)!.settings.arguments as String? ?? 'No QR Data';
          return PaymentConfirmationPage(qrData: qrData);
        },
      },
    );
  }
}
