import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/Screens/main_food_page.dart';
import 'package:myapp/widgets/big_text.dart';
import '../../utils/colors.dart';
import '../../utils/color_utils.dart';
import '../../widgets/small_text.dart';
import '../../utils/dimensions.dart';
import 'package:myapp/widgets/icon_and_text_widget.dart';

class Arked extends StatefulWidget {
  const Arked({Key? key}) : super(key: key);

  @override
  _ArkedState createState() => _ArkedState();
}

class _ArkedState extends State<Arked> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("E97777"),
                hexStringToColor("FF9F9F"),
                hexStringToColor("FCDDB0")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        new DotsIndicator(
          mainAxisAlignment: MainAxisAlignment.center,
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: Color(0xFFEF6C00),
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ]),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
        transform: matrix,
        child: Stack(children: [
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven
                      ? const Color(0xFFE64A19)
                      : const Color(0xFFFF8A65),
                  image: DecorationImage(
                    //fit: BoxFit.cover,
                      image: AssetImage("assets/2017-10-12-modified.png")))),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: const Text('Arked Meranti'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainFoodPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(const Color(0xFFFF7043)),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return const Color(0xFFFFAB91); //<-- SEE HERE
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
            ),
          ),
        ]));
  }
}