import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    // print(Provider.of<String>(context)); //Provider<String>
    //print(Provider.of<CartProvider>(context).cart);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

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
                showDialog(
                  //barrierDismissible:
                  //  false, //does not allow to close the dialog box by clicking outside
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete Product',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: const Text(
                        'Are you sure you want to remove the product from the cart?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context //short hand syntax
                                .read<CartProvider>()
                                .removeProduct(cartItem);
                            // Provider.of<CartProvider>(
                            //   context,
                            //   listen: false,
                            // ).removeProduct(cartItem);
                            Navigator.of(context)
                                .pop(); //removes the dialog box
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
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
