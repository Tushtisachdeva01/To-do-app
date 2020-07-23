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

  readCategory() async {
    return await _repository.readData('categories');
  }

  readCategoryById(categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }

  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  deleteCategory(categoryId) async{
    return await _repository.deleteData('categories',categoryId);
  }
}
