import 'package:clean_code_demo/presentation/product_screen/controller/product_controller.dart';
import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_screen_card.dart';
import 'package:clean_code_demo/repository/api/product_screen/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class ProductSearchResultScreen extends StatefulWidget {
  const ProductSearchResultScreen(
      {super.key, required this.size, required this.searchText, required this.productsModel});

  final String searchText;
  final Size size;
  final ProductsModel productsModel;

  @override
  State<ProductSearchResultScreen> createState() => _ProductSearchResultScreenState();
}

class _ProductSearchResultScreenState extends State<ProductSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.bgColor,
        surfaceTintColor: ColorTheme.bgColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          "Nest HyperMarket",
          style: GlobalTextStyles.productScreenTS(
              fontWeight: FontWeight.bold, color: ColorTheme.onBGColor, size: 20),
        ),
      ),
      body: Consumer<ProductController>(builder: (context, controller, _) {
        return controller.isLoadingSearchProduct
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.only(
                    top: widget.size.height * .01,
                    left: widget.size.width * .03,
                    right: widget.size.width * .03),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2 / 1,
                ),
                itemCount: widget.productsModel.data?.length, //TODO
                itemBuilder: (context, index) {
                  return ProductScreenCard(
                    image: widget.productsModel.data?[index].image,
                    productName: widget.productsModel.data?[index].name,
                    price: widget.productsModel.data?[index].price?.toDouble(),
                    size: widget.size,
                  );
                });
      }),
    );
  }
}
