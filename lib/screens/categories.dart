import 'package:flutter/material.dart';
import 'package:todo/models/category_model.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/service/category_service.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _categoryController = TextEditingController();
  var _descController = TextEditingController();
  var _category = Category();
  var _categoryService = CategoryService();
  List<Category> _list = List<Category>();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _list = List<Category>();
    var categories = await _categoryService.readCategory();
    categories.forEach((cat) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = cat["name"];
        categoryModel.id = cat["id"];
        categoryModel.desc = cat["desc"];
        _list.add(categoryModel);
      });
    });
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (p) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                  child: Text('Save'),
                  onPressed: () async {
                    _category.name = _categoryController.text;
                    _category.desc = _descController.text;
                    var result = await _categoryService.saveCategory(_category);
                    print(result);
                  }),
            ],
            title: Text("Category Form"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                      hintText: "Write a Category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      hintText: "Write a Description",
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
          elevation: 0,
          color: Colors.blue,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text("Categories"),
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_list[index].name),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
