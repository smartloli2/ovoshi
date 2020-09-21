import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ovoshi/application/authentication_bloc/authentication_bloc.dart';
import 'package:ovoshi/application/authentication_bloc/authentication_state.dart';
import 'package:ovoshi/presentation/core/theme.dart';
import 'package:ovoshi/presentation/screens/login/login_screen.dart';
import 'package:ovoshi/presentation/screens/overview/product_overview_screen.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';

class AppWidget extends StatelessWidget {
  final UserRepository _userRepository;

  AppWidget({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ovoshi',

      // Application global theme
      theme: appTheme(),

      // Build home page
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          ////
          // if authentication failed
          if (state is AuthenticationFailure) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }

          // if authentication succeed
          if (state is AuthenticationSuccess) {
            return ProductOverviewScreen(

                // user: state.firebaseUser,
                );
          }

          // Loading page
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(child: Text("Loading")),
            ),
          );
        },
      ),
    );
  }
}
