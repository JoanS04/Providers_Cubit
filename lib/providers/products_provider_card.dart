
import 'package:plantilla_login_register/models/models.dart';
import 'package:plantilla_login_register/providers/providers.dart';
import 'package:plantilla_login_register/states/states.dart';



class ProductsProviderCard extends Cubit<DataStateCard> {
  List<CartItem> cart = [];
  List<Products> products = [];
  ProductsProviderCard() : super(DataStateCard());


void addToCart(Products product) {
  // Check if product already exists in cart
  for (final cartItem in this.cart) {
    if (cartItem.product.image == product.image) {
      // Increment quantity of existing item
      cartItem.quantity++;
      return; // Exit the loop since the product is already in the cart
    }
  }

  // Add new cart item
  cart.add(CartItem(product: product, quantity: 1));

  // Update state with updated cart
  emit(DataStateCard()
    ..products = products // Assign updated products list
    ..cart = cart); // Assign updated cart list
}

void removeFromCart(Products product) {
  // Check if product already exists in cart
  for (final cartItem in this.cart) {
    if (cartItem.product.image == product.image) {
      // Check if quantity is 1, remove item
      if (cartItem.quantity == 1) {
        cart.remove(cartItem);
      } else {
        // Decrement quantity of existing item
        cartItem.quantity--;
      }

      // Update state with updated cart
      emit(DataStateCard()
        ..products = products // Assign updated products list
        ..cart = cart); // Assign updated cart list
      return; // Exit the loop since the product is already in the cart
    }
  }
}
}