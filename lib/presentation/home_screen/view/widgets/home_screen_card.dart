import 'package:clean_code_demo/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/colors.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({super.key, required this.icon, required this.text, required this.index});

  final IconData icon;
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeScreenController>(context, listen: false);
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            color: controller.selectedIndex == index
                ? ColorTheme.primaryColor
                : ColorTheme.bgColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: controller.selectedIndex == index
                    ? ColorTheme.bgColor
                    : ColorTheme.primaryColor,
                size: 50),
            Text(
              text,
              style: TextStyle(
                  color: controller.selectedIndex == index
                      ? ColorTheme.bgColor
                      : ColorTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
