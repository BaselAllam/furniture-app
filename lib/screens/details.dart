import 'package:flutter/material.dart';




class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

List itemImage = [
  'assets/home.jpg', 'assets/chair.jpg', 'assets/lamp.jpg', 'assets/office.jpg'
];

int quantity = 0;

bool fav = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/2.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: itemImage.length,
                      itemBuilder: (context, index){
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(itemImage[index]),
                              fit: BoxFit.fill
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  item('Lamp' , 'Lamp made of wood, with high quality and can be broken faster than you thing don\'t buy it forom this buyer'),
                  ListTile(
                    title: Text(
                        'Colors',
                        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
                      ),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                         children: [
                           IconButton(
                             icon: Icon(Icons.color_lens),
                             color: Colors.red,
                             iconSize: 20.0,
                             onPressed: () {}
                           ),
                           IconButton(
                             icon: Icon(Icons.color_lens),
                             color: Colors.blue,
                             iconSize: 20.0,
                             onPressed: () {}
                           ),
                            IconButton(
                             icon: Icon(Icons.color_lens),
                             color: Colors.brown,
                             iconSize: 20.0,
                             onPressed: () {}
                           ),
                         ], 
                        ),
                  ),
                  ListTile(
                    title: Text(
                        'Quantity',
                        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
                      ),
                      trailing: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                         children: [
                           IconButton(
                             icon: Icon(Icons.remove),
                             color: Colors.grey,
                             iconSize: 15.0,
                             onPressed: () {
                               setState(() {
                                 quantity--;
                               });
                             },
                           ),
                           Text(
                              '${quantity.toString()}',
                              style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold)
                            ),
                            IconButton(
                             icon: Icon(Icons.add),
                             color: Colors.grey,
                             iconSize: 15.0,
                             onPressed: () {
                               setState(() {
                                 quantity++;
                               });
                             },
                           ),
                         ], 
                        ),
                      ),
                  ),
                ],
              ),
            ),
            SafeArea(
              bottom: true,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      position: DecorationPosition.background,
                      child: IconButton(
                          icon: Icon(fav == false ? Icons.favorite_border : Icons.favorite), 
                          color: Colors.white, 
                          iconSize: 20.0,
                          onPressed: () {
                            setState(() {
                              fav = !fav;
                            });
                          },
                        ),
                    ),
                  FlatButton(
                    child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                      ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {}
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  item(String title, String subtitle) {
    return ListTile(
      title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
        ),
      subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold)
        ),
    );
  }
}