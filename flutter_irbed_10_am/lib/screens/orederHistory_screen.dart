import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/providers/items_prov.dart';
import 'package:flutter_irbed_10_am/providers/orderHistoryProv.dart';
import 'package:flutter_irbed_10_am/screens/item_det_screen.dart';
import 'package:flutter_irbed_10_am/screens/orderHistoryDetails.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderHistoryProv>(context, listen: false).getOrderHistory();
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
        child: Consumer<OrderHistoryProv>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.listOrderHistoryModel.length,
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OrderHistoryDetailsScreen(
                              Id_orders: value.listOrderHistoryModel[index].Id,
                            );
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          "Order ID : ${value.listOrderHistoryModel[index].Id}",
                        ),
                        Text(
                          "Total Price :${value.listOrderHistoryModel[index].TotalPrice}",
                        ),
                        Text(
                          "Order State :${value.listOrderHistoryModel[index].orderstate}",
                        ),
                        Text(
                          "Your Note :${value.listOrderHistoryModel[index].Note}",
                        ),
                      ],
                    ),
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
