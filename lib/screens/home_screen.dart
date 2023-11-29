import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantilla_login_register/models/products.dart';
import 'package:plantilla_login_register/providers/products_provider.dart';
import 'package:plantilla_login_register/providers/products_provider_card.dart';
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
      body: BlocProvider(
        create: (context) => ProductsProvider(),
        child: HomeScreenWidgets(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsProvider(),
      child: HomeScreenWidgets(),
    );
  }
}

class HomeScreenWidgets extends StatefulWidget {
  @override
  _HomeScreenWidgetsState createState() => _HomeScreenWidgetsState();
}

class _HomeScreenWidgetsState extends State<HomeScreenWidgets> {
  @override
  Widget build(BuildContext context) {
    final productsCubit = BlocProvider.of<ProductsProvider>(context);
    final productsCart = BlocProvider.of<ProductsProviderCard>(context);
    productsCubit.fetchData();
    return Row(
      children: [
        BlocBuilder<ProductsProvider, DataState>(
          builder: (context, state) {
            return Column(
              children: [
                for (int i = 0; i < ((state.products.length > 0) ? 3 : 0); i++)
                  _cardArticle(state.products[i], productsCart, context),
              ],
            );
          },
        ),
        Expanded(child: SizedBox()),
        BlocBuilder<ProductsProvider, DataState>(
          builder: (context, state) {
            return Column(
              children: [
                _cardCarts(productsCart, context),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _cardArticle(Products p, ProductsProviderCard productsCart, BuildContext context) {
    final targeta = Column(
      children: [
        FadeInImage(
          placeholder: NetworkImage('https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg'),
          image: NetworkImage(p.image),
          fadeInDuration: Duration(milliseconds: 100),
          width: MediaQuery.of(context).size.width * 0.25,
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  productsCart.removeFromCart(p);
                })
              },
              child: const Icon(Icons.remove),
            ),
            const Expanded(child: SizedBox()),
            Text("${p.price}€"),
            const Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  productsCart.addToCart(p);
                })
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.height * 0.25,
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

  Widget _cardCarts(ProductsProviderCard providerCart, BuildContext context) {
  final cartItems = providerCart.state.cart;
  double totalPrice = 0.0;

  for (final cartItem in cartItems) {
    totalPrice += cartItem.product.price * cartItem.quantity;
  }

  return Container(
    width: MediaQuery.of(context).size.width * 0.4,
    height: MediaQuery.of(context).size.height * 0.3,
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
      borderRadius: BorderRadius.circular(10.0),
      child: Column(
        children: [
          Text(
            'Total: ${totalPrice.toStringAsFixed(2)} €',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          cartItem.product.image,
                          width: 50, // Ajusta el ancho de la imagen según tus necesidades
                          height: 50, // Ajusta la altura de la imagen según tus necesidades
                          fit: BoxFit.cover, // Ajusta la forma en que la imagen se adapta al espacio disponible
                        ),
                        SizedBox(width: 10), // Espacio entre la imagen y el texto
                        Text(
                          'x ${cartItem.quantity} - ${cartItem.product.price * cartItem.quantity} €',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Espacio entre elementos
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}