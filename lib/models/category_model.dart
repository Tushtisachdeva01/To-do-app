class Category {
  int id;
  String name;
  String desc;

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['desc'] = desc;
    return mapping;
  }
}
