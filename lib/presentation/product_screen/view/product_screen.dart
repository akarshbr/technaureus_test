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
              return ProductScreenCard(image: 'assets/dummy/kiwi.png', productName: 'Kiwi', price: 300, size: size,);
            }),
      ),
    );
  }
}
