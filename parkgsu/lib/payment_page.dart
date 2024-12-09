import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:parkgsu/payment_confirmation.dart';

class PaymentPage extends StatefulWidget {
  final double amount;
  final String parkingDeckName;

  const PaymentPage({super.key, required this.amount, required this.parkingDeckName});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardNumberController = TextEditingController();
  final _expDateController = TextEditingController();
  final _cvcController = TextEditingController();
  bool isCreditCard = true;
  String? _cardNumberError;
  String? _expDateError;
  String? _cvcError;

  int loyaltyPoints = 0;
  int pointsToUse = 0;

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_formatCardNumber);
    _expDateController.addListener(_formatExpDate);
    _getLoyaltyPoints();
  }

  Future<void> _getLoyaltyPoints() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            loyaltyPoints = userDoc['loyaltyPoints'] ?? 0;
          });
        }
      } catch (e) {
        print("Error fetching loyalty points: $e");
      }
    }
  }

  double _calculateFinalAmount() {
    if (pointsToUse > loyaltyPoints) {
      pointsToUse = loyaltyPoints;
    }
    double pointsInDollars = pointsToUse * 0.05;
    return widget.amount - pointsInDollars;
  }

  void _formatCardNumber() {
    String text = _cardNumberController.text.replaceAll('-', '');
    if (text.length > 16) {
      text = text.substring(0, 16);
    }
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += '-';
      }
      formatted += text[i];
    }
    _cardNumberController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _formatExpDate() {
    String text = _expDateController.text.replaceAll('/', '');
    if (text.length > 4) {
      text = text.substring(0, 4);
    }
    if (text.length > 2) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }
    _expDateController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  bool _validateForm() {
    final cardNumber = _cardNumberController.text.replaceAll('-', '');
    final expDate = _expDateController.text;
    final year = DateTime.now().year % 100;
    final currentMonth = DateTime.now().month;

    bool isValid = true;

    if (cardNumber.length != 16 || int.tryParse(cardNumber) == null) {
      setState(() {
        _cardNumberError = 'Enter a valid 16-digit card number';
      });
      isValid = false;
    } else {
      setState(() {
        _cardNumberError = null;
      });
    }

    if (expDate.length != 5 || expDate[2] != '/' || int.tryParse(expDate.substring(0, 2)) == null || int.tryParse(expDate.substring(3, 5)) == null) {
      setState(() {
        _expDateError = 'Expiration format: MM/YY';
      });
      isValid = false;
    } else {
      final expMonth = int.parse(expDate.substring(0, 2));
      final expYear = int.parse(expDate.substring(3, 5));

      if (expMonth < 1 || expMonth > 12) {
        setState(() {
          _expDateError = 'Enter a valid expiration month (1-12)';
        });
        isValid = false;
      } else if (expYear < year || (expYear == year && expMonth < currentMonth)) {
        setState(() {
          _expDateError = 'Card expired';
        });
        isValid = false;
      } else {
        setState(() {
          _expDateError = null;
        });
      }
    }

    final cvc = _cvcController.text;
    if (cvc.length != 3 || int.tryParse(cvc) == null) {
      setState(() {
        _cvcError = 'CVC must be 3 digits';
      });
      isValid = false;
    } else {
      setState(() {
        _cvcError = null;
      });
    }

    return isValid;
  }

  Future<void> _storeCardInfoAndNavigate() async {
    final user = FirebaseAuth.instance.currentUser;

    //final int gatePin = Random().nextInt(10000);

    final paymentData = {
      'userId': user?.uid,
      'cardNumber': _cardNumberController.text,
      'expirationDate': _expDateController.text,
      'cvc': _cvcController.text,
      'amount': widget.amount,
      'cardType': isCreditCard ? 'Credit' : 'Debit',
      'parkingDeckName': widget.parkingDeckName,
      //'gatePin': gatePin,
      //'confirmationNumber': Random().nextInt(1000000).toString().padLeft(6, '0'),
      'timestamp': Timestamp.now(),
    };

    try {
      await FirebaseFirestore.instance.collection('payments').add(paymentData);

      if (pointsToUse > loyaltyPoints) {
        setState(() {
          _cardNumberError = 'You do not have enough loyalty points.';
        });
        return;
      }

      final int remainingPoints = loyaltyPoints - pointsToUse;
      final int updatedPoints = remainingPoints + 10;

      await _updateLoyaltyPoints(updatedPoints);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentConfirmation(parkingDeckName: widget.parkingDeckName),
        ),
      );
    } catch (e) {
      print("Error storing payment information: $e");
      setState(() {
        _cardNumberError = 'Error processing payment. Please try again.';
      });
    }
  }

  Future<void> _updateLoyaltyPoints(int newPoints) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'loyaltyPoints': newPoints,
        });
      } catch (e) {
        print("Error updating loyalty points: $e");
      }
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Text('Continue with payment of \$${_calculateFinalAmount().toStringAsFixed(2)}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _storeCardInfoAndNavigate();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Payment Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _cardNumberController,
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "1234-5678-9012-3456",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.blueGrey[800],
                errorText: _cardNumberError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expDateController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "MM/YY",
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.blueGrey[800],
                      errorText: _expDateError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _cvcController,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "CVC",
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.blueGrey[800],
                      errorText: _cvcError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Loyalty Points Available: $loyaltyPoints',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  pointsToUse = int.tryParse(value) ?? 0;
                });
              },
              enabled: loyaltyPoints > 0,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter points to use",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.blueGrey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_validateForm()) {
                  _showConfirmationDialog();
                }
              },
              child: Text(
                'Pay \$${_calculateFinalAmount().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
