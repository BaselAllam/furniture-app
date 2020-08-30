import 'package:cls/widgets/item.dart';
import 'package:flutter/material.dart';


class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

List itemImage = [
  'assets/home.jpg', 'assets/chair.jpg', 'assets/lamp.jpg', 'assets/office.jpg',
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Whishlist',
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
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.55,
            crossAxisSpacing: 10.0
          ),
          scrollDirection: Axis.vertical,
          itemCount: itemImage.length,
          itemBuilder: (context, index){
            return Item('itemTitle', 'itemDescription', 20, 'whisList');
          },
        ),
      ),
    );
  }
}