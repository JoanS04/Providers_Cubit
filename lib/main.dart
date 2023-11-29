import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantilla_login_register/providers/products_provider.dart';
import 'package:plantilla_login_register/providers/products_provider_card.dart';
import 'package:plantilla_login_register/screens/home_screen.dart';
import 'package:plantilla_login_register/screens/login_or_register.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsProvider()),
        BlocProvider(create: (context) => ProductsProviderCard()),
      ],
        child: MyApp(),
      );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => HomeScreen(),
          'logOrReg': (context) => LoginOrRegisterScreen(),
        },
        initialRoute: 'logOrReg');
  }
}
