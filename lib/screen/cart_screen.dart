// lib/screens/cart_screen.dart
import 'package:clothing_order_app/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final items = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart 🛒'),
        backgroundColor: Colors.purple.shade100,
        centerTitle: true,
      ),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final cartItem = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      cartItem.product.images.first,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cartItem.product.name),
                    subtitle: Text(
                      'Rs. ${cartItem.product.price.toStringAsFixed(0)} × ${cartItem.quantity}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => cartProvider.removeFromCart(index),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.purple.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: Rs. ${cartProvider.getTotal().toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },

              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
