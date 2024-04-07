import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/product_screen/controller/product_controller.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, required this.size, required this.type});

  final Size size;
  final String type;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.size.width * .03, right: widget.size.width * .03),
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
                  width: widget.size.width * .6,
                  child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search", border: InputBorder.none, focusedBorder: InputBorder.none),
                      onFieldSubmitted: (searchText) {
                        log("screen -> ${widget.type}");
                        Provider.of<ProductController>(context, listen: false)
                            .searchProduct(context, searchText, widget.size);
                      }),
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
