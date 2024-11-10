import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentConfirmationPage extends StatelessWidget {
  final String qrData;

  const PaymentConfirmationPage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reservation Confirmed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Replace QrImage with QrImageView
            QrImageView(
              data: qrData, // Data for the QR code
              version: QrVersions.auto,
              size: 200.0,
              foregroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}