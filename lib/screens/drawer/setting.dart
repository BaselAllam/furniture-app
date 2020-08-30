import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
              ),
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ListTile(
                title: Text(
                  'language',
                  style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)
                ),
                subtitle: Text(
                  language,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal)
                ),
                trailing: PopupMenuButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  icon: Icon(Icons.arrow_downward, color: Colors.black, size: 20.0,),
                  itemBuilder: (BuildContext context){
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        child: Text('English', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                        value: 'English',
                      ),
                      PopupMenuItem(
                        child: Text('Arabic', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                        value: 'Arabic',
                      ),
                    ];
                  },
                  onSelected: (value) {
                    setState(() {
                      language = value;
                    });
                  },
                ),
              ),
            ),
            FlatButton(
              child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
              color: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () async {
                SharedPreferences user = await SharedPreferences.getInstance();
                user.clear();
                //exit(0);
              }
            ),
          ],
        ),
      ),
    );
  }
}