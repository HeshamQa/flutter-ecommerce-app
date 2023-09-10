class ItemImageModel {
  var Id;
  var ImageUrl;

  ItemImageModel({
    required this.Id,
    required this.ImageUrl,
  });

  factory ItemImageModel.fromJson(var json) {
    return ItemImageModel(
      Id: json['Id'],
      ImageUrl: json['ImageUrl'],
    );
  }
}
