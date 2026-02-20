import 'package:ecommer_app/models/appmodel.dart';
import 'package:ecommer_app/provider/favorite_provider.dart';
import 'package:ecommer_app/provider/product_provider.dart';
import 'package:ecommer_app/screens/detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesListScreen extends StatelessWidget {
  final String categoryName;

  const CategoriesListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().visibleProducts;

    return Scaffold(
      appBar: AppBar(
          title: Text(categoryName),
          centerTitle: true
      ),
      body: Expanded(
        child: products.isEmpty
            ? Center(
            child: Text("No Products Found"))
            : GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  final p = products[index];
                  final appData = ecommerceApp[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailedPage(itemss: p, app: appData),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Hero(
                                    tag: p.id,
                                    child: Image.network(
                                      p.images[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Consumer<FavoriteProvider>(
                                    builder: (context, value, child) {
                                      final isFav = value.isFavorite(p);

                                      return GestureDetector(
                                        onTap: () {
                                          value.toggleFavorite(p);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              isFav
                                                  ? Icons.favorite
                                                  : Icons.favorite_outline,
                                              size: 18,
                                              color: isFav
                                                  ? Colors.red
                                                  : Colors.orange,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  left: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withValues(
                                        alpha: 0.5,
                                        blue: 0.8,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0,
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              p.rating.toStringAsFixed(1),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.green,
                                              size: 13,
                                            ),
                                            Divider(),
                                            Text("(${appData.review})"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              p.brand,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              p.title,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Text(p.description)
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${p.price.toInt()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFFF6A00),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "\$${p.discountPercentage}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              p.description,
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
