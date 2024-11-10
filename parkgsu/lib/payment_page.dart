import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentPage extends StatefulWidget {
  final double amount;

  const PaymentPage({Key? key, required this.amount}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();
  bool _paymentSuccess = false;
  String _errorMessage = '';

  void _processPayment() {
    if (_cardController.text == '4242424242424242' &&
        _expiryController.text == '12/34' &&
        _cvcController.text == '123') {
      setState(() {
        _paymentSuccess = true;
        _errorMessage = '';
      });

      // Navigate to confirmation page with QR data
      Navigator.pushNamed(
        context,
        '/confirmation',
        arguments: 'ReservationID-${DateTime.now().millisecondsSinceEpoch}',
      );
    } else {
      setState(() {
        _errorMessage = 'Incorrect card information. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _paymentSuccess
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment Confirmed!',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Center(
                    // Use QrImageView instead of QrImage
                    child: QrImageView(
                      data: 'Reservation Confirmed',
                      version: QrVersions.auto,
                      size: 200.0,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Text(
                    'Enter card details to pay \$${widget.amount.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _cardController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _expiryController,
                    decoration: InputDecoration(
                      labelText: 'Expiry (MM/YY)',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _cvcController,
                    decoration: InputDecoration(
                      labelText: 'CVC',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _processPayment,
                    child: Text('Submit Payment'),
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}