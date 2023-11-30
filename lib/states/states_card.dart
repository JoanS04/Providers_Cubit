import 'package:plantilla_login_register/models/models.dart';


class DataStateCard {
  List<Products> products = [];
  List<CartItem> cart = [];

  DataStateCard();

  void setData(List<Products> products, List<CartItem> cart) {
    this.products = products;
    this.cart = cart;
  }
}