import 'package:cls/models/model/product.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



mixin ProductModel on Model{


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _validated;
  bool get validated => _validated;

  List<Product> _allProducts = [];
  List get allProducts => _allProducts;


  addProduct(String productName, String productDescription, double productPrice) async {

    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> product = {
      'productName' : productName,
      'productDescription' : productDescription,
      'productPrice' : productPrice
    };

  final http.Response productResponse = await http.post('https://furniture-a5f3c.firebaseio.com/product.json', body: json.encode(product));
  if(productResponse.statusCode != 200){
    _validated = false;
    notifyListeners();
  }else{
    _validated = true;
    notifyListeners();
  }

  _isLoading = false;
  notifyListeners();
  }


  fetchProduct() async {

    _isLoading = true;
    notifyListeners();

    http.get('https://furniture-a5f3c.firebaseio.com/product.json').then((http.Response response) {
      var decode = json.decode(response.body);
      decode.forEach((key, value){
        final Product newProduct = Product(
        productName : value['productName'],
        productDescription: value['productDescription'],
        productPrice: value['productPrice'],
      );
      _allProducts.add(newProduct);
      _isLoading = false;
      notifyListeners();
      });
    });
  }


}




// get the data from l user
// send this data for backend
// while this data sending show loading spinner