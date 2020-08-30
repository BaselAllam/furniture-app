import 'package:cls/screens/bottomNavBar/bottomnavbar.dart';
import 'package:cls/screens/sign.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';



class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {

String email;

checkUser() async {
  SharedPreferences user = await SharedPreferences.getInstance();
  setState(() {
    email = user.getString('email');
  });
}

@override
void initState(){
  checkUser();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SplashScreen(
        seconds: 4,
        backgroundColor: Colors.grey[100],
        image: Image.asset('assets/lamp.jpg'),
        loaderColor: Colors.black,
        navigateAfterSeconds: email == null ? Sign() : BottomNavBar()
      ),
    );
  }
}