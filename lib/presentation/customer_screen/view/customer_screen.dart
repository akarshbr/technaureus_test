import 'package:clean_code_demo/presentation/customer_screen/view/widget/customer_screen_card.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../widget/search_bar.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
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
}
