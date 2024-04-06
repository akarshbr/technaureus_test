import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:clean_code_demo/core/constants/text_styles.dart';
import 'package:clean_code_demo/presentation/product_screen/controller/product_controller.dart';
import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_details_screen.dart';
import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_screen_card.dart';
import 'package:clean_code_demo/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bottom_navigation_screen/controller/bottom_navigation_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  fetchData() {
    Provider.of<ProductController>(context, listen: false).fetchProduct(context);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.bgColor,
        surfaceTintColor: ColorTheme.bgColor,
        leading: IconButton(
            onPressed: () {
              Provider.of<BottomNavigationController>(context, listen: false).currentIndex = 0;
            },
            icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          "Nest HyperMarket",
          style: GlobalTextStyles.productScreenTS(
              fontWeight: FontWeight.bold, color: ColorTheme.onBGColor, size: 20),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: SearchBarWidget(
              size: size,
              type: '',
            )),
      ),
      body: Consumer<ProductController>(builder: (context, controller, _) {
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding:
                    EdgeInsets.only(top: size.height * .01, left: size.width * .03, right: size.width * .03),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2 / 1,
                ),
                itemCount: controller.productModel.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              productName: controller.productModel.data![index].name,
                              size: size,
                              price: controller.productModel.data![index].price!.toDouble(),
                              productImage: controller.productModel.data?[index].image,
                            ),
                          ));
                    },
                    child: ProductScreenCard(
                      image: controller.productModel.data?[index].image,
                      productName: controller.productModel.data?[index].name,
                      price: controller.productModel.data![index].price?.toDouble(),
                      size: size,
                    ),
                  );
                });
      }),
    );
  }
}
