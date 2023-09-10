class ItemModel {
  var Id;
  var Name;
  var HomeImage;
  var Price;
  var Description;

  ItemModel(
      {required this.Id,
      required this.Name,
      required this.HomeImage,
      required this.Price,
      required this.Description});

  factory ItemModel.fromJson(var json) {
    return ItemModel(
      Id: json['Id'],
      Name: json['Name'],
      HomeImage: json['HomeImage'],
      Price: json['Price'],
      Description: json['Description'],
    );
  }
}
