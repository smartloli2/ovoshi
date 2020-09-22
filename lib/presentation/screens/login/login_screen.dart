import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ovoshi/application/login_bloc/login_bloc.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';
import 'package:ovoshi/presentation/screens/login/login_form.dart';
import 'package:ovoshi/presentation/widgets/curved_widget.dart';

// Login page
class LoginScreen extends StatelessWidget {
  static const routeName = '/login_screen';
  // User repos
  final UserRepository _userRepository;
  // Constr-r
  const LoginScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  // Build page
  @override
  Widget build(BuildContext context) {
    // Material page
    return Scaffold(
      // App bar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: BlocProvider<LoginBloc>(
        // Provide the LoginBLoc
        create: (context) => LoginBloc(userRepository: _userRepository),
        // Body
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xfff2cbd0),
                Color(0xfff4ced9),
              ],
            ),
          ),
          // Scrollable turn on
          child: SingleChildScrollView(
            // Stack (pile of widgets)
            child: Stack(
              children: <Widget>[
                // Custom curved widget (background)
                CurvedWidget(
                  child: Container(
                    padding: const EdgeInsets.only(top: 100, left: 50),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white.withOpacity(0.4)],
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff6a515e),
                      ),
                    ),
                  ),
                ),
                // Form widget
                Container(
                  margin: const EdgeInsets.only(top: 230),
                  // Login form
                  child: LoginForm(
                    userRepository: _userRepository,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
