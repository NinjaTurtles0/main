import 'package:get/get.dart';
import 'package:utm/controllers/popular_product_controller.dart';
import 'package:utm/data/api/api_client.dart';
import 'package:utm/data/repository/popular_product_repo.dart';
import 'package:utm/utils/app_constants.dart';
import 'package:utm/data/repository/recommended_product_repo.dart';
import 'package:utm/controllers/recommended_product_controller.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
//https://mvs.bslmeiyu.com
  //repos//https://www.dbestech.com
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
