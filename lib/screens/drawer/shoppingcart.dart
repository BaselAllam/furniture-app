import 'package:cls/widgets/item.dart';
import 'package:cls/widgets/searchmap.dart';
import 'package:flutter/material.dart';


class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

List itemImage = [
  'assets/home.jpg', 'assets/chair.jpg', 'assets/lamp.jpg', 'assets/office.jpg'
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {return SearchMap();}));
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: itemImage.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(itemImage[index]),
                      title: Text(
                        'Lamp',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Icon(Icons.delete, color: Colors.grey, size: 20.0),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              bottom: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  title: Text(
                    'Total Amount is 200\$',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    '3 Items',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  trailing: Icon(Icons.shopping_basket, color: Colors.white, size: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}