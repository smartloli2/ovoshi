import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ovoshi/application/authentication_bloc/authentication_bloc.dart';
import 'package:ovoshi/providers/product.dart';
//import 'package:ovoshi/screens/product_detail/product_detail_screen.dart';

// Single product item
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  // Build witget
  @override
  Widget build(BuildContext context) {
    // Getting providers
    final product = Provider.of<Product>(context, listen: false);
    // final cart = Provider.of<CartProvider>(context, listen: false);
    // final auth = Provider.of<Auth>(context, listen: false);

    // Create a rounded-rectangular clip
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      // Set the tap detector
      child: InkWell(
        // on tap we go to detail page
        onTap: () => {print('tap on product')},
        /*Navigator.of(context)
            .pushNamed(ProductDetailScreen.routeName, arguments: product.id),*/

        // Forming the single tile
        child: GridTile(
          // Getting image from network
          child: Image.network(
            product.imageUrl,
            // Fit it in the frames
            fit: BoxFit.cover,
          ),

          header: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<AuthenticationBloc>(
                builder: (context, authBloc, child) => IconButton(
                  icon: product.isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),

                  // Setting up a click listener
                  onPressed: () async {
                    // Use method from product provider to manage the fav status
                    // TODO: conver to event "toggleFavoriteStatus"
                    await product.toggleFavoriteStatus(
                      authBloc.token,
                      authBloc.userId,
                    );
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),

          // Tile footer
          footer: GridTileBar(
            backgroundColor: Colors.black38,

            // Product price
            title: Text(
              '${product.price.toStringAsFixed(0)} \¥',
              style: TextStyle(
                fontSize: 20,
                // color: Colors.black,
              ),
            ),

            // Product title (name)
            subtitle: Text(
              product.title,
              textAlign: TextAlign.center,
            ),

            // Build the favorite icon (empty or filled)
            // leading: Consumer<Product>(
            //   builder: (context, value, child) => IconButton(
            //     icon: product.isFavorite
            //         ? Icon(Icons.favorite)
            //         : Icon(Icons.favorite_border),

            //     // Setting up a click listener
            //     onPressed: () async {
            //       // Use method from product provider to manage the fav status
            //       await product.toggleFavoriteStatus(auth.token, auth.userId);
            //     },
            //     color: Theme.of(context).accentColor,
            //   ),
            // ),

            /// Build the shopping cart icon
            // trailing: IconButton(
            //   icon: Icon(Icons.shopping_cart),

            //   // Setting up a click listener
            //   onPressed: () {
            //     cart.addItem(
            //       product.id,
            //       product.price,
            //       product.title,
            //     );
            //     Scaffold.of(context).hideCurrentSnackBar();
            //     Scaffold.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text(
            //           'Item added to cart',
            //           style: TextStyle(fontSize: 15),
            //         ),
            //         duration: Duration(seconds: 2),
            //         action: SnackBarAction(
            //           label: 'UNDO',
            //           onPressed: () {
            //             cart.removeSingleItem(product.id);
            //           },
            //         ),
            //       ),
            //     );
            //   },
            //   color: Theme.of(context).accentColor,
            // ),
          ),
        ),
      ),
    );
  }
}
