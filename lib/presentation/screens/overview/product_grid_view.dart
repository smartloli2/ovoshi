import 'package:flutter/material.dart';

import 'package:ovoshi/domain/entities/product.dart';
import 'package:ovoshi/presentation/screens/overview/product_item.dart';

// Product grid
class ProductGridView extends StatelessWidget {
  final List<Product> items;
  final showFavotite;

  ProductGridView(this.items, this.showFavotite);

  // Build
  @override
  Widget build(BuildContext context) {
    // Get products class

    // Filtering list of products
    // showFavotite ? products.favoriteItems : products.items;
    // final items = products.add(FetchProducts());

    // Build product grid
    return Container(
      color: Theme.of(context).backgroundColor,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: items.length,

        itemBuilder: (ctx, i) => ProductItem(
          product: items[i],
          //items[i].id,
          //items[i].title,
          //items[i].imageUrl,
        ),

        // It controls the layout of the children within the [GridView]
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
