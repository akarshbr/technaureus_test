import 'package:clean_code_demo/presentation/customer_screen/controller/customer_screen_controller.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_screen_card.dart';
import 'package:clean_code_demo/repository/api/customer_screen/model/customers_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class CustomerSearchResultScreen extends StatefulWidget {
  const CustomerSearchResultScreen({
    super.key,
    required this.size,
    required this.searchText,
    required this.customersModel,
  });

  final Size size;
  final String searchText;
  final CustomersModel customersModel;

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
      body: Consumer<CustomerScreenController>(builder: (context, controller, _) {
        return controller.isLoadingSearch
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: widget.customersModel.data?.length, //TODO
                itemBuilder: (context, index) {
                  return CustomerScreenCard(
                    size: widget.size,
                    customerImage: widget.customersModel.data?[index].profilePic??"",
                    customerName: widget.customersModel.data?[index].name,
                    customerID: widget.customersModel.data?[index].id.toString(),
                    customerAddress:
                        "${widget.customersModel.data?[index].street}, ${widget.customersModel.data?[index].streetTwo}\n${widget.customersModel.data?[index].state}",
                  );
                },
              );
      }),
    );
  }
}
