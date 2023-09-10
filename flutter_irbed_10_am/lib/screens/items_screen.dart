import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/providers/items_prov.dart';
import 'package:flutter_irbed_10_am/screens/item_det_screen.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatefulWidget {
  var idShop;

  ItemScreen({required this.idShop});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<ItemProv>(context, listen: false)
        .getItems(idShop: widget.idShop);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        width: width,
        height: height,
        child: Consumer<ItemProv>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.listItemModel.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ItemDetScreen(
                            itemModel: value.listItemModel[index],
                          );
                        },
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        value.listItemModel[index].HomeImage,
                        width: width - 32,
                        height: 150,
                      ),
                      Text(
                        value.listItemModel[index].Name,
                      ),
                      Text(
                        value.listItemModel[index].Price.toString(),
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
