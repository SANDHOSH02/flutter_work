import 'package:flutter/material.dart';

void main() {
  runApp(const OnlineShoppingApp());
}

class OnlineShoppingApp extends StatelessWidget {
  const OnlineShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductListScreen(),
    );
  }
}

// Mock Product Data
class Product {
  final String name;
  final String image;
  final double price;

  Product({required this.name, required this.image, required this.price});
}

final List<Product> products = [
  Product(name: 'Product 1', image: '📱', price: 100.0),
  Product(name: 'Product 2', image: '💻', price: 200.0),
  Product(name: 'Product 3', image: '🎧', price: 300.0),
  Product(name: 'Product 4', image: '⌚', price: 400.0),
  Product(name: 'Product 5', image: '🖥️', price: 500.0),
  Product(name: 'Product 6', image: '📷', price: 600.0),
  Product(name: 'Product 7', image: '🎮', price: 700.0),
  Product(name: 'Product 8', image: '🚲', price: 800.0),
  Product(name: 'Product 9', image: '🎮', price: 900.0),
];

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> cart = [];

  void _addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cart: cart)),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(product.image, style: const TextStyle(fontSize: 50)),
                Text(product.name),
                Text('₹${product.price}'),
                ElevatedButton(
                  onPressed: () => _addToCart(product),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Product> cart;

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.isEmpty
          ? const Center(child: Text('No items in cart'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('₹${product.price}'),
                        trailing: const Icon(Icons.remove_circle_outline),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total: ₹$totalPrice'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen(totalPrice: totalPrice)),
                    );
                  },
                  child: const Text('Proceed to Checkout'),
                ),
              ],
            ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;

  const CheckoutScreen({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Total Price: ₹$totalPrice'),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Enter Shipping Address'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the payment logic here
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Order Confirmed'),
                    content: Text('Your order of ₹$totalPrice has been placed!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context); // Go back to product list
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
