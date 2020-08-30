import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        backgroundColor: Colors.transparent,
        title: Text(
          'My Account',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/3.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: image != null ? FileImage(image) : AssetImage('assets/lamp.jpg'),
                      fit: BoxFit.fill
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Colors.black,
                      iconSize: 30.0,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),),
                          builder: (BuildContext context){
                            return Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Choose Destination',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Camera',
                                      style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(Icons.camera, color: Colors.grey, size: 15.0),
                                    onTap: () {
                                      pickImage(ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Gallery',
                                      style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(Icons.photo_album, color: Colors.grey, size: 15.0),
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        );
                      }
                    ),
                ),
              ],
            ),
            item('Email', 'baseljahen@gmail.com', Icons.email),
            item('Password', '*****', Icons.lock),
            item('Gender', 'Male', Icons.person),
            item('Birth Date', '20-aug-2020', Icons.perm_contact_calendar),
          ],
        ),
      ),
    );
  }
  item(String title, String subtitle, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal),
          ),
        trailing: Icon(icon, color: Colors.grey, size: 20.0)
      ),
    );
  }
  pickImage(ImageSource source) async {
    var _image = await ImagePicker.pickImage(source: source);
    setState(() {
      image = _image;
    });
  }
}