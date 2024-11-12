import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart'; // Import your login page here

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

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
        // Create user
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Save user details to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'email': email,
          'username': username,
          'created_at': FieldValue.serverTimestamp(),
        });

        // Show success message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration successful')));

        // Navigate to the login screen and clear the back stack
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage()), // Replace with your actual LoginPage widget
          (Route<dynamic> route) => false, // This removes all previous routes
        );
      } on FirebaseAuthException catch (e) {
        // Show error message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? 'Error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
          title: const Text(
            'Register',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[700],
          elevation: 4,
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                ),
                onChanged: (value) => firstName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your first name' : null,
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                ),
                onChanged: (value) => lastName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your last name' : null,
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                ),
                onChanged: (value) => email = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your email' : null,
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                ),
                onChanged: (value) => username = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a username' : null,
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                ),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (value) => value!.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
                style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent[700],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
