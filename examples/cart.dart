import 'dart:async';

// Represents an item in the cart
class CartItem {
  final String name;
  final double price;
  int quantity;

  CartItem(this.name, this.price, {this.quantity = 1});
}

class ShoppingCart {
  List<CartItem> items = [];
  
  // Add an item to the cart
  void addItem(String name, double price) {
    var item = CartItem(name, price);
    items.add(item);
    print("Added $name for \$${price}");
  }

  // Calculate total asynchronously
  Future<double> calculateTotal() async {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
      await Future.delayed(Duration(milliseconds: 100)); // Simulate delay
    }
    if (total <= 0) {
      throw Exception("Cart is empty or invalid!");
    }
    return total;
  }

  // Process the cart
  Future<void> checkout() async {
    try {
      double total = await calculateTotal();
      print("Checkout complete! Total: \$${total.toStringAsFixed(2)}");
    } on Exception catch (e) {
      print("Checkout failed: $e");
    }
  }
}

void main() async {
  var cart = ShoppingCart();
  cart.addItem("Book", 15.99);
  cart.addItem("Pen", 2.49);
  cart.addItem("Notebook", 5.99);

  await cart.checkout();
}
