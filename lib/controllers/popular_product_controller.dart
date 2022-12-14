import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/data/repository/popular_product_repo.dart';
import 'package:myapp/models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got products popular");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      // print("" + _quantity.toString());
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print("decrement" + _quantity.toString());
    }
    update();
  }

  checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: Colors.amber,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > 15) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: Colors.amber,
        colorText: Colors.white,
      );
      return 15;
    } else {
      return quantity;
    }
  }

  void initProduct() {
    _quantity = 0;
  }
}
