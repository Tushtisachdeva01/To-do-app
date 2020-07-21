import 'package:flutter/material.dart';
import 'package:todo/screens/categories.dart';
import 'package:todo/screens/home.dart';

class DrawerNavigator extends StatelessWidget {

  Widget tile(BuildContext context, IconData icon, String title, Widget func) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => func),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Tushti'),
              accountEmail: Text('tushti@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue[900],
                radius: 20,
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            tile(
              context,
              Icons.home,
              "Home",
              HomeScreen(),
            ),
            tile(
              context,
              Icons.view_list,
              "Categories",
              CategoryScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
