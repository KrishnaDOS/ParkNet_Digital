import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String username = '';
  String password = '';
  DateTime? dateOfBirth;

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Save additional user info to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'email': email,
          'username': username,
          'created_at': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration successful')));
        Navigator.pushNamed(context, '/');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? 'Error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // Dark background
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700], // Dark blue app bar
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the form
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline when focused
                  ),
                ),
                onChanged: (value) => firstName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your first name' : null,
                style: TextStyle(color: Colors.white), // White text
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline when focused
                  ),
                ),
                onChanged: (value) => lastName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your last name' : null,
                style: TextStyle(color: Colors.white), // White text
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline when focused
                  ),
                ),
                onChanged: (value) => email = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your email' : null,
                style: TextStyle(color: Colors.white), // White text
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline when focused
                  ),
                ),
                onChanged: (value) => username = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a username' : null,
                style: TextStyle(color: Colors.white), // White text
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white), // White label text
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent), // Light blue underline when focused
                  ),
                ),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (value) => value!.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
                style: TextStyle(color: Colors.white), // White text
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ).then((pickedDate) {
                  if (pickedDate != null) {
                    setState(() {
                      dateOfBirth = pickedDate;
                    });
                  }
                }),
                child: Text(
                  dateOfBirth == null
                      ? 'Select Date of Birth'
                      : dateOfBirth!.toLocal().toString().split(' ')[0],
                  style: TextStyle(color: Colors.lightBlueAccent), // Light blue text
                ),
              ),
              ElevatedButton(
                onPressed: registerUser,
                child: const Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent, // Light blue button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
