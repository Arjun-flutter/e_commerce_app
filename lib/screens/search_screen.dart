import 'package:ecommer_app/models/appmodel.dart';
import 'package:ecommer_app/provider/cart_provider.dart';
import 'package:ecommer_app/provider/favorite_provider.dart';
import 'package:ecommer_app/provider/product_provider.dart';
import 'package:ecommer_app/screens/cartscreen.dart';
import 'package:ecommer_app/screens/detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductMeta> values;

  const SearchScreen({super.key, required this.values});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final product = context.watch<ProductProvider>();
    final carprv = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(top: 2),
          height: size.height * 0.08,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search for Products",
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: product.search,
          ),
        ),
      ),
      body: product.visibleProducts.isEmpty
          ? Center(
              child: Text(
                "No Products found",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: product.visibleProducts.length,
              itemBuilder: (context, index) {
                final p = product.visibleProducts[index];
                final dataApp = widget.values[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailedPage(itemss: p, app: dataApp),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: size.height * 0.15,
                                  width: size.width * 0.35,
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
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.brand,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    p.title,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
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
                                      Text("(${dataApp.review})"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "\$${p.price.toInt()}",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "\$${p.discountPercentage}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade800,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: 32,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 7,
                                        ),
                                      ),
                                      onPressed: () {
                                        carprv.addToCart(p);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              " Successfully Add to cart",
                                            ),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>  CartScreen(value: widget.values),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.shopping_cart_outlined),
                                      label: Text("Add to Cart"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
