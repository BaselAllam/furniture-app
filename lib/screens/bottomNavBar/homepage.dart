import 'package:cls/models/mainmodel.dart';
import 'package:cls/screens/drawer/about.dart';
import 'package:cls/screens/drawer/contact.dart';
import 'package:cls/screens/drawer/setting.dart';
import 'package:cls/screens/drawer/shoppingcart.dart';
import 'package:cls/screens/drawer/wishlist.dart';
import 'package:cls/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<String> drawerItemTitle = [
  'Wishlist', 'Shopping Cart', 'Sell', 'Setting', 'Contact Us', 'About Us'
];

List<String> drawerItemSubTitle = [
  'see your favourited items', 'Earn Money Now', 'buy now', 'edit your account data', 'need help?', 'know more about us'
];

List<IconData> drawerItemIcon = [
  Icons.favorite, Icons.shopping_basket, Icons.add, Icons.settings, Icons.phone, Icons.info_outline
];

// List drawerScreens = [
//   Wishlist(), ShoppingCart(), Setting(), Contact(), About()
// ];


List drawerScreens = [
  'wishlist', 'shoppingCart', 'sell', 'setting', 'contact', 'about'
];


List itemImage = [
  'assets/home.jpg', 'assets/chair.jpg', 'assets/lamp.jpg', 'assets/office.jpg'
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Welcome!',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        actions: <Widget>[
          Icon(
            Icons.shopping_basket,
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
        child: Container(
          color: Colors.grey[100],
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: drawerItemTitle.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: ListTile(
                    leading: Icon(
                        drawerItemIcon[index],
                        color: Colors.black,
                        size: 20.0,
                      ),
                    trailing: Icon(
                        Icons.navigate_next,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    title: Text(
                        drawerItemTitle[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    subtitle: Text(
                        drawerItemSubTitle[index],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, drawerScreens[index]);
                        //Navigator.push(context, MaterialPageRoute(builder: (_) {return drawerScreens[index];}));
                      },
                  ),
                );
              },
            ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
        child: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model){
            return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                height: 200,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/lamp.jpg'),
                    alignment: Alignment.centerRight
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white10
                    ],
                    begin: Alignment.centerLeft, 
                    end: Alignment.centerRight
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Offer 50%',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Hurry up it\'s \nlimited time offer',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 35.0
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Text(
                      'Best Sellers',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                trailing: Text(
                      'See More',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 15.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {return Result('Best Sellers', model);}));
                    },
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                margin: EdgeInsets.only(bottom: 10.0),
                child: item(false)
              ),
              ListTile(
                leading: Text(
                      'Hands-picks',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                trailing: Text(
                      'See More',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 15.0, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {return Result('Hands-picks', model);}));
                    },
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                margin: EdgeInsets.only(bottom: 10.0),
                child: item(true)
              ),
            ],
          );
          },
        ),
      ),
    );
  }
  item(bool x) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      reverse: x,
      itemCount: itemImage.length,
      itemBuilder: (context, index){
        return Container(
          width: MediaQuery.of(context).size.width/2,
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: AssetImage(itemImage[index]),
              fit: BoxFit.fill
            ),
          ),
        );
      },
    );
  }  
}