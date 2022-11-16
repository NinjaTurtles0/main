import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm/Screens/food_page_body.dart';
import 'package:utm/widgets/big_text.dart';
import 'package:utm/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //showing the header
          Container(
            child: Container(
                margin: EdgeInsets.only(top: 45, bottom: 15),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Bigtext(
                            text: "Malaysia",
                            color: const Color(0xFF26A69A),
                            size: 30),
                        Row(
                          children: [
                            SmallText(
                                text: "Negeri Sembilan",
                                color: const Color(0xFF004D40),
                                size: 25),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Icon(Icons.search, color: Colors.black),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF00897B),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          //showing the body
          FoodPageBody(),
        ],
      ),
    );
  }
}
