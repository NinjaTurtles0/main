import 'package:get/get.dart';
import 'package:myapp/data/api/api_client.dart';
import 'package:myapp/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
} //https://www.dbestech.com/api/product/list
///api/v1/product/list
