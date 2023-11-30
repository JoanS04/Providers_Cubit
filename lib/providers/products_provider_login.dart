import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:plantilla_login_register/models/card_item.dart';
import 'package:plantilla_login_register/models/login.dart';
import 'package:plantilla_login_register/models/products.dart';
import 'dart:convert';
import 'dart:convert' as convert;

import 'package:plantilla_login_register/providers/states_card.dart';
import 'package:plantilla_login_register/providers/states_login.dart';

class ProductsProviderLogin extends Cubit<DataStateLogin> {
  List<Login> login = [];
  ProductsProviderLogin() : super(DataStateLogin());

  void loginAtemt(Login login) {
      if(login.username == "hola@gmail.com" && login.password == "123456"){
        emit(CorrectLoginDataState(login.username));
        print("INICIO SESION CORRETO");
        print(login.username);
      }else {
        print("FALLO INICIO SESION");
        emit(ErrorDataState("FALLO INICIO DE SESSION"));
        print(login.username);
      }
    
  // Check if product already exists in car
}
}