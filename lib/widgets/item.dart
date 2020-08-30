import 'package:flutter/material.dart';



class Item extends StatefulWidget {

final String itemTitle;
final String itemDescription;
final double itemPrice;
final String className;

Item(this.itemTitle, this.itemDescription, this.itemPrice, this.className);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

bool fav;

bool shopping;

check() {
  if(widget.className == 'shoppingCart'){
    fav = false;
    shopping = true;
  }else if(widget.className == 'wishList'){
    fav = true;
    shopping = false;
  }else if(widget.className == 'result'){
    fav = false;
    shopping = false;
  }
}

@override
void initState() {
  check();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'details');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Container(
              height: 120.0,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                image: DecorationImage(
                  image: AssetImage('assets/chair.jpg'),
                  fit: BoxFit.fill
                ),
              ),
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 5.0, right: 5.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                position: DecorationPosition.background,
                child: IconButton(
                    icon: Icon(fav == false ? Icons.favorite_border : Icons.favorite), 
                    color: Colors.red, 
                    iconSize: 20.0,
                    onPressed: () {
                      setState(() {
                        fav = !fav;
                      });
                    },
                  ),
              ),
            ),
            ListTile(
              title: Text(
                widget.itemTitle,
                style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.itemDescription,
                style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
            ),
            ListTile(
              leading: Text(
                '${widget.itemPrice.toString()}\$',
                style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart), 
                color: shopping == true ? Colors.black : Colors.grey, 
                iconSize: 20.0,
                onPressed: () {
                  setState(() {
                    shopping = !shopping;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}