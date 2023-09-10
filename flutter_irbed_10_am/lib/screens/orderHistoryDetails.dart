import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/providers/items_prov.dart';
import 'package:flutter_irbed_10_am/providers/orderHistoryDetailsProv.dart';
import 'package:flutter_irbed_10_am/providers/orderHistoryProv.dart';
import 'package:flutter_irbed_10_am/screens/item_det_screen.dart';
import 'package:provider/provider.dart';

class OrderHistoryDetailsScreen extends StatefulWidget {
  var Id_orders;

  OrderHistoryDetailsScreen({required this.Id_orders});

  @override
  State<OrderHistoryDetailsScreen> createState() =>
      _OrderHistoryDetailsScreenState();
}

class _OrderHistoryDetailsScreenState extends State<OrderHistoryDetailsScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderHistoryDetailsProv>(context, listen: false)
        .getOrderHistoryDet(widget.Id_orders);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        width: width,
        height: height,
        child: Consumer<OrderHistoryDetailsProv>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.listOrderHistoryDetailsModel.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: Image.network(
                          value.listOrderHistoryDetailsModel[index].HomeImage,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        "Name : ${value.listOrderHistoryDetailsModel[index].Name}",
                      ),
                      Text(
                        "Total Price :${value.listOrderHistoryDetailsModel[index].Count}",
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
