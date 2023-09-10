class ShopModel {
  var id;
  var name;
  var imageUrl;

  ShopModel({required this.id, required this.name, required this.imageUrl});

  factory ShopModel.fromJson(var json) {
    return ShopModel(
      id: json['Id'],
      name: json['Name'],
      imageUrl: json['ImageUrl'],
    );
  }
}
