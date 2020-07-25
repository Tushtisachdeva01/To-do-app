import 'package:flutter/material.dart';
import 'package:todo/screens/todo.dart';
import 'package:todo/widgets/drawer_navigation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To-do List'),
      ),
      drawer: DrawerNavigator(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
