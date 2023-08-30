import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<String>(context)); //Provider<String>
    //print(Provider.of<CartProvider>(context).cart);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: Provider.of<CartProvider>(context).cart.length,
        itemBuilder: (context, index) {
          final cartItem = Provider.of<CartProvider>(context).cart[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                //image provider
                cartItem['imageUrl'],
              ),
            ),
            title: Text(
              cartItem['title'],
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('Size: ${cartItem['size']}'),
            trailing: IconButton(
              onPressed: () {
                Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).removeProduct(cartItem);
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
