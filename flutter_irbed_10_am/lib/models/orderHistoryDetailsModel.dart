class OrderHistoryDetailsModel {
  var Id_items;
  var Name;
  var Count;
  var HomeImage;

  OrderHistoryDetailsModel(
      {required this.Id_items,
        required this.Name,
        required this.Count,
        required this.HomeImage});

  factory OrderHistoryDetailsModel.fromJson(var json) {
    return OrderHistoryDetailsModel(
      Id_items: json['Id_items'],
      Name: json['Name'],
      Count: json['Count'],
      HomeImage: json['HomeImage'],
    );
  }
}
