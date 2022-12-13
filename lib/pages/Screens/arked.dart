import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm/widgets/big_text.dart';
import 'package:utm/utils/color_utils.dart';
import 'package:utm/widgets/small_text.dart';
import 'package:utm/utils/dimensions.dart';
import 'package:utm/widgets/icon_and_text_widget.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        new DotsIndicator(
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
      ],
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
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.all(100.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven
                    ? const Color(0xFFE64A19)
                    : const Color(0xFFFF8A65),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/2017-10-12-modified.png")))),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFFF5F5F5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF424242),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Color(0xFFF5F5F5),
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Color(0xFFF5F5F5),
                    offset: Offset(5, 0),
                  )
                ]),
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bigtext(text: "Chinese Side"),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                            5,
                            (index) => Icon(Icons.star,
                                color: Color(0xFFCDDC39), size: 15)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(text: "4.5"),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(text: "1287"),
                      SizedBox(
                        width: 10,
                      ),
                      SmallText(
                        text: "Comments",
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(
                        icon: Icons.circle_sharp,
                        text: "Normal",
                        iconColor: const Color(0xFFFFA726),
                      ),
                      IconAndTextWidget(
                        icon: Icons.location_on,
                        text: "1.7km",
                        iconColor: const Color(0xFF00796B),
                      ),
                      IconAndTextWidget(
                        icon: Icons.access_time_rounded,
                        text: "32min",
                        iconColor: const Color(0xFFF48FB1),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
