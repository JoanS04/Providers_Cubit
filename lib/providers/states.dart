  
import 'package:plantilla_login_register/models/products.dart';
class DataState{
  List<Products> products = [];
  DataState();

  void setData(List<Products> products){
      this.products = products;
  }

  
}