import 'package:clean_code_demo/core/constants/text_styles.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.size});

  final Size size;

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
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 10,
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.search, color: Colors.grey),
                  Text(
                    "Search",
                    style: GlobalTextStyles.productScreenTS(color: Colors.grey),
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
      ),
    );
  }
}
