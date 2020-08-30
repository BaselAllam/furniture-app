import 'package:cls/screens/bottomNavBar/account.dart';
import 'package:cls/screens/bottomNavBar/homepage.dart';
import 'package:cls/screens/bottomNavBar/search.dart';
import 'package:cls/screens/details.dart';
import 'package:cls/screens/drawer/about.dart';
import 'package:cls/screens/drawer/contact.dart';
import 'package:cls/screens/drawer/sell.dart';
import 'package:cls/screens/drawer/setting.dart';
import 'package:cls/screens/drawer/shoppingcart.dart';
import 'package:cls/screens/drawer/wishlist.dart';
import 'package:cls/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/mainmodel.dart';



void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreens(),
        routes: {
          'account' : (context) => Account(),
          'homepage' : (context) => HomePage(),
          'search' : (context) => Search(),
          'about' : (context) => About(),
          'contact' : (context) => Contact(),
          'setting' : (context) => Setting(),
          'shoppingCart' : (context) => ShoppingCart(),
          'wishlist' : (context) => Wishlist(),
          'details' : (context) => Details(),
          'sell' : (context) => Sell(),
        },
      ),
    );
  }
}


//AIzaSyAo-yvGw29MCV1cXuR089OxiHzjLjVXaW0