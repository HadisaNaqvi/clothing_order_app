import 'package:clothing_order_app/models/cart.dart';
import 'package:clothing_order_app/providers/wishlist_provider.dart';
import 'package:clothing_order_app/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/product.dart';
import 'models/order.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/order_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(CartAdapter());

  await Hive.openBox<Product>('products');
  await Hive.openBox<Order>('orders');
  await Hive.openBox<Cart>('cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..loadProducts(),
        ),
        ChangeNotifierProvider(create: (_) => OrderProvider()..loadOrders()),
        ChangeNotifierProvider(create: (_) => CartProvider()..loadCartItems()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clothing Order App',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          scaffoldBackgroundColor: const Color(0xFFDBDBDB),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
