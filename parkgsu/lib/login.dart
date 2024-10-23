import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Replace the current route with the dashboard, preventing back navigation
        Navigator.pushReplacementNamed(context, '/dashboard');
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
          'Login',
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
                  labelText: 'Email or Username',
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
                    value!.isEmpty ? 'Enter your email or username' : null,
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
                validator: (value) =>
                    value!.isEmpty ? 'Enter your password' : null,
                style: TextStyle(color: Colors.white), // White text
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent, // Use 'backgroundColor' instead of 'primary'
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Create an Account',
                  style: TextStyle(color: Colors.white), // White text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
