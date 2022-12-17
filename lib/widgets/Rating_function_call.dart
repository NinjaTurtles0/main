import 'package:flutter/material.dart';
import '../pages/Screens/rating.dart';

void main() {
  runApp(Rate());
}

class Rate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "UTmFood Rating Control",
        home: RatingsPage());
  }
}

class RatingsPage extends StatefulWidget {
  @override
  _RatingsPage createState() => _RatingsPage();
}

class _RatingsPage extends State<RatingsPage> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("UTMFood Ratings Demo")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Rating((rating) {
                setState(() {
                  _rating = rating;
                });
              }, 5),
              SizedBox(
                  height: 44,
                  child: (_rating != null && _rating != 0)
                      ? Text("You give $_rating star rating to us",
                          style: TextStyle(fontSize: 18))
                      : SizedBox.shrink())
            ],
          ),
        ));
  }
}
