import 'package:get/get.dart';
import 'package:utm/data/api/api_client.dart';
import 'package:utm/utils/app_constants.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
} //https://www.dbestech.com/api/product/list
///api/v1/product/list