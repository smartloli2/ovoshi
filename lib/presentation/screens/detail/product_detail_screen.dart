import 'package:flutter/material.dart';
import 'package:ovoshi/domain/entities/product.dart';

class ProductDetailScreen extends StatelessWidget {
  // Route name
  static const routeName = "/product_detail";
  ProductDetailScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // Get id from args
    final Product product = ModalRoute.of(context).settings.arguments;

    // Create screen
    return Scaffold(
      // Background color
      backgroundColor: Theme.of(context).backgroundColor,
      // Enable scrollable
      body: SingleChildScrollView(
        // Column
        child: Column(
          children: <Widget>[
            // Image
            Container(
              child: Stack(
                alignment: Alignment.center,
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 50.0,
                    right: 20.0,
                    left: 20.0,
                    child: Row(
                      children: <Widget>[
                        // Back arrow
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                            size: 25.0,
                          ),
                        ),

                        // Space box
                        Spacer(),

                        // Star icon
                        Icon(
                          Icons.star_border,
                          color: Colors.black87,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Space box
            SizedBox(
              height: 30.0,
            ),

            //
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "${product.price} \¥",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  //
                  Text(
                    "${product.title}",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.0,
                    ),
                    softWrap: true,
                  ),
                  //Spacer(),
                ],
              ),
            ),

            // Space box
            SizedBox(
              height: 10.0,
            ),

            // Space box
            SizedBox(
              height: 10.0,
            ),

            // Space box
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 10.0,
            ),

            // Reviews
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.yellow[800],
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "4.2 | 234 reviews (this is fake)",
                    style: TextStyle(
                        color: Colors.grey[850],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  )
                ],
              ),
            ),

            // Space box
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),

      // Buy now button
      floatingActionButton: new FloatingActionButton.extended(
          onPressed: null,
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Buy Now",
              style: TextStyle(fontSize: 20.0),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
