import 'package:plantilla_login_register/models/card_item.dart';
import 'package:plantilla_login_register/models/login.dart';
import 'package:plantilla_login_register/models/products.dart';

class DataStateLogin {
  String usuario = "";


  DataStateLogin();
}

class CorrectLoginDataState extends DataStateLogin{
  final String username;

  CorrectLoginDataState(this.username);
}



class ErrorDataState extends DataStateLogin{
  final String error;

  ErrorDataState(this.error);
}