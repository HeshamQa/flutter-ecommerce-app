import 'package:flutter/material.dart';
import 'package:flutter_irbed_10_am/custom_button.dart';
import 'package:flutter_irbed_10_am/models/item_model.dart';
import 'package:flutter_irbed_10_am/providers/item_image_prov.dart';
import 'package:flutter_irbed_10_am/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class ItemDetScreen extends StatefulWidget {
  ItemModel itemModel;

  ItemDetScreen({required this.itemModel});

  @override
  State<ItemDetScreen> createState() => _ItemDetScreenState();
}

class _ItemDetScreenState extends State<ItemDetScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<ItemImageProv>(context, listen: false)
        .getItemsImages(idItems: widget.itemModel.Id);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * .3,
              margin: EdgeInsets.all(8),
              child: Consumer<ItemImageProv>(
                builder: (context, value, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.listItemImageModel.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        value.listItemImageModel[index].ImageUrl,
                        width: width - 16,
                        height: (height * .3) - 16,
                        fit: BoxFit.fill,
                      );
                    },
                  );
                },
              ),
            ),
            Text(widget.itemModel.Name),
            Text(widget.itemModel.Price.toString()),
            Text(widget.itemModel.Description),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        buttonText: "Add To Cart",
        onTap: () async {
          await Provider.of<CartProv>(context, listen: false)
              .addToCart(idItem: widget.itemModel.Id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
      ),
    );
  }
}
