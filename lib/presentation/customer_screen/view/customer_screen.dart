import 'dart:developer';

import 'package:clean_code_demo/presentation/customer_screen/controller/customer_screen_controller.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../widget/search_bar.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  var customerNameTEController = TextEditingController();
  var customerMobileTEController = TextEditingController();
  var customerEmailTEController = TextEditingController();
  var customerStreetTEController = TextEditingController();
  var customerStreetTwoTEController = TextEditingController();
  var customerCityTEController = TextEditingController();
  var customerPinCodeTEController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.bgColor,
        surfaceTintColor: ColorTheme.bgColor,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          "Customers",
          style: GlobalTextStyles.productScreenTS(
              fontWeight: FontWeight.bold, color: ColorTheme.onBGColor, size: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                addEditCustomerBottomSheet(context, size);
              },
              icon: Icon(Icons.add_business))
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: SearchBarWidget(
              size: size,
            )),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return CustomerScreenCard(
              size: size,
              customerImage: 'assets/dummy/brian.jpg',
              customerName: 'Nest Hypermarket',
              customerID: '328739',
              customerAddress: 'West Palazhi,Calicut',
              dueAmount: '320',
            );
          }),
    );
  }

  Future<dynamic> addEditCustomerBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Customer"),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<CustomerScreenController>(context, listen: false).countrySelected =
                                null;
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Text("Customer Name"),
                  TextFormField(controller: customerNameTEController),
                  TextFormField(
                    controller: customerMobileTEController,
                    decoration: InputDecoration(hintText: "Mobile Number"),
                  ),
                  TextFormField(
                    controller: customerEmailTEController,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  Text("Address"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(
                                controller: customerStreetTEController,
                                decoration: InputDecoration(hintText: "Street"),
                              )),
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(
                                controller: customerCityTEController,
                                decoration: InputDecoration(hintText: "City"),
                              )),
                          SizedBox(
                            width: size.width * .45,
                            child: Consumer<CustomerScreenController>(builder: (context, controller, _) {
                              return DropdownButton<String>(
                                  isExpanded: true,
                                  items: dropdownItemsCountry,
                                  value: controller.countrySelected,
                                  hint: const Text("Country"),
                                  onChanged: (String? selectedCountry) {
                                    log("selected country -> $selectedCountry");
                                    controller.setCountry(selectedCountry!);
                                  });
                            }),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(controller: customerStreetTwoTEController,decoration: InputDecoration(hintText: "Street two"))),
                          SizedBox(
                              width: size.width * .45,
                              child: TextFormField(controller: customerPinCodeTEController,decoration: InputDecoration(hintText: "Pincode"))),
                          SizedBox(
                            width: size.width * .45,
                            child: Consumer<CustomerScreenController>(builder: (context, controller, _) {
                              return DropdownButton<String>(
                                  isExpanded: true,
                                  items: dropdownItemsState,
                                  value: controller.stateSelected,
                                  hint: const Text("State"),
                                  onChanged: (String? selectedState) {
                                    log("selected country -> $selectedState");
                                    controller.setState(selectedState!);
                                  });
                            }),
                          )
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        log("customer name -> ${customerNameTEController.text}");
                        log("customer mobile -> ${customerMobileTEController.text}");
                        log("customer email -> ${customerEmailTEController.text}");
                        log("customer street -> ${customerStreetTEController.text}");
                        log("customer street two -> ${customerStreetTwoTEController.text}");
                        log("customer city -> ${customerCityTEController.text}");
                        log("customer pincode -> ${customerPinCodeTEController.text}");
                        log("country -> ${Provider.of<CustomerScreenController>(context,listen: false).countrySelected}");
                        log("state selected -> ${Provider.of<CustomerScreenController>(context,listen: false).stateSelected}");
                      },
                      child: Text(
                        "Submit",
                        style: GlobalTextStyles.customerScreenTS(color: ColorTheme.bgColor),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: ColorTheme.primaryColor),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

List<DropdownMenuItem<String>> get dropdownItemsCountry {
  List<DropdownMenuItem<String>> menuItems = [const DropdownMenuItem(value: "India", child: Text("India"))];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownItemsState {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Kerala", child: Text("Kerala")),
    const DropdownMenuItem(value: "TamilNadu", child: Text("TamilNadu")),
    const DropdownMenuItem(value: "Karnataka", child: Text("Karnataka"))
  ];
  return menuItems;
}
