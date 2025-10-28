import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../models/product.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Cotton Color Block Hoodie',
      description: 'Apricot color hoodie, stylish and cozy.',
      price: 3200.0,
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'assets/images/High Quality Cotton Color Block Hoodie - Apricot Color In Stock _ S.jpg',
      ],
      category: 'Unisex',
    ),
    Product(
      id: '2',
      name: 'Casual White Tee',
      description: 'Lana Official casual wear outfit.',
      price: 1600.0,
      sizes: ['S', 'M', 'L'],
      images: [
        'assets/images/Lookbook  _ Lana Official _ Casual Wear 22 Collect.jpg',
      ],
      category: 'Women',
    ),
    Product(
      id: '3',
      name: 'Washed Blue Jeans',
      description: 'Comfortable denim jeans with a washed blue shade.',
      price: 2600.0,
      sizes: ['30', '32', '34', '36'],
      images: ['assets/images/LOOSE FIT JEANS - WASHED BLUE.jpg'],
      category: 'Men',
    ),
    Product(
      id: '4',
      name: 'Floral Blue Dress',
      description: 'Sunfire smocked bodice tiered midi dress.',
      price: 3400.0,
      sizes: ['S', 'M', 'L'],
      images: [
        'assets/images/Luray Floral Sunfire Smocked Bodice Tiered Midi Curve Dress - BLUES-WHITE _ 2X.jpg',
      ],
      category: 'Women',
    ),
    Product(
      id: '5',
      name: 'Check Casual Shirt',
      description: 'Athletic-fit navy plaid tall size shirt.',
      price: 2100.0,
      sizes: ['M', 'L', 'XL'],
      images: [
        'assets/images/Men\'s Athletic-Fit Dress Shirt Navy Plaid Tall Size L.jpg',
      ],
      category: 'Men',
    ),
    Product(
      id: '6',
      name: 'White Printed T-Shirt',
      description: 'Letter printed white summer graphic tee.',
      price: 1700.0,
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'assets/images/Men\'s Letter Printed White Casual Short Sleeve T-Shirt, Summer,Graphic Tees.jpg',
      ],
      category: 'Men',
    ),
    Product(
      id: '7',
      name: 'Midi Puff Sleeve Dress',
      description: 'Floral puff sleeve dress from Phase Eight.',
      price: 3900.0,
      sizes: ['S', 'M', 'L'],
      images: [
        'assets/images/Penelope Floral Puff Sleeve Midi Dress _ Phase Eight ROW _.jpg',
      ],
      category: 'Women',
    ),
    Product(
      id: '8',
      name: 'Oversized Black Tee',
      description: 'UC Heavy oversized peach T-shirt.',
      price: 1600.0,
      sizes: ['S', 'M', 'L', 'XL'],
      images: ['assets/images/UC Heavy Oversized Tee - Peach _ 5XL.jpg'],
      category: 'Unisex',
    ),
    Product(
      id: '9',
      name: 'Wool Skirt',
      description: 'Warm wool skirt perfect for winter outfits.',
      price: 2500.0,
      sizes: ['S', 'M', 'L'],
      images: [
        'assets/images/Wool skirt, Long wool skirt, A line skirt, Womens skirt, Women wool skirt with pockets, Casual skirt, Autumn winter outfits, Xiaolizi 5483.jpg',
      ],
      category: 'Women',
    ),
    Product(
      id: '10',
      name: 'Leather Jacket',
      description: 'Chocolate faux-leather zip-up jacket.',
      price: 4800.0,
      sizes: ['M', 'L', 'XL'],
      images: [
        'assets/images/Zip-up faux-leather jacket chocolate MANGO MAN.jpg',
      ],
      category: 'Men',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final wishlistProvider = context.watch<WishlistProvider>();

    final List<Widget> screens = [
      _buildHome(cartProvider, wishlistProvider),
      const CartScreen(),
      const WishlistScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart),
                if (cartProvider.cartCount > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        cartProvider.cartCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }

  Widget _buildHome(
    CartProvider cartProvider,
    WishlistProvider wishlistProvider,
  ) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Clothing Store',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = _products[index];
                final isWishlisted = wishlistProvider.isInWishlist(product);
                final isInCart = cartProvider.isInCart(product);

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            product.images.isNotEmpty
                                ? product.images.first
                                : 'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported, size: 80),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text('Rs. ${product.price.toStringAsFixed(0)}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isWishlisted
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isWishlisted
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () =>
                                      wishlistProvider.toggleWishlist(product),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isInCart
                                        ? Icons.shopping_cart
                                        : Icons.add_shopping_cart,
                                    color: isInCart
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  onPressed: () async {
                                    if (!isInCart) {
                                      await cartProvider.addToCart(product, 1);
                                    } else {
                                      await cartProvider.toggleCart(product);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
