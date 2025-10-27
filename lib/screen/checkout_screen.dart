import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String address = '';
  String phone = '';
  String postalCode = '';
  String paymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Customer Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => name = value!,
              ),
              const SizedBox(height: 10),

              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your email' : null,
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 10),

              // Address
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your address'
                    : null,
                onSaved: (value) => address = value!,
              ),
              const SizedBox(height: 10),

              // Phone
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your number' : null,
                onSaved: (value) => phone = value!,
              ),
              const SizedBox(height: 10),

              // Postal Code
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Postal Code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter postal code' : null,
                onSaved: (value) => postalCode = value!,
              ),
              const SizedBox(height: 20),

              const Text(
                'Payment Method 💳',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // COD Radio Button
              RadioListTile<String>(
                title: const Text('Cash on Delivery (COD)'),
                value: 'Cash on Delivery',
                groupValue: paymentMethod,
                activeColor: Colors.purple,
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Clear the cart after checkout
                    cartProvider.clearCart();

                    // Navigate to thank you page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThankYouScreen(),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Complete Order',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              const Text(
                'Thank You for Shopping! 🎉',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your order has been placed successfully.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Go back to previous (Home) screen
                },
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
