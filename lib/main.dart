import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/pages/Screens/home_page.dart';
import 'package:myapp/pages/splash/splash_page.dart';
import 'package:myapp/routes/route_helper.dart';
import '../controllers/popular_product_controller.dart';
import '../pages/cart/cart_page.dart';
import '../pages/Screens/food_page_body.dart';
import '../controllers/recommended_product_controller.dart';
import '../pages/Screens/signin_screen.dart';
import '../pages/food/popular_food_detail.dart';
import '../helper/dependencies.dart' as dep;

void main() async {
  await dep.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAEyUD2nwl89oXzbyM-6_ZQSzjFVGOydV8",
      appId: "1:612047402921:android:9051134e05c7cd149e76b8",
      messagingSenderId: "612047402921",
      projectId: "utmfood-c49b0",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTMFood',
      home: SplashScreen(),
      //initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
    );
  }
}
