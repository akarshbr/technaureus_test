import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: ColorTheme.primaryColor, size: 50),
            Text(
              text,
              style: TextStyle(color: ColorTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
