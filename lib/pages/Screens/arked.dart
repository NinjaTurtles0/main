import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../pages/Screens/main_food_page.dart';
import '../../widgets/big_text.dart';
import '../../utils/colors.dart';
import '../../utils/color_utils.dart';
import '../../widgets/small_text.dart';
import '../../utils/dimensions.dart';
import '../../widgets/icon_and_text_widget.dart';

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
  String _backgroundImage = " ";
  String _arkedName = " ";

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
        Align(
          alignment: Alignment.bottomCenter,
          child: new DotsIndicator(
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
        )
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

    String _setImage() {
      if (index == 0) {
        _backgroundImage = "assets/arked_cengal1.png";
      } else if (index == 1) {
        _backgroundImage = "assets/arked_meranti.png";
      } else if (index == 2) {
        _backgroundImage = "assets/arked_angkasa1.png";
      } else if (index == 3) {
        _backgroundImage = "assets/arked_lestari2.png";
      } else {
        _backgroundImage = "assets/arked_perdana.png";
      }
      return _backgroundImage; // here it returns your _backgroundImage value
    }

    String _setName() {
      if (index == 0) {
        _arkedName = "Arked Cengal";
      } else if (index == 1) {
        _arkedName = "Arked Meranti";
      } else if (index == 2) {
        _arkedName = "Arked Angkasa";
      } else if (index == 3) {
        _arkedName = "Arked Lestari";
      } else {
        _arkedName = "Arked Perdana";
      }
      return _arkedName; // here it returns your _backgroundImage value
    }

    return Transform(
        transform: matrix,
        child: Stack(children: [
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: const Text(
                "Choose Your Favourite Arked",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Gistesy',
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                    fontSize: 45),
              )),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 4.0,
                    color: index.isEven
                        ? const Color(0xFFE64A19)
                        : const Color(0xFFFF8A65),
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(_setImage()),
                  ))),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 150),
            child: ElevatedButton(
              child: Text(_setName()),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainFoodPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  //  const Color(0xFFBF360C)
                  index.isEven
                      ? const Color(0xFFE64A19)
                      : const Color(0xFFFF8A65),
                ),
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