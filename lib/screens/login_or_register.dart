import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantilla_login_register/models/login.dart';
import 'package:plantilla_login_register/providers/products_provider_login.dart';
import 'package:plantilla_login_register/providers/states_login.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  @override
  _LoginOrRegisterScreenState createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  GlobalKey<FormState> _key = GlobalKey();

  bool isLogin = false;
  bool isRegister = false;
  late List<bool> _selectedEvent = [isLogin, isRegister];

  RegExp emailRegExp =
      new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  String? _correu;
  String? _passwd;
  String missatge = '';
  bool _isChecked = false;

  bool _isLoading = false;

  bool _isDisposed = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  void dispose() {
    _isDisposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: AnimatedLogo(animation: animation),
            ),
            if (isLogin || isRegister) loginOrRegisterForm(),
            if (missatge.isNotEmpty) // Mostrar el mensaje si no está vacío
            Text(
              missatge,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 100),
            loginOrRegister()
          ],
        ),
      ),
    );
  }

 Widget loginOrRegister() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          // The botó que està seleccionat esta a true, tots els altres a false
          for (int i = 0; i < _selectedEvent.length; i++) {
            _selectedEvent[i] = i == index;
          }
          if (index == 0) {
            isLogin = true;
            isRegister = false;
          } else {
            isLogin = false;
            isRegister = true;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.blue[800],
      selectedColor: Colors.white,
      fillColor: Colors.blue[200],
      color: Colors.blue[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 120.0,
      ),
      isSelected: _selectedEvent,
      children: events,
    );
  }

  Widget loginOrRegisterForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(isLogin ? 'Inicia sessió' : 'Registra\'t'),
        Container(
          width: 300.0,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: '',
                  validator: (text) {
                    if (text!.length == 0) {
                      return "Correu es obligatori";
                    } else if (!emailRegExp.hasMatch(text)) {
                      return "Format correu incorrecte";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Escrigui el seu correu',
                    labelText: 'Correu',
                    counterText: '',
                    icon:
                        Icon(Icons.email, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _correu = text,
                ),
                TextFormField(
                  initialValue: '',
                  validator: (text) {
                    if (text!.length == 0) {
                      return "Contrasenya és obligatori";
                    } else if (text.length <= 5) {
                      return "Contrasenya mínim de 5 caràcters";
                    } else if (!contRegExp.hasMatch(text)) {
                      return "Contrasenya incorrecte";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Escrigui la contrasenya',
                    labelText: 'Contrasenya',
                    counterText: '',
                    icon: Icon(Icons.lock, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _passwd = text,
                ),
                isLogin
                    ? CheckboxListTile(
                        value: _isChecked,
                        onChanged: (value) {
                          _isChecked = value!;
                          setState(() {});
                        },
                        title: Text('Recorda\'m'),
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                    : SizedBox(height: 56),
                IconButton(
                  onPressed: () => _loginRegisterRequest(),
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                ),
                _isLoading ? CircularProgressIndicator() : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

_loginRegisterRequest() {
  if (_key.currentState!.validate()) {
    _key.currentState!.save();
     if (!_isDisposed) {
      setState(() {
        _isLoading = true;
      });
    } 

    final loginCubit = BlocProvider.of<ProductsProviderLogin>(context);
    final login = Login(username: _correu!, password: _passwd!);
    print(login);
    print(login.username);
    loginCubit.loginAtemt(login);
    // Listen to state changes in the loginCubit
    loginCubit.stream.listen((state) {
      //if (!_isDisposed) {
        print("HOLA");
        if (state is CorrectLoginDataState) {
          print("CORRECTE");
          print(state.usuario);
          print(login.username);
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushReplacementNamed('/', arguments: state.usuario);
        } else if (state is ErrorDataState) {
          setState(() {
            print("INCORRECTE");
            _isLoading = false;
            missatge = state.error;
          });
        }
  
    });
  }
}
    }


class AnimatedLogo extends AnimatedWidget {
  // Maneja los Tween estáticos debido a que estos no cambian.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 100.0);

  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: _sizeTween.evaluate(animation), // Aumenta la altura
        width: _sizeTween.evaluate(animation), // Aumenta el ancho
        child: FlutterLogo(),
      ),
    );
  }
}

const List<Widget> events = <Widget>[
  Text('Inicia sessió'),
  Text('Registra\'t'),
];
