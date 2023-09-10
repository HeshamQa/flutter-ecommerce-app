class CartModel {
  var Id;
  var Id_items;
  var Count;
  var Price;
  var Name;
  var HomeImage;

  CartModel({
    required this.Id,
    required this.Id_items,
    required this.Count,
    required this.Price,
    required this.Name,
    required this.HomeImage,
  });

  factory CartModel.fromJson(var json) {
    return CartModel(
      Id: json['Id'],
      Id_items: json['Id_items'],
      Count: json['Count'],
      Price: json['Price'],
      Name: json['Name'],
      HomeImage: json['HomeImage'],
    );
  }
}
