import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/app_config.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

class CustomerScreenCard extends StatelessWidget {
  const CustomerScreenCard(
      {super.key,
      required this.size,
      required this.customerImage,
      required this.customerName,
      required this.customerID,
      required this.customerAddress,
      });

  final Size size;
  final String? customerImage;
  final String? customerName;
  final String? customerID;
  final String? customerAddress;


  @override
  Widget build(BuildContext context) {
    var imageUrl = AppConfig.mediaUrl + customerImage!;
    return Material(
      elevation: 15,
      color: Colors.transparent,
      child: Container(
        height: size.width * .3,
        margin: EdgeInsets.only(top: size.height * .02, left: size.width * .03, right: size.width * .03),
        decoration: BoxDecoration(color: ColorTheme.bgColor, borderRadius: BorderRadius.circular(10)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.width * .25,
                    width: size.width * .25,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(customerImage == ""
                                ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
                                : imageUrl),
                            fit: BoxFit.cover),
                        //TODO change to network image
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(width: 10),
                  VerticalDivider(
                    width: 1,
                    color: Colors.black,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("$customerName",
                      style: GlobalTextStyles.customerScreenTS(fontWeight: FontWeight.bold, size: 20)),
                  Text("ID: $customerID", style: GlobalTextStyles.customerScreenTS(size: 15)),
                  Flexible(
                    child: Text(
                      "$customerAddress",
                      style: GlobalTextStyles.customerScreenTS(size: 15),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Due Amount:",
                          style: GlobalTextStyles.customerScreenTS(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " \$${300 + Random().nextInt(1000-300)}",
                          style: GlobalTextStyles.customerScreenTS(
                              color: Colors.red, fontWeight: FontWeight.bold))
                    ]),
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.phone),
                        SizedBox(width: 5),
                        FaIcon(FontAwesomeIcons.whatsapp)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
