  
import 'package:plantilla_login_register/models/models.dart';
class DataState{
  List<Products> products = [];
  Map<Products, int> contador = {};
  DataState();

  void setData(List<Products> products){
      this.products = products;
      for (Products prod in products){
      contador[prod] = 1;
      
      }
  }  
}