import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:clean_code_demo/core/constants/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductScreenCard extends StatelessWidget {
  const ProductScreenCard(
      {super.key, required this.image, required this.productName, required this.price, required this.size});

  final String? image;
  final String? productName;
  final double? price;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image(height: size.height * .1, image: AssetImage(image!))), //TODO : change to network image
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName!,
                        style: GlobalTextStyles.productScreenTS(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      Text("\$$price/-",style: GlobalTextStyles.productScreenTS(color: Colors.black),)
                    ],
                  ),
                  VerticalDivider(
                    width: 1,
                    color: Colors.black,
                    thickness: 1,
                    indent: 4,
                    endIndent: 6,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Add",
                      style: GlobalTextStyles.productScreenTS(),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
