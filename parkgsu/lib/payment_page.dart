import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class PaymentPage extends StatefulWidget {
  final double amount;
  final String parkingDeckName;

  const PaymentPage(
      {super.key, required this.amount, required this.parkingDeckName});

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

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_formatCardNumber);
    _expDateController.addListener(_formatExpDate);
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

    // Validate Card Number
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

    // Validate Expiration Date
    if (expDate.length != 5 ||
        expDate[2] != '/' ||
        int.tryParse(expDate.substring(0, 2)) == null ||
        int.tryParse(expDate.substring(3, 5)) == null) {
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
      } else if (expYear < year ||
          (expYear == year && expMonth < currentMonth)) {
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

    // Validate CVC
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

    // Generate a random gate pin
    final int gatePin = Random().nextInt(10000);

    final paymentData = {
      'userId': user?.uid,
      'cardNumber': _cardNumberController.text,
      'expirationDate': _expDateController.text,
      'cvc': _cvcController.text,
      'amount': widget.amount,
      'cardType': isCreditCard ? 'Credit' : 'Debit',
      'parkingDeckName': widget.parkingDeckName,
      'gatePin': gatePin,
      'timestamp': Timestamp.now(),
    };

    try {
      // Store payment data in Firestore
      await FirebaseFirestore.instance.collection('payments').add(paymentData);

      // After storing payment info, navigate to the PaymentConfirmationPage (optional)
      Navigator.pushNamed(
          context, '/paymentConfirmation'); // Update route if needed
    } catch (e) {
      print("Error storing payment information: $e");
      setState(() {
        _cardNumberError = 'Error processing payment. Please try again.';
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Text(
              'Continue with payment of \$${widget.amount.toStringAsFixed(2)}?'), // Format amount to two decimals
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
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Container(
        color: Colors.blueGrey[700],
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter Payment Details',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '1234-5678-9012-3456',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                fillColor: Colors.white,
                filled: true,
                errorText: _cardNumberError,
                errorStyle: TextStyle(color: Colors.redAccent),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 20, horizontal: 15), // Increased padding
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expDateController,
                    decoration: InputDecoration(
                      labelText: 'Expiration Date (MM/YY)',
                      hintText: 'MM/YY',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      errorText: _expDateError,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15), // Increased padding
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _cvcController,
                    decoration: InputDecoration(
                      labelText: 'CVC',
                      hintText: '123',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      errorText: _cvcError,
                      errorStyle: TextStyle(color: Colors.redAccent),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15), // Increased padding
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 3, // Restrict input to 3 digits
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text(
                      'Credit Card',
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: isCreditCard,
                    backgroundColor: Colors.blueAccent[700],
                    selectedColor: Colors.blueAccent,
                    onSelected: (selected) {
                      setState(() {
                        isCreditCard = true;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    label: Text(
                      'Debit Card',
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: !isCreditCard,
                    backgroundColor: Colors.blueAccent[700],
                    selectedColor: Colors.blueAccent,
                    onSelected: (selected) {
                      setState(() {
                        isCreditCard = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent[700],
              ),
              onPressed: () {
                if (_validateForm()) {
                  _showConfirmationDialog();
                }
              },
              child: Text(
                'Confirm Payment',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
