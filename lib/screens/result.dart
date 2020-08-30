import 'package:cls/models/mainmodel.dart';
import 'package:cls/responsive/responsivegridview.dart';
import 'package:cls/widgets/item.dart';
import 'package:cls/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



class Result extends StatefulWidget {

final String className;
final MainModel model;

Result(this.className, this.model);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

List itemImage = [
  'assets/home.jpg', 'assets/chair.jpg', 'assets/lamp.jpg', 'assets/office.jpg', 'assets/home.jpg', 'assets/chair.jpg', 'assets/lamp.jpg', 'assets/office.jpg'
];

String filter = 'None';


@override
void initState(){
widget.model.fetchProduct();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        elevation: 0.0,
        title: Text(
          widget.className,
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          child: ListTile(
            leading: Text(
                '${itemImage.length} items - $filter',
                style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            trailing: PopupMenuButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              icon: Icon(Icons.filter_list, color: Colors.black, size: 20.0,),
              itemBuilder: (BuildContext context){
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    child: Text('Popular', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    value: 'Popular',
                  ),
                  PopupMenuItem(
                    child: Text('Best Rated', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    value: 'Best Rated',
                  ),
                ];
              },
              onSelected: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          preferredSize: Size(0.0, 40.0)
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel model){
          if(model.isLoading){
            return Center(child: Loading(),);
          }else if(model.allProducts.length < 1){
            return Center(child: Text('no item found'));
          }else{
            return Container(
              margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: responsiveCount(MediaQuery.of(context)),
                  mainAxisSpacing: 10.0,
                  childAspectRatio: responsiveAspect(MediaQuery.of(context)),
                  crossAxisSpacing: 10.0
                ),
                scrollDirection: Axis.vertical,
                itemCount: model.allProducts.length,
                itemBuilder: (context, index){
                  return Item(
                    model.allProducts[index].productName,
                    model.allProducts[index].productDescription,
                    model.allProducts[index].productPrice,
                    'result'
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}