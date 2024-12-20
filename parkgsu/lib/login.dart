import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String emailOrUsername = ''; 
  String password = ''; 

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (emailOrUsername.contains('@')) {
          await _auth.signInWithEmailAndPassword(
            email: emailOrUsername,
            password: password,
          );
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          var userQuery = await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: emailOrUsername)
              .get();

          if (userQuery.docs.isNotEmpty) {
            String userEmail = userQuery.docs.first['email'];
            print('User email found: $userEmail');
            await _auth.signInWithEmailAndPassword(
              email: userEmail,
              password: password,
            );
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            var adminQuery = await FirebaseFirestore.instance
                .collection('admins')
                .where('username', isEqualTo: emailOrUsername)
                .get();

            if (adminQuery.docs.isNotEmpty) {
              String adminEmail = adminQuery.docs.first['email'];
              print('Admin email found: $adminEmail');
              await _auth.signInWithEmailAndPassword(
                email: adminEmail,
                password: password,
              );
              Navigator.pushReplacementNamed(context, '/dashboard');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Username not found')),
              );
              return;
            }
          }
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Authentication failed')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[700],
        elevation: 4,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email or Username',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                  ),
                ),
                onChanged: (value) => emailOrUsername = value,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your email or username' : null,
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
                validator: (value) =>
                    value!.isEmpty ? 'Enter your password' : null,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent[700],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  'Create an Account',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
