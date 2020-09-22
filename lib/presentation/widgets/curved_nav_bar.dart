import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CurvedNavBar extends StatelessWidget {
  const CurvedNavBar({
    Key key,
    @required GlobalKey<State<StatefulWidget>> bottomNavigationKey,
  })  : _bottomNavigationKey = bottomNavigationKey,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _bottomNavigationKey;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      height: 50,
      backgroundColor: Theme.of(context).backgroundColor,
      buttonBackgroundColor: Theme.of(context).accentColor,
      color: Theme.of(context).primaryColor,
      items: <Widget>[
        Icon(
          Icons.search,
          size: 30,
        ),
        Icon(
          Icons.shopping_cart,
          size: 30,
        ),
        Icon(
          Icons.add,
          size: 30,
        ),
        Icon(
          Icons.favorite,
          size: 30,
        ),
        Icon(
          Icons.person,
          size: 30,
        ),
      ],
      animationDuration: Duration(milliseconds: 300),
      //animationCurve: Curves.bounceInOut,
      onTap: (index) {
        /*setState(() {
          _page = index;
        });*/
      },
    );
  }
}
