class CategoriesModel {
  var Id;
  var Name;
  var Id_statetype;

  CategoriesModel({
    required this.Id,
    required this.Name,
    this.Id_statetype,
  });

  factory CategoriesModel.fromJson(var json) {
    return CategoriesModel(
      Id: json['Id'],
      Name: json['Name'],
      Id_statetype: json['Id_statetype'],
    );
  }
}
