import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_screen_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class CustomerSearchResultScreen extends StatefulWidget {
  const CustomerSearchResultScreen({
    super.key,
    required this.size,
    required this.customerImage,
    required this.customerName,
    required this.customerID,
    required this.customerAddress,
    required this.dueAmount,
  });

  final Size size;
  final String customerImage;
  final String customerName;
  final String customerID;
  final String customerAddress;
  final String dueAmount;

  @override
  State<CustomerSearchResultScreen> createState() => _CustomerSearchResultScreenState();
}

class _CustomerSearchResultScreenState extends State<CustomerSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
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
          "Customers",
          style: GlobalTextStyles.productScreenTS(
              fontWeight: FontWeight.bold, color: ColorTheme.onBGColor, size: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: 2, //TODO
        itemBuilder: (context, index) {
          return CustomerScreenCard(
            size: widget.size,
            customerImage: widget.customerImage,
            customerName: widget.customerName,
            customerID: widget.customerID,
            customerAddress: widget.customerAddress,
            dueAmount: widget.dueAmount,
          );
        },
      ),
    );
  }
}
