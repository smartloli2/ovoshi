import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import 'package:ovoshi/application/authentication_bloc/authentication_bloc.dart';
import 'package:ovoshi/application/authentication_bloc/authentication_event.dart';
import 'package:ovoshi/application/products_bloc/products_bloc.dart';
import 'package:ovoshi/providers/cart.dart';
import 'package:ovoshi/presentation/screens/overview/badge.dart';
import 'package:ovoshi/presentation/screens/overview/product_grid_view.dart';
import 'package:ovoshi/presentation/widgets/curved_nav_bar.dart';

//import 'package:ovoshi/screens/cart/cart_screen.dart';
//import 'package:ovoshi/widgets/app_drawer.dart';

// For filtering
enum FilterOptions {
  All,
  Favorite,
}

// Product overview screen
class ProductOverviewScreen extends StatefulWidget {
  // Route name
  static const routeName = '/product_overview';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  // var showFavorite = false;
  bool _isInit = true;

  // Curved navbar
  GlobalKey _bottomNavigationKey = GlobalKey();

  // Like init but with context
  @override
  void didChangeDependencies() {
    if (_isInit) {
      BlocProvider.of<ProductsBloc>(context).add(FetchProducts());
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  // Build page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        title: Text(
          'Ovoshi',
          style: TextStyle(fontSize: 24),
        ),

        // Action buttons
        actions: [
          // Logout button
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut());
            },
          ),
          // Filter button

          /*PopupMenuButton(
            onSelected: (FilterOptions opt) {
              if (opt == FilterOptions.All) {
                setState(() {
                  showFavorite = false;
                });
              }
              if (opt == FilterOptions.Favorite) {
                setState(() {
                  showFavorite = true;
                });
              }
            },
            icon: Icon(Icons.more_horiz),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('All'), value: FilterOptions.All),
              PopupMenuItem(
                  child: Text('Favorire'), value: FilterOptions.Favorite),
            ],
          ),*/

          // Cart button
          Consumer<CartProvider>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // TODO: Cart navigation
                  // Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          ),
        ],
      ),

      // Good place for BlocBuilder
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).backgroundColor,
                ),
              ),
            );
          }
          if (state is ProductsLoaded) {
            return ProductGridView(state.items, false);
          }

          // TODO: error handling
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(child: Text("Error?!")),
            ),
          );
        },
      ),

      /*_isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGridView(showFavorite),*/

      // Drawer bar
      //drawer: AppDrawer(),

      // Navigation bar
      bottomNavigationBar:
          CurvedNavBar(bottomNavigationKey: _bottomNavigationKey),
    );
  }
}
