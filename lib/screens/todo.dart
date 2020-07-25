import 'package:flutter/material.dart';
import 'package:todo/service/category_service.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  var _selectedValue;
  var _categories = List<DropdownMenuItem>();
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _date(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: _dateTime,
      lastDate: DateTime(2030),
    );
    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_pickedDate);
      });
    }
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
    categories.forEach((cat) {
      setState(() {
        _categories.add(
          DropdownMenuItem(
            child: Text(cat['name']),
            value: cat['name'],
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write To-do Title',
              ),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Write To-do Description',
              ),
            ),
            TextField(
              keyboardType: TextInputType.datetime,
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Pick a To-do Date',
                prefixIcon: InkWell(
                  onTap: () {
                    _date(context);
                  },
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            DropdownButtonFormField(
              value: _selectedValue,
              hint: Text('Category'),
              items: _categories,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {},
              color: Colors.blue,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
