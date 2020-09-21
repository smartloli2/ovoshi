import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovoshi/presentation/core/app_widget.dart';

import 'package:provider/provider.dart';

import 'package:ovoshi/application/authentication_bloc/authentication_bloc.dart';
import 'package:ovoshi/application/authentication_bloc/authentication_event.dart';
import 'package:ovoshi/application/products_bloc/products_bloc.dart';
import 'package:ovoshi/application/simple_bloc_observer.dart';
import 'package:ovoshi/providers/auth.dart';
import 'package:ovoshi/providers/cart.dart';
import 'package:ovoshi/providers/orders.dart';
import 'package:ovoshi/providers/products.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    // Multi providers
    MultiProvider(
      providers: [
        // Old auth
        /*ChangeNotifierProvider(
          create: (context) => Auth(),
        ),*/

        // Old product
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts != null ? previousProducts.items : [],
          ),
        ),

        // Old cart
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),

        // Old orders
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders('', '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),

        // Auth
        BlocProvider(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          )..add(AuthenticationStarted()),
        ),

        // Products
        BlocProvider(
          create: (context) {
            return ProductsBloc(
              userRepository: userRepository,
            );
          },
        ),
      ],

      // App widget
      child: AppWidget(
        userRepository: userRepository,
      ),
    ),
  );
}
