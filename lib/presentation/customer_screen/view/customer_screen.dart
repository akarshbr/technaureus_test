import 'dart:developer';
import 'dart:io';

import 'package:clean_code_demo/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:clean_code_demo/presentation/customer_screen/controller/customer_screen_controller.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_screen_card.dart';
import 'package:clean_code_demo/widget/search_bar_customer.dart';
import 'package:clean_code_demo/widget/select_image_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  fetchData() {
    Provider.of<CustomerScreenController>(context, listen: false).fetchCustomers(context);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  var customerNameTEController = TextEditingController();
  var customerMobileTEController = TextEditingController();
  var customerEmailTEController = TextEditingController();
  var customerStreetTEController = TextEditingController();
  var customerStreetTwoTEController = TextEditingController();
  var customerCityTEController = TextEditingController();
  var customerPinCodeTEController = TextEditingController();
  File? image;

  Future<void> getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
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
            child: SearchBarCustomerWidget(
              size: size,
              type: 'Customers',
            )),
      ),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<CustomerScreenController>(context, listen: false).fetchCustomers(context),
        child: Consumer<CustomerScreenController>(builder: (context, controller, _) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.customersModel.data?.length, //TODO
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<CustomerScreenController>(context, listen: false)
                            .fetchCustomer(context, controller.customersModel.data?[index].id, size);
                      },
                      child: CustomerScreenCard(
                        size: size,
                        customerImage: controller.customersModel.data?[index].profilePic ?? "",
                        customerName: controller.customersModel.data?[index].name ?? "",
                        customerID: controller.customersModel.data?[index].id.toString() ?? "",
                        customerAddress:
                            '${controller.customersModel.data?[index].street ?? ""}, ${controller.customersModel.data?[index].streetTwo ?? ""}, \n${controller.customersModel.data?[index].state ?? ""}',
                      ),
                    );
                  });
        }),
      ),
    );
  }

  Future<dynamic> addEditCustomerBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, inSetState) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(size.width * .05, size.width * .05, size.width * .05,
                  MediaQuery.of(context).viewInsets.bottom),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Customer", style: GlobalTextStyles.customerScreenCardBSTS),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<CustomerScreenController>(context, listen: false).countrySelected =
                                  null;
                              setState(() {
                                image = null;
                              });
                            },
                            icon: Icon(Icons.close))
                      ],
                    ),
                    Text("Customer Name"),
                    TextFormField(
                      controller: customerNameTEController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      style: GlobalTextStyles.customerScreenCardBSTS,
                    ),
                    TextFormField(
                      controller: customerMobileTEController,
                      decoration: InputDecoration(hintText: "Mobile Number"),
                    ),
                    TextFormField(
                      controller: customerEmailTEController,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    SizedBox(height: size.width * .05),
                    Text(
                      "Choose Profile Pic",
                      style: GlobalTextStyles.customerScreenCardBSTS,
                    ),
                    Row(
                      children: [
                        SelectImageButton(
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          icon: Icons.photo,
                          label: "Choose DP",
                          iconColor: ColorTheme.primaryColor,
                          labelColor: ColorTheme.primaryColor,
                        ),
                        if (image != null)
                          Container(
                            margin: EdgeInsets.only(left: size.width * .2),
                            height: 100,
                            width: 100,
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          )
                      ],
                    ),
                    SizedBox(height: size.width * .05),
                    Text(
                      "Address",
                      style: GlobalTextStyles.customerScreenCardBSTS,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: size.width * .43,
                                child: TextFormField(
                                  controller: customerStreetTEController,
                                  decoration: InputDecoration(hintText: "Street"),
                                )),
                            SizedBox(
                                width: size.width * .43,
                                child: TextFormField(
                                  controller: customerCityTEController,
                                  decoration: InputDecoration(hintText: "City"),
                                )),
                            SizedBox(
                              width: size.width * .43,
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
                                width: size.width * .43,
                                child: TextFormField(
                                    controller: customerStreetTwoTEController,
                                    decoration: InputDecoration(hintText: "Street two"))),
                            SizedBox(
                                width: size.width * .43,
                                child: TextFormField(
                                    controller: customerPinCodeTEController,
                                    decoration: InputDecoration(hintText: "Pincode"))),
                            SizedBox(
                              width: size.width * .43,
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
                          log("country -> ${Provider.of<CustomerScreenController>(context, listen: false).countrySelected}");
                          log("state selected -> ${Provider.of<CustomerScreenController>(context, listen: false).stateSelected}");
                          Provider.of<CustomerScreenController>(context, listen: false).onCreateCustomer(
                              context,
                              image,
                              customerNameTEController.text.trim(),
                              customerMobileTEController.text.trim(),
                              customerEmailTEController.text.trim(),
                              customerStreetTEController.text.trim(),
                              customerStreetTwoTEController.text.trim(),
                              customerCityTEController.text.trim(),
                              customerPinCodeTEController.text.trim(),
                              Provider.of<CustomerScreenController>(context, listen: false)
                                  .countrySelected
                                  .toString(),
                              Provider.of<CustomerScreenController>(context, listen: false)
                                  .stateSelected
                                  .toString());
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
