import 'package:get/get.dart';
import '../../data/repository/recommended_product_repo.dart';
import '../../pages/food/recommended_food_detail.dart';
import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import 'package:get/get.dart';
import '../../widgets/expandable.dart';
import '../../widgets/big_text.dart';
import '../../widgets/app_icon.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("couldn't get products recommended");
    }
  }
}
