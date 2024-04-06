import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../config/app_config.dart';
import '../../../../core/constants/text_styles.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productName, required this.size, required this.price, required this.productImage});

  final String? productName;
  final String? productImage;
  final Size size;
  final double? price;

  @override
  Widget build(BuildContext context) {
    var imageUrl = AppConfig.mediaUrl + productImage!;
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          width: size.width,
          height: size.height * .6,
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
                      height: size.width * .7,
                      width: size.width * .7,
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
                      productName!,
                      style: GlobalTextStyles.productScreenTS(
                          color: ColorTheme.onBGColor, fontWeight: FontWeight.bold, size: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "$price",
                      style: GlobalTextStyles.productScreenTS(
                          color: Colors.red, size: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Create an Order",style: TextStyle(color: ColorTheme.bgColor),),
                      style: ElevatedButton.styleFrom(backgroundColor: ColorTheme.primaryColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
