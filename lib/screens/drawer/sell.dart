import 'package:cls/models/mainmodel.dart';
import 'package:cls/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';




class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {

final TextEditingController productNameController = TextEditingController();
final TextEditingController productDescriptionController = TextEditingController();
final TextEditingController productPriceController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        elevation: 0.0,
        title: Text(
          'Sell',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            field('Product Name', productNameController, TextInputType.text),
            field('Product Description', productDescriptionController, TextInputType.text),
            field('Product Price', productPriceController, TextInputType.number),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, MainModel model) {
                return FlatButton(
                child: model.isLoading ? Center(child: Loading()) : Text(
                    'Sell',
                    style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
                  ),
                color: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  model.addProduct(productNameController.text, productDescriptionController.text, double.parse(productPriceController.text));
                  if(model.validated == false){
                    Scaffold.of(context).showSnackBar(
                      snackBar('error adding this item', Colors.red)
                    );
                  }else{
                    Scaffold.of(context).showSnackBar(
                      snackBar('item added', Colors.green)
                    );
                  }
                }
              );
              },
            ),
          ],
        )
      ),
    );
  }
  snackBar(String content, Color color){
    return SnackBar(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      content: Text(
        content,
        style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 4),
    );
  }
  field(String label, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5)
          ),
            disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.5)
          ),
            enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5)
          ),
            errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5)
          ),
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5)
          ),
            focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5)
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        keyboardType: type,
        textInputAction: TextInputAction.done,
        controller: controller,
      ),
    );
  }
}