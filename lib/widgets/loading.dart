import 'package:flutter/material.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.white,
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }
}