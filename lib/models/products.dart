import 'package:plantilla_login_register/models/models.dart';

class Products {
  String image;
  int price;

  Products({
    required this.image,
    required this.price,
  });

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        image: json["image"],
        price: json["price"],
      );
}
