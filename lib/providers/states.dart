  
import 'package:plantilla_login_register/models/products.dart';
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

 /*  void setContador(Products p, int num){
    contador[p] = num;
    print(contador[p]);
  } */

  
}