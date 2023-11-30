import 'package:plantilla_login_register/providers/providers.dart';
import 'package:plantilla_login_register/models/models.dart';
import 'package:plantilla_login_register/states/states.dart';
class ProductsProviderLogin extends Cubit<DataStateLogin> {
  List<Login> login = [];
  ProductsProviderLogin() : super(DataStateLogin());

  void loginAtemt(Login login) {
      if(login.username == "hola@gmail.com" && login.password == "123456"){
        emit(CorrectLoginDataState(login.username));
      }else {
        emit(ErrorDataState("FALLO INICIO DE SESSION"));
      }
    
  // Check if product already exists in car
}
}