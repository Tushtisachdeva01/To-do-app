import 'package:flutter/material.dart';
import 'package:todo/helper/drawer_navigation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To-do List'),
      ),
      drawer: DrawerNavigator(),
    );
  }
}