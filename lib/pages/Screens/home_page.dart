import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm/pages/Screens/main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    MainFoodPage(),
    Container(child: Center(child: Text("Next page"))),
    Container(child: Center(child: Text("Next next page"))),
    Container(child: Center(child: Text("Next next next page"))),
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[0],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            //title:  Text("home")
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive,
            ),
            // title:  Text("history")
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            //   title:  Text("cart")
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text("me")),
        ],
      ),
    );
  }
}
