import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientProfile{

  String name;
  int age;
  String status;
  String occupation;
  String district;
  String imageUrl;
  String matchPercentage;

  ClientProfile(
      {
        required this.name,
        required this.age,
        required this.status,
        required this.occupation,
        required this.district,
        required this.imageUrl,
        required this.matchPercentage
      }
      );
}