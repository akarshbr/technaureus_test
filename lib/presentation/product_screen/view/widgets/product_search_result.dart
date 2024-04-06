import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_screen_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class ProductSearchResultScreen extends StatefulWidget {
  const ProductSearchResultScreen(
      {super.key, required this.image, required this.productName, required this.price, required this.size});

  final String? image;
  final String? productName;
  final double? price;
  final Size size;

  @override
  State<ProductSearchResultScreen> createState() => _ProductSearchResultScreenState();
}

class _ProductSearchResultScreenState extends State<ProductSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.bgColor,
        surfaceTintColor: ColorTheme.bgColor,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          "Nest HyperMarket",
          style: GlobalTextStyles.productScreenTS(
              fontWeight: FontWeight.bold, color: ColorTheme.onBGColor, size: 20),
        ),
      ),
      body: GridView.builder(
          padding: EdgeInsets.only(
              top: widget.size.height * .01, left: widget.size.width * .03, right: widget.size.width * .03),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2 / 1,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ProductScreenCard(
              image: widget.image,
              productName: widget.productName,
              price: widget.price,
              size: widget.size,
            );
          }),
    );
  }
}
