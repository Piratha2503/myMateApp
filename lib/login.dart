import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymateapp/Homepages/SubscribedhomeScreen/SubscribedHomeScreenStructured.dart';
import 'package:mymateapp/MyMateThemes.dart';
import 'package:mymateapp/dbConnection/Firebase_DB.dart';

class Login extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  Login({required this.onLoginSuccess});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _allowedPhone = '';
  String _allowedPassword = '';
  FirebaseDB firebaseDB = FirebaseDB();

  Future<void> _login() async{
    DocumentSnapshot documentSnapshot = await firebaseDB.getClientByMobile(_phoneController.text);
    setState(() {
      _allowedPhone = documentSnapshot['contactInfo']['mobile'] ?? 'N/A';
      _allowedPassword = documentSnapshot['contactInfo']['password'] ?? 'N/A';
    });
    if (_formKey.currentState!.validate()) {
      if (_phoneController.text == documentSnapshot['contactInfo']['mobile'] &&
          _passwordController.text == documentSnapshot['contactInfo']['password']) {
        //print(_phoneController.text);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscribedhomescreenStructuredPage()));
      } else {
        print("Wrong Password");
        print(_passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid phone number or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyMateThemes.secondaryColor, MyMateThemes.secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 80),
            Text(
              'Welcome Back',
              style: TextStyle(
                color: MyMateThemes.primaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Login to your account',
              style: TextStyle(
                color: MyMateThemes.textColor,
                fontSize: 16,

              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          prefixIcon: Icon(Icons.phone, color: MyMateThemes.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: MyMateThemes.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: MyMateThemes.primaryColor,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
