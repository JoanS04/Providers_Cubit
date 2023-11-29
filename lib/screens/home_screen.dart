import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantilla_login_register/models/products.dart';
import 'package:plantilla_login_register/providers/products_provider.dart';
import 'package:plantilla_login_register/providers/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final missatge = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inici'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              // TODO: Logout
              Navigator.of(context).pushReplacementNamed('logOrReg');
            },
          )
        ],
      ),
      body: CounterScreen(),
      );
  }

  
  
}
class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsProvider(),
      child: listWidgets(),
    );
  }
}

class listWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsCubit = BlocProvider.of<ProductsProvider>(context);
    productsCubit.fetchData();
    return Row(
      children: [
        BlocBuilder<ProductsProvider, DataState>(
              builder: (context, state) {
                return Column(
                  children: [
                    for (int i = 0; i < ((state.products.length > 0)? 3 : 0); i++)
                      _cardArticle(state.products[i])
                    // for (Products p in state.products)
                    //   _cardArticle(p)
                  ],
                );
              },
            ),
        // Column(children: [
        //   _cardArticle(),
        //   _cardArticle(),
        // ],),
        Expanded(child: SizedBox()),
        _cardCarts(),
      ],
    );
  }

  Widget _cardArticle(Products p) {
    final targeta = Column(
      children: [
        FadeInImage(
          placeholder: NetworkImage('https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg'),
          image: NetworkImage(p.image),
          fadeInDuration: Duration(milliseconds: 100),
          width: 180,
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            ElevatedButton(onPressed: () => {}, child: const Icon(Icons.remove)),
            const Expanded(child: SizedBox()),
            Text("${p.price}€"),
            const Expanded(child: SizedBox()),
            ElevatedButton(onPressed: () => {}, child: const Icon(Icons.add)),
          ],
        ),
      ],
    );
    return Container(
      width: 200,
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 143, 143, 143).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        child: targeta,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget _cardCarts() {
    final targeta = Row(
      children: [
        const FadeInImage(
          placeholder: NetworkImage('https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg'),
          image: NetworkImage('https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg'),
          fadeInDuration: Duration(milliseconds: 100),
          width: 50,
          fit: BoxFit.cover,
        ),
        Expanded(child: Text("Cantidad preutotal", textAlign: TextAlign.center)),
      ],
    );
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 143, 143, 143).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        child: targeta,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
