import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:clean_code_demo/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:clean_code_demo/presentation/customer_screen/view/customer_screen.dart';
import 'package:clean_code_demo/presentation/home_screen/view/home_screen.dart';
import 'package:clean_code_demo/presentation/product_screen/view/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Consumer<BottomNavigationController>(builder: (context, controller, _) {
        return IndexedStack(
          index: controller.currentIndex,
          children: [HomeScreen(), ProductScreen(), CustomerScreen()],
        );
      }),
      bottomNavigationBar: Consumer<BottomNavigationController>(builder: (context, controller, _) {
        return Material(
          color: Colors.transparent,
          elevation: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BottomNavigationBar(
                //backgroundColor: Colors.white,
                currentIndex: controller.currentIndex,
                onTap: (index) {
                  controller.currentIndex = index;
                },
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: ColorTheme.primaryColor,
                elevation: 10,
                items: [
                  BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: "Products"),
                  BottomNavigationBarItem(icon: Icon(CupertinoIcons.group_solid), label: "Customers")
                ]),
          ),
        );
      }),
    );
  }
}
