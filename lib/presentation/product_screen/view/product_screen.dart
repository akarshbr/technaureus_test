import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:clean_code_demo/core/constants/text_styles.dart';
import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_screen_card.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          "Nest HyperMarket",
          style: GlobalTextStyles.productScreenTS(
              fontWeight: FontWeight.bold, color: ColorTheme.onBGColor, size: 20),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: size.height * .01, left: size.width * .03, right: size.width * .03),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2 / 1,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ProductScreenCard(
                image: 'assets/dummy/kiwi.png',
                productName: 'Kiwi',
                price: 300,
                size: size,
              );
            }),
      ),
    );
  }
}
