class OrderHistoryModel {
  var Id;
  var TotalPrice;
  var Longitude;
  var Latitude;
  var Note;
  var orderstate;

  OrderHistoryModel(
      {required this.Id,
      required this.TotalPrice,
      required this.Longitude,
      required this.Latitude,
      required this.Note,
      required this.orderstate});

  factory OrderHistoryModel.fromJson(var json) {
    return OrderHistoryModel(
      Id: json['Id'],
      TotalPrice: json['TotalPrice'],
      Longitude: json['Longitude'],
      Latitude: json['Latitude'],
      Note: json['Note'],
      orderstate: json['orderstate'],
    );
  }
}
