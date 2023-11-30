import 'package:flutter/material.dart';
import 'package:plantilla_login_register/models/products.dart';
import 'package:plantilla_login_register/providers/providers.dart';
import 'package:plantilla_login_register/states/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inici'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
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
      backgroundColor: Colors.black,
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
        const Expanded(child: SizedBox()),
        BlocBuilder<ProductsProvider, DataState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _cardCarts(productsCart, context),
              ],
            );
          },
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _cardArticle(
      Products p, ProductsProviderCard productsCart, BuildContext context) {
    final targeta = Column(
      children: [
        const Expanded(child: SizedBox()),
        FadeInImage(
          placeholder: NetworkImage(
              'https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg'),
          image: NetworkImage(p.image),
          fadeInDuration: Duration(milliseconds: 100),
          width: MediaQuery.of(context).size.width * 0.25,
          fit: BoxFit.cover,
        ),
        const Expanded(child: SizedBox()),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              width: 40,
              height: 30,
              child: ElevatedButton(
                onPressed: () => {
                  setState(() {
                    productsCart.removeFromCart(p);
                  })
                },
                child: const Icon(
                  Icons.remove,
                  size: 10,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Text("${p.price}€"),
            const Expanded(child: SizedBox()),
            Container(
              width: 40,
              height: 30,
              child: ElevatedButton(
                onPressed: () => {
                  setState(() {
                    productsCart.addToCart(p);
                  })
                },
                child: const Icon(
                  Icons.add,
                  size: 10,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        const Expanded(child: SizedBox()),
      ],
    );
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
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
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          children: [
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
                            width: 50,
                            // Ajusta el ancho de la imagen según tus necesidades
                            fit: BoxFit
                                .cover, // Ajusta la forma en que la imagen se adapta al espacio disponible
                          ),
                          Expanded(child: SizedBox()),
                          // Espacio entre la imagen y el texto
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
            Text(
              'Total: ${totalPrice.toStringAsFixed(2)} €',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
