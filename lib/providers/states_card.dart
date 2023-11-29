import 'package:plantilla_login_register/models/card_item.dart';
import 'package:plantilla_login_register/models/products.dart';

class DataStateCard {
  List<Products> products = [];
  List<CartItem> cart = [];

  DataStateCard();

  void setData(List<Products> products, List<CartItem> cart) {
    this.products = products;
    this.cart = cart;
  }
}