import 'package:todo/models/category_model.dart';
import 'package:todo/repositories/repo.dart';

class CategoryService {
  Repository _repository = Repository();
  saveCategory(Category category) async {
    return await _repository.insertData(
      'categories',
      category.categoryMap(),
    );
  }
  readCategory() async{
    return await _repository.readData('categories');
  }
}
