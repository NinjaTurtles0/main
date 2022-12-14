import 'package:get/get.dart';
import 'package:myapp/data/repository/recommended_product_repo.dart';
import 'package:myapp/pages/food/recommended_food_detail.dart';
import 'package:myapp/models/products_model.dart';
import 'package:myapp/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:myapp/widgets/expandable.dart';
import 'package:myapp/widgets/big_text.dart';
import 'package:myapp/widgets/app_icon.dart';

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
      print("got products recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
