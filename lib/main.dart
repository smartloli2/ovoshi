import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovoshi/application/product_bloc/product_notifier.dart';
import 'package:ovoshi/presentation/core/app_widget.dart';

import 'package:provider/provider.dart';

import 'package:ovoshi/application/authentication_bloc/authentication_bloc.dart';
import 'package:ovoshi/application/authentication_bloc/authentication_event.dart';
import 'package:ovoshi/application/products_bloc/products_bloc.dart';
import 'package:ovoshi/application/simple_bloc_observer.dart';
import 'package:ovoshi/providers/cart.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    // Multi providers
    MultiProvider(
      providers: [
        // Old cart
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
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

        // Product
        ChangeNotifierProvider(
          create: (context) {
            return ProductBloc(
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
