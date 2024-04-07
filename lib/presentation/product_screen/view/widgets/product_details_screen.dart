import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:clean_code_demo/presentation/product_screen/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_config.dart';
import '../../../../core/constants/text_styles.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key,
      required this.productName,
      required this.size,
      required this.price,
      required this.productImage,
      required this.id});

  final String? productName;
  final String? productImage;
  final Size size;
  final int id;
  final double? price;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  fetchData() {
    Provider.of<ProductController>(context, listen: false).fetchProduct(context, widget.id, widget.size);
  }

  @override
  Widget build(BuildContext context) {
    var imageUrl = AppConfig.mediaUrl + widget.productImage!;
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: Consumer<ProductController>(builder: (context, controller, _) {
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  width: widget.size.width,
                  height: widget.size.height * .6,
                  child: Card(
                    color: ColorTheme.bgColor,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back_ios)),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              height: widget.size.width * .7,
                              width: widget.size.width * .7,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.productName!,
                              style: GlobalTextStyles.productScreenTS(
                                  color: ColorTheme.onBGColor, fontWeight: FontWeight.bold, size: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "${widget.price}",
                              style: GlobalTextStyles.productScreenTS(
                                  color: Colors.red, size: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Create an Order",
                                style: TextStyle(color: ColorTheme.bgColor),
                              ),
                              style: ElevatedButton.styleFrom(backgroundColor: ColorTheme.primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
