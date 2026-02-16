import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommer_app/models/product.dart';

class ProductServices {
  final List<String> urls = [
    "https://dummyjson.com/products/category/mens-shirts",
    "https://dummyjson.com/products/category/mens-shoes",
    "https://dummyjson.com/products/category/womens-dresses",
  ];
  
  Future<List<Product>> fetchProducts() async {
    List<Product> allProducts = [];
    for (String url in urls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data["products"];
        allProducts.addAll(
         list.map((e) => Product.fromJson(e)).toList());
      } else {
        throw Exception("Api Fail");
      }
    }
    return allProducts;
  }
}
