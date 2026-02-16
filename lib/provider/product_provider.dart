import 'package:ecommer_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommer_app/services/product_services.dart';

class ProductProvider extends ChangeNotifier {
  final ProductServices _productServices = ProductServices();

  List<Product> products = [];
  List<Product> visibleProducts = [];
  bool isLoading = false;
  String error = "";

  Future<void> loadProducts() async {
    isLoading = true;

    try {
      products = await _productServices.fetchProducts();
      visibleProducts = products;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // search products
  void search(String query) {
    if (query.isEmpty) {
      visibleProducts = products;
    } else {
      visibleProducts = products
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // filterCategory
  void filterByCategory(String apiCategory) {
    visibleProducts = products
        .where(
          (product) =>
              product.category.toLowerCase() == apiCategory.toLowerCase(),
        )
        .toList();
    notifyListeners();
  }

  // Reset filter
  void resetFilter() {
    visibleProducts = products;
    notifyListeners();
  }
}



