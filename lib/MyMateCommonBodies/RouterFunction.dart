import 'package:flutter/material.dart';

NavigatorFunction(BuildContext context,Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>page,));
}