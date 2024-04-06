import 'package:clean_code_demo/core/constants/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen(
      {super.key,
      required this.size,
      required this.customerImage,
      required this.customerName,
      required this.customerID,
      required this.dueAmount,
      required this.customerMobile, required this.customerEmail, required this.street, required this.street2, required this.city, required this.state, required this.pinCode});

  final Size size;
  final String customerImage;
  final String customerName;
  final String customerMobile;
  final String customerEmail;
  final String street;
  final String street2;
  final String city;
  final String state;
  final String pinCode;
  final String customerID;
  final String dueAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: Center(
          child: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        width: size.width,
        height: size.height * .6,
        child: Card(
          color: ColorTheme.bgColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: size.width * .3,
                    width: size.width * .3,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(customerImage), fit: BoxFit.cover),
                        //TODO change to network image
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Name",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "ID",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Due Amount",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Mobile",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Email",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Address",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            ": $customerName",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            ": $customerID",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            ": $dueAmount",
                            style: GlobalTextStyles.customerScreenTS(size: 22,color: Colors.red,fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            ": $customerMobile",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            ": $customerEmail",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            ": $street, $street2\n $city, $state \n $pinCode",
                            style: GlobalTextStyles.customerScreenDetailsTS,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
