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

  void suma(Products p){
    int num = (contador[p]!);
    contador[p] = num++;
  }
}