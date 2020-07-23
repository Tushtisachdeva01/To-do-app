import 'package:flutter/material.dart';
import 'package:todo/models/category_model.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/service/category_service.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var _categoryController = TextEditingController();
  var _editcategoryController = TextEditingController();
  var _descController = TextEditingController();
  var _editdescController = TextEditingController();
  var _category = Category();
  var _categoryService = CategoryService();
  var category;
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
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                  }
                },
              ),
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

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editcategoryController.text = category[0]['name'] ?? 'No Name';
      _editdescController.text = category[0]['desc'] ?? 'No Description';
    });
    _editDialog(context);
  }

  _editDialog(BuildContext context) {
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
                  child: Text('Update'),
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editcategoryController.text;
                    _category.desc = _editdescController.text;
                    var result =
                        await _categoryService.updateCategory(_category);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _successSnackBar(
                        Text('Update Successful'),
                      );
                    }
                  }),
            ],
            title: Text("Edit Category Form"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editcategoryController,
                    decoration: InputDecoration(
                      hintText: "Write a Category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _editdescController,
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

  _deleteDialog(BuildContext context, categoryId) {
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
                  child: Text('Delete'),
                  onPressed: () async {
                    var result =
                        await _categoryService.deleteCategory(categoryId);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _successSnackBar(
                        Text('Deleted Successfully'),
                      );
                    }
                  }),
            ],
            title: Text("Are you sure you want to delete?"),
          );
        });
  }

  _successSnackBar(message) {
    var _snackBar = SnackBar(
      content: message,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
    );
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
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
                    onPressed: () {
                      _editCategory(context, _list[index].id);
                    },
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
                        onPressed: () {
                          _deleteDialog(context, _list[index].id);
                        },
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
