import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_search_result.dart';
import 'package:clean_code_demo/presentation/product_screen/view/widgets/product_search_result.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.size, required this.type});

  final Size size;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * .03, right: size.width * .03),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                SizedBox(
                  width: size.width * .6,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none, focusedBorder: InputBorder.none),
                    onFieldSubmitted: (searchText) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => type == "Customers"
                                ? CustomerSearchResultScreen(
                                    size: size,
                                    customerImage: 'assets/dummy/brian.jpg',
                                    customerName: 'Nest Hypermarket',
                                    customerID: '328739',
                                    customerAddress: 'West Palazhi,Calicut',
                                    dueAmount: '320',
                                  )
                                : ProductSearchResultScreen(
                                    size: size,
                                    image: 'assets/dummy/kiwi.png',
                                    productName: 'Kiwi',
                                    price: 300,
                                  ),
                          ));
                    },
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.qr_code,
                  color: Colors.grey,
                ),
                SizedBox(width: 10)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
