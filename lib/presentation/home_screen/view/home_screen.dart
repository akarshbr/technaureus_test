import 'package:clean_code_demo/core/constants/colors.dart';
import 'package:clean_code_demo/core/static/static_data.dart';
import 'package:clean_code_demo/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:clean_code_demo/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:clean_code_demo/presentation/home_screen/view/widgets/home_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorTheme.bgColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/dummy/brian.jpg"),
                ),
              ),
              IconButton(onPressed: () {}, icon: IconButton(onPressed: () {}, icon: Icon(Icons.menu))),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: size.height * .01, left: size.width * .03, right: size.width * .03),
          child: Consumer<HomeScreenController>(
            builder: (context,controller,_) {
              return GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2, childAspectRatio: 1.2 / 1),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        controller.selectedCard(index);
                        switch(index){
                          case 0: Provider.of<BottomNavigationController>(context,listen: false).currentIndex=2;
                          case 1: Provider.of<BottomNavigationController>(context,listen: false).currentIndex=1;
                        }
                      },
                      child: HomeScreenCard(
                        icon: StaticData.homeScreenCardData[index].icon,
                        text: StaticData.homeScreenCardData[index].text, index: index,
                      ),
                    );
                  });
            }
          ),
        ),
      ),
    );
  }
}
