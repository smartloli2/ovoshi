import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ovoshi/application/authentication_bloc/authentication_bloc.dart';
import 'package:ovoshi/application/authentication_bloc/authentication_event.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  /// final FirebaseUser user;
  /// const HomeScreen({Key key, this.user}) : super(key: key);
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut());
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            /// child: Text("Hello, ${user.email}"),
            child: Text(
              "Ohayō onī-san!",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
