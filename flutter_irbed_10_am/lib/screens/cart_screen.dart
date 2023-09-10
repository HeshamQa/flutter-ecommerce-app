import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/custom_button.dart';
import 'package:flutter_irbed_10_am/screens/map_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProv>(context, listen: false).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProv>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            value.listCartModel[index].HomeImage,
                            width: 150,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                          Column(
                            children: [
                              Text(
                                value.listCartModel[index].Name,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      var newCount =
                                          value.listCartModel[index].Count + 1;
                                      value.updateItemCount(
                                          value.listCartModel[index].Id,
                                          newCount,
                                          index);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                    ),
                                  ),
                                  Text(
                                    value.listCartModel[index].Count.toString(),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      var newCount =
                                          value.listCartModel[index].Count - 1;
                                      value.updateItemCount(
                                          value.listCartModel[index].Id,
                                          newCount,
                                          index);
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: value.listCartModel.length,
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Total Price = "),
                Consumer<CartProv>(
                  builder: (context, value, child) {
                    return Text(
                      value.totalPrice.toString(),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomButton(
        buttonText: "Next",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MapScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
